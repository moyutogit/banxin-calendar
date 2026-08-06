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
  }) async* {
    final trimmed = userText.trim();
    if (trimmed.isEmpty) return;
    final now = _clock.nowUtc();
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
            (message) =>
                LlmMessage(role: message.role, content: message.content),
          ),
    ];
    final definitions = await _toolDefinitions();
    final buffer = StringBuffer();
    var rounds = 0;
    while (rounds++ < 3) {
      LlmToolCall? toolCall;
      await for (final event in _provider.chat(
        messages: messages,
        tools: definitions,
        config: config,
        credential: secrets.$1,
        customHeaders: secrets.$2,
      )) {
        switch (event) {
          case LlmTextDelta():
            buffer.write(event.text);
            yield ConversationTextDelta(event.text);
          case LlmToolCall():
            toolCall = event;
          case LlmCompleted():
            break;
        }
      }
      if (toolCall == null) break;
      final result = await _tools.execute(
        name: toolCall.name,
        arguments: toolCall.arguments,
        persona: settings.persona,
        conversationId: conversationId,
      );
      if (result['requiresConfirmation'] == true) {
        final summary = result['summary']! as String;
        await _saveAssistant(conversationId, summary, localOnly: true);
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
          role: LlmRole.system,
          content:
              'Verified local tool result for ${toolCall.name}: ${jsonEncode(result)}',
        ),
      );
      toolCall = null;
    }
    final response = buffer.toString();
    if (response.isNotEmpty) await _saveAssistant(conversationId, response);
    yield const ConversationFinished();
  }

  Future<String> _systemPrompt(AssistantPersona persona) async =>
      'Current app capabilities:\n${await _knowledge.capabilities()}\n'
      'Feature help:\n${await _knowledge.featureHelp()}\n'
      'Safety rules:\n${await _knowledge.safetyRules()}\n'
      'Persona: ${persona.preset.name}, reply length: ${persona.replyLength.name}. '
      'Personality changes wording only, never facts, permissions, or tool parameters.';

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

  Future<void> _saveAssistant(
    String conversationId,
    String content, {
    bool localOnly = false,
  }) {
    return _repository.saveMessage(
      AssistantMessage(
        id: _idGenerator.generate(),
        conversationId: conversationId,
        role: LlmRole.assistant,
        content: content,
        contentType: 'text',
        localOnly: localOnly,
        createdAtUtc: _clock.nowUtc(),
      ),
    );
  }
}
