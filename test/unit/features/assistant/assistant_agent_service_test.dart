import 'package:banxin_calendar/core/database/app_database.dart'
    hide AssistantMemory, AssistantPersona, Conversation;
import 'package:banxin_calendar/core/ids/stable_id_generator.dart';
import 'package:banxin_calendar/core/time/app_clock.dart';
import 'package:banxin_calendar/features/assistant/application/assistant_agent_service.dart';
import 'package:banxin_calendar/features/assistant/application/tool_gateway.dart';
import 'package:banxin_calendar/features/assistant/data/drift_assistant_repository.dart';
import 'package:banxin_calendar/features/assistant/domain/assistant_entities.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AssistantAgentService', () {
    late AppDatabase database;
    late DriftAssistantRepository repository;
    late AssistantAgentService service;

    setUp(() async {
      database = AppDatabase.inMemory();
      await database.ensureReady();
      const clock = _FixedClock();
      repository = DriftAssistantRepository(database, clock: clock);
      service = AssistantAgentService(
        repository,
        clock: clock,
        idGenerator: _SequenceIds(),
      );
      await repository.createConversation(
        Conversation(
          id: 'conversation',
          title: '新对话',
          modelSnapshotJson: '{}',
          createdAtUtc: clock.nowUtc(),
          updatedAtUtc: clock.nowUtc(),
        ),
      );
    });

    tearDown(() => database.close());

    test('returns exact Asia/Shanghai relative dates', () {
      expect(ToolGateway.supportedTools, contains('get_time_context'));
      final result = service.timeContext();
      final dates = result['relativeDates']! as Map<String, Object?>;

      expect(result['timezone'], 'Asia/Shanghai');
      expect(result['localDateTime'], '2026-08-06T12:34:56+08:00');
      expect(dates['yesterday'], '2026-08-05');
      expect(dates['today'], '2026-08-06');
      expect(dates['tomorrow'], '2026-08-07');
      expect(dates['dayAfterTomorrow'], '2026-08-08');
      expect(dates['tomorrowThroughDayAfterTomorrow'], <String, String>{
        'start': '2026-08-07',
        'end': '2026-08-08',
      });
    });

    test('saves memory only after an explicit remember request', () async {
      await _saveUser(repository, '请记住我不吃香菜');
      final memory = await service.remember(
        conversationId: 'conversation',
        arguments: const <String, Object?>{
          'content': '用户不吃香菜',
          'category': 'personalFact',
        },
      );

      expect(memory.id, 'id-1');
      expect((await repository.loadMemories()).single.content, '用户不吃香菜');

      await _saveUser(repository, '今天天气怎么样', secondOffset: 1);
      await expectLater(
        service.remember(
          conversationId: 'conversation',
          arguments: const <String, Object?>{
            'content': '任意信息',
            'category': 'other',
          },
        ),
        throwsA(isA<FormatException>()),
      );
    });

    test(
      'updates the locally persisted agent profile from explicit style',
      () async {
        await _saveUser(repository, '以后叫你小毒，性格毒舌，回复精炼');
        final updated = await service.updateProfile(
          current: await repository.loadPersona(),
          conversationId: 'conversation',
          arguments: const <String, Object?>{
            'display_name': '小毒',
            'persona': 'sarcastic',
            'reply_length': 'short',
          },
        );

        expect(updated.displayName, '小毒');
        expect(updated.preset, AssistantPersonaPreset.sarcastic);
        expect(
          (await repository.loadPersona()).replyLength,
          AssistantReplyLength.short,
        );
      },
    );
  });
}

Future<void> _saveUser(
  DriftAssistantRepository repository,
  String content, {
  int secondOffset = 0,
}) {
  return repository.saveMessage(
    AssistantMessage(
      id: 'message-${content.hashCode}',
      conversationId: 'conversation',
      role: LlmRole.user,
      content: content,
      contentType: 'text',
      localOnly: false,
      createdAtUtc: const _FixedClock().nowUtc().add(
        Duration(seconds: secondOffset),
      ),
    ),
  );
}

final class _FixedClock implements AppClock {
  const _FixedClock();

  @override
  DateTime nowUtc() => DateTime.utc(2026, 8, 6, 4, 34, 56);
}

final class _SequenceIds implements StableIdGenerator {
  var _next = 1;

  @override
  String generate() => 'id-${_next++}';
}
