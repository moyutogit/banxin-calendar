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
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';

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

  Future<Conversation> createConversation() async {
    final config = await _repository.loadProviderConfig();
    final now = _clock.nowUtc();
    return _repository.createConversation(
      Conversation(
        id: _idGenerator.generate(),
        title: '新对话',
        modelSnapshotJson: jsonEncode(<String, Object?>{
          'provider': config?.providerType.name,
          'model': config?.modelName,
        }),
        createdAtUtc: now,
        updatedAtUtc: now,
      ),
    );
  }

  Future<Conversation> loadOrCreateConversation() async {
    final conversations = await _repository.loadConversations();
    return conversations.firstOrNull ?? createConversation();
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
        } on FormatException {
          result = <String, Object?>{
            'succeeded': false,
            'error': 'invalid_tool_arguments',
            'guidance':
                'Retry this tool with an explicit ISO date range containing start and end.',
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
    final shanghaiNow = _clock.nowUtc().add(const Duration(hours: 8));
    final currentDate = LocalDate(
      shanghaiNow.year,
      shanghaiNow.month,
      shanghaiNow.day,
    );
    return 'Current application date (Asia/Shanghai): $currentDate. '
        'Resolve relative dates such as today, this month, and the next 7 days '
        'from this date and call the matching local read tool directly; do not '
        'ask the user to provide today\'s date.\n'
        'Current app capabilities:\n${await _knowledge.capabilities()}\n'
        'Feature help:\n${await _knowledge.featureHelp()}\n'
        'Safety rules:\n${await _knowledge.safetyRules()}\n'
        'Persona: ${persona.preset.name}, reply length: ${persona.replyLength.name}. '
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
}
