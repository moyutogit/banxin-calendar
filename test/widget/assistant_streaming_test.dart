import 'dart:async';

import 'package:banxin_calendar/app/localization/generated/app_localizations.dart';
import 'package:banxin_calendar/core/database/app_database.dart'
    hide AiProviderConfig;
import 'package:banxin_calendar/core/database/database_providers.dart';
import 'package:banxin_calendar/core/secure_storage/secure_storage_providers.dart';
import 'package:banxin_calendar/core/secure_storage/secure_value_store.dart';
import 'package:banxin_calendar/features/assistant/application/assistant_providers.dart';
import 'package:banxin_calendar/features/assistant/domain/assistant_entities.dart';
import 'package:banxin_calendar/features/assistant/domain/capability_knowledge_source.dart';
import 'package:banxin_calendar/features/assistant/domain/llm_provider.dart';
import 'package:banxin_calendar/features/assistant/presentation/assistant_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'shows first-agent onboarding and switches between conversations',
    (tester) async {
      final fixture = await _AssistantFixture.create();
      addTearDown(fixture.dispose);
      await tester.pumpWidget(fixture.app);
      await tester.pumpAndSettle();

      expect(find.textContaining('你希望我叫什么'), findsOneWidget);
      await tester.tap(find.byTooltip('开启新对话'));
      await tester.pumpAndSettle();
      expect(find.textContaining('新对话已开启'), findsOneWidget);

      await tester.tap(find.byTooltip('对话列表'));
      await tester.pumpAndSettle();
      expect(find.text('认识一下'), findsOneWidget);
      expect(find.text('新对话'), findsOneWidget);

      await tester.tap(find.text('认识一下'));
      await tester.pumpAndSettle();
      expect(find.textContaining('你希望我叫什么'), findsOneWidget);
    },
  );

  testWidgets('sends optimistically and streams collapsible reasoning', (
    tester,
  ) async {
    final fixture = await _AssistantFixture.create();
    addTearDown(fixture.dispose);
    await tester.pumpWidget(fixture.app);
    await tester.pumpAndSettle();

    final input = find.byType(TextField);
    expect(input, findsOneWidget);
    await tester.enterText(input, '立即显示这条消息');
    await tester.tap(find.byTooltip('发送'));
    await tester.pump();

    expect(find.text('立即显示这条消息'), findsOneWidget);
    expect(tester.widget<TextField>(input).controller!.text, isEmpty);
    expect(find.text('正在准备回复…'), findsOneWidget);

    final response = await fixture.provider.nextResponse(tester);
    response.add(const LlmReasoningDelta('先读取本地排班。'));
    await tester.pump();
    await tester.pump();
    expect(find.text('正在思考…'), findsOneWidget);
    expect(find.text('先读取本地排班。'), findsOneWidget);

    response.add(const LlmTextDelta('这是流式回复。'));
    await tester.pump();
    await tester.pump();
    expect(find.text('这是流式回复。'), findsOneWidget);
    response.add(const LlmCompleted());
    await response.close();
    await tester.pumpAndSettle();

    expect(find.text('思考过程'), findsOneWidget);
    await tester.tap(find.text('思考过程'));
    await tester.pumpAndSettle();
    expect(find.text('先读取本地排班。'), findsOneWidget);
    final stored = await fixture.database
        .select(fixture.database.messages)
        .get();
    expect(stored.last.reasoningContent, '先读取本地排班。');
    expect(stored.last.content, '这是流式回复。');
  });

  testWidgets('quick query appears immediately and ignores repeated taps', (
    tester,
  ) async {
    final fixture = await _AssistantFixture.create();
    addTearDown(fixture.dispose);
    await tester.pumpWidget(fixture.app);
    await tester.pumpAndSettle();

    final quick = find.text('查看未来 7 天排班');
    await tester.tap(quick);
    await tester.tap(quick);
    await tester.pump();

    expect(find.text('查看未来 7 天排班'), findsNWidgets(2));
    expect(find.text('正在准备回复…'), findsOneWidget);
    final response = await fixture.provider.nextResponse(tester);
    response.add(const LlmTextDelta('未来七天排班已读取。'));
    response.add(const LlmCompleted());
    await response.close();
    await tester.pumpAndSettle();

    final userMessages = await fixture.database
        .customSelect(
          "SELECT COUNT(*) AS count FROM messages WHERE role = 'user'",
        )
        .getSingle();
    expect(userMessages.read<int>('count'), 1);
  });

  testWidgets(
    'quick tool query replays DeepSeek reasoning before final answer',
    (tester) async {
      final fixture = await _AssistantFixture.create();
      addTearDown(fixture.dispose);
      await tester.pumpWidget(fixture.app);
      await tester.pumpAndSettle();

      await tester.tap(find.text('检查闹钟'));
      await tester.pump();
      final firstResponse = await fixture.provider.nextResponse(tester);
      firstResponse.add(const LlmReasoningDelta('需要读取本地闹钟。'));
      firstResponse.add(
        const LlmToolCall(
          id: 'alarm-call',
          name: 'get_alarm_summary',
          arguments: <String, Object?>{},
        ),
      );
      firstResponse.add(const LlmCompleted());
      await firstResponse.close();

      final finalResponse = await fixture.provider.nextResponse(tester);
      final replay = fixture.provider.requests[1];
      final assistant = replay.firstWhere(
        (message) => message.toolCalls.isNotEmpty,
      );
      final tool = replay.firstWhere((message) => message.role == LlmRole.tool);
      expect(assistant.reasoningContent, '需要读取本地闹钟。');
      expect(assistant.toolCalls.single.id, 'alarm-call');
      expect(tool.toolCallId, 'alarm-call');

      finalResponse.add(const LlmReasoningDelta('本地结果已返回。'));
      finalResponse.add(const LlmTextDelta('当前没有即将响铃的闹钟。'));
      finalResponse.add(const LlmCompleted());
      await finalResponse.close();
      await tester.pumpAndSettle();

      expect(find.text('当前没有即将响铃的闹钟。'), findsOneWidget);
      expect(find.text('AI 请求失败，请检查模型连接后重试'), findsNothing);
    },
  );
}

final class _AssistantFixture {
  _AssistantFixture(this.database, this.provider, this.store);

  final AppDatabase database;
  final _ControlledLlmProvider provider;
  final _MemorySecureStore store;

  Widget get app => ProviderScope(
    overrides: <Override>[
      appDatabaseProvider.overrideWithValue(database),
      llmProviderProvider.overrideWithValue(provider),
      capabilityKnowledgeSourceProvider.overrideWithValue(
        const _FakeKnowledge(),
      ),
      secureValueStoreProvider.overrideWithValue(store),
    ],
    child: MaterialApp(
      locale: const Locale('zh'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const Scaffold(body: AssistantPage()),
    ),
  );

  static Future<_AssistantFixture> create() async {
    final database = AppDatabase.inMemory();
    await database.ensureReady();
    await database.customStatement('''
      INSERT INTO ai_provider_configs (
        id, provider_type, base_url, endpoint_path, model_name,
        credential_ref, custom_headers_ref, timeout_seconds,
        max_output_tokens, stream_enabled, connection_status,
        last_tested_at, created_at, updated_at
      ) VALUES (
        'provider', 'openAiCompatible', 'https://example.com/',
        'v1/chat/completions', 'test-model', 'credential-ref', NULL,
        30, 1024, 1, 'connected', NULL, 1, 1
      )
    ''');
    return _AssistantFixture(
      database,
      _ControlledLlmProvider(),
      _MemorySecureStore(<String, String>{'credential-ref': 'test-key'}),
    );
  }

  Future<void> dispose() async {
    await provider.close();
    await database.close();
  }
}

final class _FakeKnowledge implements CapabilityKnowledgeSource {
  const _FakeKnowledge();

  @override
  Future<String> capabilities() async => '{}';

  @override
  Future<String> featureHelp() async => '{}';

  @override
  Future<String> safetyRules() async => 'Keep data local.';

  @override
  Future<String> toolDefinitions() async => '{"tools":[]}';
}

final class _ControlledLlmProvider implements LlmProvider {
  final List<StreamController<LlmEvent>> _responses =
      <StreamController<LlmEvent>>[];
  final List<List<LlmMessage>> requests = <List<LlmMessage>>[];

  @override
  Stream<LlmEvent> chat({
    required List<LlmMessage> messages,
    required List<ToolDefinition> tools,
    required AiProviderConfig config,
    required String credential,
    required Map<String, String> customHeaders,
  }) {
    requests.add(List<LlmMessage>.unmodifiable(messages));
    final response = StreamController<LlmEvent>();
    _responses.add(response);
    return response.stream;
  }

  Future<StreamController<LlmEvent>> nextResponse(WidgetTester tester) async {
    for (var attempt = 0; attempt < 40 && _responses.isEmpty; attempt++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 5)),
      );
      await tester.pump(const Duration(milliseconds: 10));
    }
    expect(_responses, isNotEmpty);
    return _responses.removeAt(0);
  }

  Future<void> close() async {
    for (final response in _responses) {
      if (!response.isClosed) await response.close();
    }
  }

  @override
  Future<ConnectionTestResult> testConnection({
    required AiProviderConfig config,
    required String credential,
    required Map<String, String> customHeaders,
  }) async => const ConnectionTestResult(AiConnectionStatus.connected);
}

final class _MemorySecureStore implements SecureValueStore {
  _MemorySecureStore(this.values);

  final Map<String, String> values;

  @override
  Future<void> delete({required String reference}) async {
    values.remove(reference);
  }

  @override
  Future<String?> read({required String reference}) async => values[reference];

  @override
  Future<void> write({required String reference, required String value}) async {
    values[reference] = value;
  }
}
