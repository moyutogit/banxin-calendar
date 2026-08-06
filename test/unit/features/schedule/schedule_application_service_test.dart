import 'package:banxin_calendar/core/database/app_database.dart';
import 'package:banxin_calendar/core/ids/stable_id_generator.dart';
import 'package:banxin_calendar/core/time/app_clock.dart';
import 'package:banxin_calendar/features/schedule/application/resolve_calendar_range.dart';
import 'package:banxin_calendar/features/schedule/application/schedule_application_service.dart';
import 'package:banxin_calendar/features/schedule/data/drift_schedule_repository.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_resolver.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ScheduleApplicationService', () {
    late AppDatabase database;
    late DriftScheduleRepository repository;
    late ScheduleApplicationService service;

    setUp(() async {
      database = AppDatabase.inMemory();
      await database.ensureReady();
      repository = DriftScheduleRepository(
        database,
        clock: _FixedClock(),
        idGenerator: _SequenceIdGenerator('audit'),
      );
      service = ScheduleApplicationService(
        repository,
        ResolveCalendarRange(repository, ScheduleResolver()),
        idGenerator: _SequenceIdGenerator('entity'),
      );
    });

    tearDown(() => database.close());

    test('previews 14 days and atomically saves a five-day setup', () async {
      final draft = _draft(SchedulePresetMode.fiveDay);

      final preview = await service.previewSetup(
        draft,
        previewStart: LocalDate.parse('2026-08-03'),
      );

      expect(preview.days, hasLength(14));
      expect(preview.days.first.status, DayStatus.work);
      expect(preview.days[5].status, DayStatus.rest);

      await service.saveSetup(draft);
      final calendar = await service.loadCalendar(
        DateRange(
          start: LocalDate.parse('2026-08-03'),
          end: LocalDate.parse('2026-08-16'),
        ),
      );

      expect(calendar.configured, isTrue);
      expect(calendar.days, hasLength(14));
      expect((await service.loadRulesView()).rules, hasLength(1));
      final audit = await database.select(database.changeLog).get();
      expect(
        audit.where((row) => row.entityId == 'default-rule'),
        hasLength(1),
      );
      expect(
        audit.where((row) => row.entityId == 'default-shift'),
        hasLength(1),
      );
    });

    test('supports a 1-31 day custom cycle', () async {
      final preview = await service.previewSetup(
        _draft(
          SchedulePresetMode.customCycle,
          customPattern: const <bool>[true, true, false, false],
        ),
        previewStart: LocalDate.parse('2026-08-03'),
      );

      expect(preview.days.take(8).map((day) => day.status), <DayStatus>[
        DayStatus.work,
        DayStatus.work,
        DayStatus.rest,
        DayStatus.rest,
        DayStatus.work,
        DayStatus.work,
        DayStatus.rest,
        DayStatus.rest,
      ]);
    });

    test('previews, applies, and restores a batch override', () async {
      await service.saveSetup(_draft(SchedulePresetMode.sixDay));
      final dates = <LocalDate>[
        LocalDate.parse('2026-08-03'),
        LocalDate.parse('2026-08-04'),
      ];

      final preview = await service.previewOverride(
        dates: dates,
        status: DayStatus.rest,
      );
      expect(preview.originalStatusCounts, <DayStatus, int>{DayStatus.work: 2});

      await service.applyOverride(preview);
      var calendar = await service.loadCalendar(
        DateRange(start: dates.first, end: dates.last),
      );
      expect(
        calendar.days.map((day) => day.status),
        everyElement(DayStatus.rest),
      );
      expect(
        calendar.days.map((day) => day.source),
        everyElement(DaySource.userOverride),
      );

      await service.restoreRuleResult(
        DateRange(start: dates.first, end: dates.last),
      );
      calendar = await service.loadCalendar(
        DateRange(start: dates.first, end: dates.last),
      );
      expect(
        calendar.days.map((day) => day.status),
        everyElement(DayStatus.work),
      );
    });

    test('loads a cached calendar month within the 300 ms target', () async {
      await service.saveSetup(_draft(SchedulePresetMode.fiveDay));
      final range = DateRange(
        start: LocalDate.parse('2026-08-01'),
        end: LocalDate.parse('2026-08-31'),
      );
      await service.loadCalendar(range);

      final stopwatch = Stopwatch()..start();
      final calendar = await service.loadCalendar(range);
      stopwatch.stop();

      expect(calendar.days, hasLength(31));
      expect(stopwatch.elapsedMilliseconds, lessThan(300));
    });
  });
}

ScheduleSetupDraft _draft(
  SchedulePresetMode mode, {
  List<bool> customPattern = const <bool>[true, false],
}) {
  return ScheduleSetupDraft(
    mode: mode,
    ruleName: '默认排班',
    shiftName: '白班',
    shiftShortName: '白',
    startMinute: 9 * 60,
    endMinute: 18 * 60,
    crossDay: false,
    unpaidBreakMinutes: 60,
    anchorDate: LocalDate.parse('2026-08-03'),
    customCycleWorkPattern: customPattern,
    shiftId: ShiftId('default-shift'),
    ruleId: RuleId('default-rule'),
  );
}

final class _FixedClock implements AppClock {
  @override
  DateTime nowUtc() => DateTime.utc(2026, 8, 6);
}

final class _SequenceIdGenerator implements StableIdGenerator {
  _SequenceIdGenerator(this.prefix);

  final String prefix;
  var _next = 0;

  @override
  String generate() => '$prefix-${_next++}';
}
