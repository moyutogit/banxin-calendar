import 'dart:convert';

import 'package:banxin_calendar/core/ids/stable_id_generator.dart';
import 'package:banxin_calendar/core/time/app_clock.dart';
import 'package:banxin_calendar/features/assistant/application/assistant_settings_service.dart';
import 'package:banxin_calendar/features/assistant/application/tool_gateway.dart';
import 'package:banxin_calendar/features/assistant/domain/assistant_entities.dart';
import 'package:banxin_calendar/features/assistant/domain/assistant_repository.dart';
import 'package:banxin_calendar/features/assistant/domain/assistant_safety_policy.dart';
import 'package:banxin_calendar/features/assistant/domain/capability_knowledge_source.dart';
import 'package:banxin_calendar/features/assistant/domain/llm_provider.dart';

sealed class ConversationEvent {
  const ConversationEvent();
}

final class ConversationTextDelta extends ConversationEvent {
  const ConversationTextDelta(this.text);

  final String text;
}

final class ConversationReasoningDelta extends ConversationEvent {
  const ConversationReasoningDelta(this.text);

  final String text;
}

final class ConversationProposal extends ConversationEvent {
  const ConversationProposal({
    required this.actionId,
    required this.confirmationToken,
    required this.summary,
  });

  final String actionId;
  final String confirmationToken;
  final String summary;
}

final class ConversationFinished extends ConversationEvent {
  const ConversationFinished();
}

final class ConversationService {
  ConversationService(
    this._repository,
    this._settings,
    this._provider,
    this._knowledge,
    this._tools, {
    this._clock = const SystemAppClock(),
    this._safetyPolicy = const AssistantSafetyPolicy(),
    StableIdGenerator? idGenerator,
  }) : _idGenerator = idGenerator ?? UuidV4Generator();

  final AssistantRepository _repository;
  final AssistantSettingsService _settings;
  final LlmProvider _provider;
  final CapabilityKnowledgeSource _knowledge;
  final ToolGateway _tools;
  final AppClock _clock;
  final AssistantSafetyPolicy _safetyPolicy;
  final StableIdGenerator _idGenerator;

  Future<Conversation> createConversation({bool includeWelcome = false}) async {
    final config = await _repository.loadProviderConfig();
    final now = _clock.nowUtc();
    final id = _idGenerator.generate();
    final conversation = Conversation(
      id: id,
      title: includeWelcome ? '认识一下' : '新对话',
      modelSnapshotJson: jsonEncode(<String, Object?>{
        'provider': config?.providerType.name,
        'model': config?.modelName,
      }),
      createdAtUtc: now,
      updatedAtUtc: now,
    );
    return _repository.createConversation(
      conversation,
      initialMessage: includeWelcome
          ? AssistantMessage(
              id: _idGenerator.generate(),
              conversationId: id,
              role: LlmRole.assistant,
              content: _firstConversationWelcome,
              contentType: 'onboarding',
              localOnly: false,
              createdAtUtc: now,
            )
          : null,
    );
  }

  Future<Conversation> loadOrCreateConversation() async {
    final conversations = await _repository.loadConversations();
    return conversations.firstOrNull ??
        createConversation(includeWelcome: true);
  }

  Future<List<Conversation>> loadConversations() {
    return _repository.loadConversations();
  }

  Future<List<AssistantMessage>> loadMessages(String conversationId) {
    return _repository.loadMessages(conversationId);
  }

  Stream<ConversationEvent> send({
    required String conversationId,
    required String userText,
    bool saveUserMessage = true,
  }) async* {
    final trimmed = userText.trim();
    if (trimmed.isEmpty) return;
    final now = _clock.nowUtc();
    if (saveUserMessage) {
      await _repository.saveMessage(
        AssistantMessage(
          id: _idGenerator.generate(),
          conversationId: conversationId,
          role: LlmRole.user,
          content: trimmed,
          contentType: 'text',
          localOnly: false,
          createdAtUtc: now,
        ),
      );
      await _repository.updateConversationTitle(
        conversationId,
        String.fromCharCodes(trimmed.runes.take(18)),
      );
    }
    if (_safetyPolicy.mustRefuse(trimmed)) {
      const refusal = '该请求涉及跳过确认、读取密钥或执行代码，已按安全规则拒绝。';
      await _saveAssistant(conversationId, refusal, localOnly: true);
      yield const ConversationTextDelta(refusal);
      yield const ConversationFinished();
      return;
    }
    final settings = await _settings.load();
    final config = settings.config;
    if (config == null) throw StateError('AI provider is not configured.');
    final secrets = await _settings.secrets(config);
    final history = await _repository.loadMessages(conversationId);
    final messages = <LlmMessage>[
      LlmMessage(
        role: LlmRole.system,
        content: await _systemPrompt(settings.persona),
      ),
      ...history
          .where((message) => !message.localOnly)
          .map(
            (message) => LlmMessage(
              role: message.role,
              content: message.content,
              reasoningContent: message.reasoningContent,
              toolCallId: message.toolCallId,
            ),
          ),
    ];
    final definitions = await _toolDefinitions();
    final responseBuffer = StringBuffer();
    final reasoningBuffer = StringBuffer();
    var rounds = 0;
    while (rounds++ < 5) {
      final roundText = StringBuffer();
      final roundReasoning = StringBuffer();
      final toolCalls = <LlmToolCall>[];
      await for (final event in _provider.chat(
        messages: messages,
        tools: definitions,
        config: config,
        credential: secrets.$1,
        customHeaders: secrets.$2,
      )) {
        switch (event) {
          case LlmTextDelta():
            roundText.write(event.text);
            responseBuffer.write(event.text);
            yield ConversationTextDelta(event.text);
          case LlmReasoningDelta():
            if (roundReasoning.isEmpty && reasoningBuffer.isNotEmpty) {
              reasoningBuffer.write('\n\n');
              yield const ConversationReasoningDelta('\n\n');
            }
            roundReasoning.write(event.text);
            reasoningBuffer.write(event.text);
            yield ConversationReasoningDelta(event.text);
          case LlmToolCall():
            toolCalls.add(event);
          case LlmCompleted():
            break;
        }
      }
      if (toolCalls.isEmpty) break;
      messages.add(
        LlmMessage(
          role: LlmRole.assistant,
          content: roundText.toString(),
          reasoningContent: roundReasoning.toString(),
          toolCalls: toolCalls,
        ),
      );
      for (final toolCall in toolCalls) {
        late final Map<String, Object?> result;
        try {
          result = await _tools.execute(
            name: toolCall.name,
            arguments: toolCall.arguments,
            persona: settings.persona,
            conversationId: conversationId,
          );
        } on ToolPermissionException catch (error) {
          final response = _permissionMessage(error.scope);
          await _saveAssistant(
            conversationId,
            response,
            localOnly: true,
            reasoningContent: reasoningBuffer.toString(),
          );
          yield ConversationTextDelta(response);
          yield const ConversationFinished();
          return;
        } on FormatException catch (error) {
          result = <String, Object?>{
            'succeeded': false,
            'error': 'invalid_tool_arguments',
            'guidance': error.message.toString(),
          };
        }
        if (result['requiresConfirmation'] == true) {
          final summary = result['summary']! as String;
          await _saveAssistant(
            conversationId,
            summary,
            localOnly: true,
            reasoningContent: reasoningBuffer.toString(),
          );
          yield ConversationProposal(
            actionId: result['actionId']! as String,
            confirmationToken: result['confirmationToken']! as String,
            summary: summary,
          );
          yield const ConversationFinished();
          return;
        }
        messages.add(
          LlmMessage(
            role: LlmRole.tool,
            content: jsonEncode(result),
            toolCallId: toolCall.id,
          ),
        );
      }
    }
    final response = responseBuffer.toString();
    if (response.isNotEmpty) {
      await _saveAssistant(
        conversationId,
        response,
        reasoningContent: reasoningBuffer.toString(),
      );
    }
    yield const ConversationFinished();
  }

  Future<String> _systemPrompt(AssistantPersona persona) async {
    return 'You are a local-first app agent, not a plain chat bot. '
        'For every request containing a relative date or time (including today, '
        'yesterday, tomorrow, the day after tomorrow, 明后天, this week/month, '
        'or the next N days), first call get_time_context. Use only the returned '
        'Asia/Shanghai ISO dates to construct the range for the matching local '
        'read tool. Never guess the current date and never ask the user for it.\n'
        'The first assistant welcome asks for the agent name, personality, and '
        'response style. When the user answers that question or later explicitly '
        'changes those preferences, call update_agent_profile before replying.\n'
        'Use get_memories only when saved context is relevant. Call save_memory '
        'only when the latest user message explicitly asks you to remember '
        'something, and call delete_memory only after an explicit forget request. '
        'Never claim a memory was saved or deleted unless the tool succeeds.\n'
        'Current app capabilities:\n${await _knowledge.capabilities()}\n'
        'Feature help:\n${await _knowledge.featureHelp()}\n'
        'Safety rules:\n${await _knowledge.safetyRules()}\n'
        'Agent name: ${persona.displayName}. Persona: ${persona.preset.name}, '
        'reply length: ${persona.replyLength.name}, style instruction: '
        '${persona.customInstruction ?? 'none'}. '
        'Personality changes wording only, never facts, permissions, or tool parameters.';
  }

  Future<List<ToolDefinition>> _toolDefinitions() async {
    final decoded =
        jsonDecode(await _knowledge.toolDefinitions()) as Map<String, Object?>;
    final tools = decoded['tools']! as List<Object?>;
    return tools.map((raw) {
      final tool = raw! as Map<String, Object?>;
      return ToolDefinition(
        name: tool['name']! as String,
        description: tool['description']! as String,
        parametersSchema: tool['parameters']! as Map<String, Object?>,
      );
    }).toList();
  }

  String _permissionMessage(String scope) {
    final label = switch (scope) {
      'schedule' => '排班',
      'attendance' => '出勤',
      'wage' => '工资',
      'alarm' => '闹钟',
      'notes' => '备注',
      'memory' => '智能体记忆',
      _ => '对应',
    };
    return '当前未授权读取$label数据。请先在“配置 AI 模型”的助理权限中开启后再试。';
  }

  Future<void> _saveAssistant(
    String conversationId,
    String content, {
    bool localOnly = false,
    String? reasoningContent,
  }) {
    return _repository.saveMessage(
      AssistantMessage(
        id: _idGenerator.generate(),
        conversationId: conversationId,
        role: LlmRole.assistant,
        content: content,
        reasoningContent: reasoningContent?.isEmpty ?? true
            ? null
            : reasoningContent,
        contentType: 'text',
        localOnly: localOnly,
        createdAtUtc: _clock.nowUtc(),
      ),
    );
  }

  static const String _firstConversationWelcome =
      '嗨，我们先把我变成你喜欢的助理吧。你希望我叫什么？性格和说话方式是什么？'
      '可以选温柔、专业、活泼、幽默风趣、吐槽毒舌或冷静；回复偏精炼、适中还是啰嗦。'
      '直接一句话告诉我就行，例如：“叫你小毒，冷静毒舌，回复精炼”。';
}
