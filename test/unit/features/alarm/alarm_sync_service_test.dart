import 'package:banxin_calendar/core/database/app_database.dart'
    show AppDatabase;
import 'package:banxin_calendar/core/ids/stable_id_generator.dart';
import 'package:banxin_calendar/core/time/app_clock.dart';
import 'package:banxin_calendar/features/alarm/application/alarm_sync_service.dart';
import 'package:banxin_calendar/features/alarm/data/drift_alarm_repository.dart';
import 'package:banxin_calendar/features/alarm/domain/alarm_entities.dart';
import 'package:banxin_calendar/features/alarm/domain/alarm_repository.dart';
import 'package:banxin_calendar/features/alarm/domain/platform_alarm_service.dart';
import 'package:banxin_calendar/features/schedule/application/resolve_calendar_range.dart';
import 'package:banxin_calendar/features/schedule/application/schedule_application_service.dart';
import 'package:banxin_calendar/features/schedule/data/drift_schedule_repository.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_resolver.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AlarmSyncService', () {
    late AppDatabase database;
    late DriftScheduleRepository scheduleRepository;
    late ScheduleApplicationService scheduleService;
    late AlarmRepository alarmRepository;
    late _FakePlatformAlarmService platform;
    late AlarmSyncService syncService;
    late _MutableClock syncClock;

    setUp(() async {
      database = AppDatabase.inMemory();
      await database.ensureReady();
      scheduleRepository = DriftScheduleRepository(
        database,
        clock: const _FixedClock(),
        idGenerator: _SequenceIdGenerator('audit'),
      );
      scheduleService = ScheduleApplicationService(
        scheduleRepository,
        ResolveCalendarRange(scheduleRepository, ScheduleResolver()),
        idGenerator: _SequenceIdGenerator('schedule'),
      );
      alarmRepository = DriftAlarmRepository(
        database,
        clock: const _FixedClock(),
        idGenerator: _SequenceIdGenerator('link'),
      );
      platform = _FakePlatformAlarmService();
      syncClock = _MutableClock(DateTime.utc(2026, 8, 6));
      syncService = AlarmSyncService(
        alarmRepository,
        platform,
        scheduleService,
        clock: syncClock,
      );
      await scheduleService.saveSetup(_scheduleDraft());
      await alarmRepository.saveTemplate(_template());
    });

    tearDown(() => database.close());

    test(
      'creates workday alarms, skips rest days, and is idempotent',
      () async {
        final range = DateRange(
          start: LocalDate.parse('2026-08-10'),
          end: LocalDate.parse('2026-08-16'),
        );

        final first = await syncService.sync(range);
        final second = await syncService.sync(range);

        expect(first.created, 5);
        expect(first.failed, 0);
        expect(second.created, 0);
        expect(second.kept, 5);
        expect(platform.scheduleCalls, 5);
        expect(platform.managedIds, hasLength(5));
        expect(await alarmRepository.loadInstances(range), hasLength(5));
      },
    );

    test('cancels the old alarm once when a workday becomes rest', () async {
      final range = DateRange(
        start: LocalDate.parse('2026-08-10'),
        end: LocalDate.parse('2026-08-16'),
      );
      await syncService.sync(range);
      final preview = await scheduleService.previewOverride(
        dates: <LocalDate>[LocalDate.parse('2026-08-10')],
        status: DayStatus.rest,
      );
      await scheduleService.applyOverride(preview);

      final changed = await syncService.sync(range);
      final repeated = await syncService.sync(range);

      expect(changed.canceled, 1);
      expect(platform.cancelCalls, 1);
      expect(platform.managedIds, hasLength(4));
      expect(repeated.canceled, 0);
      expect(platform.cancelCalls, 1);
    });

    test(
      'persists failure without rejecting the schedule configuration',
      () async {
        platform.currentCapability = AlarmCapability.permissionRequired;
        final range = DateRange(
          start: LocalDate.parse('2026-08-10'),
          end: LocalDate.parse('2026-08-10'),
        );

        final result = await syncService.sync(range);
        final instances = await alarmRepository.loadInstances(range);

        expect(result.capability, AlarmCapability.permissionRequired);
        expect(result.failed, 1);
        expect(instances.single.status, AlarmInstanceStatus.failed);
        expect(instances.single.errorCode, 'permission_required');
        expect(
          (await scheduleRepository.loadStoredRules()).single.enabled,
          isTrue,
        );
      },
    );

    test('reconciles platform trigger receipts before planning', () async {
      final range = DateRange(
        start: LocalDate.parse('2026-08-10'),
        end: LocalDate.parse('2026-08-10'),
      );
      await syncService.sync(range);
      final scheduled = (await alarmRepository.loadInstances(range)).single;
      platform.triggeredIds.add(scheduled.platformAlarmId);
      platform.managedIds.remove(scheduled.platformAlarmId);
      syncClock.value = DateTime.utc(2026, 8, 10, 1);

      await syncService.sync(range);

      final rows = await database.select(database.alarmInstances).get();
      expect(rows.single.status, AlarmInstanceStatus.triggered.name);
      expect(platform.triggeredIds, isEmpty);
    });
  });
}

ScheduleSetupDraft _scheduleDraft() => ScheduleSetupDraft(
  mode: SchedulePresetMode.fiveDay,
  ruleName: 'Default',
  shiftName: 'Day',
  shiftShortName: 'D',
  startMinute: 9 * 60,
  endMinute: 18 * 60,
  crossDay: false,
  unpaidBreakMinutes: 60,
  anchorDate: LocalDate.parse('2026-08-03'),
  customCycleWorkPattern: const <bool>[true, false],
  shiftId: ShiftId('default-shift'),
  ruleId: RuleId('default-rule'),
);

AlarmTemplate _template() => AlarmTemplate(
  id: 'work-alarm',
  name: 'Work reminder',
  mode: AlarmTemplateMode.relativeToShiftStart,
  offsetMinutes: -90,
  vibrate: true,
  volumeRamp: false,
  snoozeMinutes: 10,
  maxSnoozeCount: 3,
  enabled: true,
  shiftIds: <ShiftId>{ShiftId('default-shift')},
);

final class _FakePlatformAlarmService implements PlatformAlarmService {
  AlarmCapability currentCapability = AlarmCapability.available;
  final Set<String> managedIds = <String>{};
  final Set<String> triggeredIds = <String>{};
  var scheduleCalls = 0;
  var cancelCalls = 0;

  @override
  Future<AlarmCapability> capability() async => currentCapability;

  @override
  Future<AlarmCapability> requestCapability() async => currentCapability;

  @override
  Future<void> schedule(PlatformAlarmRequest request) async {
    scheduleCalls++;
    managedIds.add(request.platformAlarmId);
  }

  @override
  Future<void> cancel(String platformAlarmId) async {
    cancelCalls++;
    managedIds.remove(platformAlarmId);
  }

  @override
  Future<Set<String>> listManagedAlarmIds() async => Set<String>.of(managedIds);

  @override
  Future<Set<String>> consumeTriggeredAlarmIds() async {
    final result = Set<String>.of(triggeredIds);
    triggeredIds.clear();
    return result;
  }
}

final class _FixedClock implements AppClock {
  const _FixedClock();

  @override
  DateTime nowUtc() => DateTime.utc(2026, 8, 6);
}

final class _MutableClock implements AppClock {
  _MutableClock(this.value);

  DateTime value;

  @override
  DateTime nowUtc() => value;
}

final class _SequenceIdGenerator implements StableIdGenerator {
  _SequenceIdGenerator(this.prefix);

  final String prefix;
  var _next = 0;

  @override
  String generate() => '$prefix-${_next++}';
}
