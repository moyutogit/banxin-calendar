import 'dart:convert';

import 'package:banxin_calendar/core/database/app_database.dart'
    show AppDatabase;
import 'package:banxin_calendar/core/ids/stable_id_generator.dart';
import 'package:banxin_calendar/core/time/app_clock.dart';
import 'package:banxin_calendar/features/attendance/data/drift_attendance_repository.dart';
import 'package:banxin_calendar/features/attendance/domain/attendance_entities.dart';
import 'package:banxin_calendar/features/schedule/application/resolve_calendar_range.dart';
import 'package:banxin_calendar/features/schedule/application/schedule_application_service.dart';
import 'package:banxin_calendar/features/schedule/data/drift_schedule_repository.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_resolver.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';
import 'package:banxin_calendar/features/statistics/application/statistics_service.dart';
import 'package:banxin_calendar/features/statistics/domain/statistics_entities.dart';
import 'package:banxin_calendar/features/wage/data/drift_wage_repository.dart';
import 'package:banxin_calendar/features/wage/domain/wage_entities.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'UI report, CSV, and settlement share one night-shift calculation',
    () async {
      final database = AppDatabase.inMemory();
      addTearDown(database.close);
      await database.ensureReady();
      final scheduleRepository = DriftScheduleRepository(
        database,
        clock: const _FixedClock(),
        idGenerator: _SequenceIds('audit'),
      );
      final scheduleService = ScheduleApplicationService(
        scheduleRepository,
        ResolveCalendarRange(scheduleRepository, ScheduleResolver()),
        idGenerator: _SequenceIds('schedule'),
      );
      final attendanceRepository = DriftAttendanceRepository(
        database,
        clock: const _FixedClock(),
      );
      final wageRepository = DriftWageRepository(
        database,
        clock: const _FixedClock(),
      );
      final service = StatisticsService(
        scheduleService,
        attendanceRepository,
        wageRepository,
        clock: const _FixedClock(),
        idGenerator: _SequenceIds('period'),
      );
      final date = LocalDate.parse('2026-08-10');
      final range = DateRange(start: date, end: date);
      await scheduleService.saveSetup(
        ScheduleSetupDraft(
          mode: SchedulePresetMode.sixDay,
          ruleName: 'Night schedule',
          shiftName: 'Night',
          shiftShortName: 'N',
          startMinute: 20 * 60,
          endMinute: 8 * 60,
          crossDay: true,
          unpaidBreakMinutes: 60,
          anchorDate: date,
          shiftId: ShiftId('night'),
          ruleId: RuleId('night-rule'),
        ),
      );
      await attendanceRepository.saveSegment(
        AttendanceSegment(
          id: 'night-record',
          workDate: date,
          clockInUtc: DateTime(2026, 8, 10, 20).toUtc(),
          clockOutUtc: DateTime(2026, 8, 11, 8).toUtc(),
          unpaidBreakMinutes: 60,
          source: AttendanceSource.manual,
          status: AttendanceRecordStatus.complete,
          editReason: AttendanceEditReason.correction,
          createdTimezone: 'Asia/Shanghai',
          confirmed: true,
        ),
      );
      await wageRepository.saveRule(_hourlyRule(id: 'wage-v1', rate: 3000));

      final report = await service.build(range);
      final naturalDayReport = await service.build(
        DateRange(start: date, end: date.addDays(1)),
        attributionMode: StatisticsAttributionMode.naturalDay,
      );
      final csv = utf8.decode(service.csvBytes(report));
      final settled = await service.settle(range, confirmedMinor: 38000);

      expect(report.rawActualMinutes, 660);
      expect(report.normalMinutes, 480);
      expect(report.overtimeMinutes, 180);
      expect(report.payroll!.estimatedTotalMinor, 37500);
      expect(
        naturalDayReport.days.map((day) => day.hours.rawActualMinutes),
        <int>[180, 480],
      );
      expect(naturalDayReport.rawActualMinutes, report.rawActualMinutes);
      expect(
        naturalDayReport.payroll!.estimatedTotalMinor,
        report.payroll!.estimatedTotalMinor,
      );
      expect(csv, contains('660,660,480,180'));
      expect(csv, contains(',CNY,37500'));
      expect(settled.calculatedMinor, report.payroll!.estimatedTotalMinor);
      expect(settled.confirmedMinor, 38000);

      await wageRepository.saveRule(_hourlyRule(id: 'wage-v1', rate: 5000));
      final recalculated = await service.build(range);
      expect(recalculated.payroll!.estimatedTotalMinor, 37500);
      expect(recalculated.savedPeriod!.calculatedMinor, 37500);
      expect(recalculated.savedPeriod!.status, PayrollPeriodStatus.settled);

      final stopwatch = Stopwatch()..start();
      final yearly = await service.build(
        DateRange(
          start: LocalDate.parse('2026-01-01'),
          end: LocalDate.parse('2026-12-31'),
        ),
      );
      stopwatch.stop();
      expect(yearly.days, hasLength(365));
      expect(stopwatch.elapsed, lessThan(const Duration(seconds: 1)));
    },
  );
}

WageRule _hourlyRule({required String id, required int rate}) => WageRule(
  id: id,
  mode: WageMode.hourly,
  currency: 'CNY',
  baseRateMinor: rate,
  overtimeRateBasisPoints: const <OvertimeType, int>{
    OvertimeType.workday: 15000,
    OvertimeType.restDay: 20000,
    OvertimeType.publicHoliday: 30000,
  },
  periodStartDay: 1,
  roundingMode: MinuteRoundingMode.none,
  roundingIncrementMinutes: 1,
  confirmedOnly: false,
  effectiveRange: DateRange(
    start: LocalDate.parse('2026-01-01'),
    end: LocalDate.parse('2026-12-31'),
  ),
);

final class _FixedClock implements AppClock {
  const _FixedClock();

  @override
  DateTime nowUtc() => DateTime.utc(2026, 8, 31);
}

final class _SequenceIds implements StableIdGenerator {
  _SequenceIds(this.prefix);

  final String prefix;
  var _next = 0;

  @override
  String generate() => '$prefix-${_next++}';
}
