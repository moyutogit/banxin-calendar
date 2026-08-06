import 'dart:convert';

import 'package:banxin_calendar/core/ids/stable_id_generator.dart';
import 'package:banxin_calendar/core/time/app_clock.dart';
import 'package:banxin_calendar/features/attendance/domain/attendance_engine.dart';
import 'package:banxin_calendar/features/attendance/domain/attendance_entities.dart';
import 'package:banxin_calendar/features/attendance/domain/attendance_repository.dart';
import 'package:banxin_calendar/features/schedule/application/schedule_application_service.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';
import 'package:banxin_calendar/features/statistics/domain/statistics_entities.dart';
import 'package:banxin_calendar/features/wage/domain/wage_engine.dart';
import 'package:banxin_calendar/features/wage/domain/wage_entities.dart';
import 'package:banxin_calendar/features/wage/domain/wage_repository.dart';

final class StatisticsService {
  StatisticsService(
    this._scheduleService,
    this._attendanceRepository,
    this._wageRepository, {
    this._attendanceEngine = const AttendanceEngine(),
    this._wageEngine = const WageEngine(),
    this._clock = const SystemAppClock(),
    StableIdGenerator? idGenerator,
  }) : _idGenerator = idGenerator ?? UuidV4Generator();

  final ScheduleApplicationService _scheduleService;
  final AttendanceRepository _attendanceRepository;
  final WageRepository _wageRepository;
  final AttendanceEngine _attendanceEngine;
  final WageEngine _wageEngine;
  final AppClock _clock;
  final StableIdGenerator _idGenerator;

  Future<StatisticsReport> build(
    DateRange range, {
    StatisticsAttributionMode attributionMode =
        StatisticsAttributionMode.workDate,
  }) async {
    final calendar = await _scheduleService.loadCalendar(range);
    final loadedSegments = await _attendanceRepository.loadSegments(
      attributionMode == StatisticsAttributionMode.naturalDay
          ? DateRange(start: range.start.addDays(-1), end: range.end)
          : range,
    );
    final workDateSegments = loadedSegments
        .where((segment) => range.contains(segment.workDate))
        .toList();
    final segments = attributionMode == StatisticsAttributionMode.naturalDay
        ? loadedSegments
              .expand(_splitByNaturalDay)
              .where((segment) => range.contains(segment.workDate))
              .toList()
        : workDateSegments;
    final wageRules = await _wageRepository.loadRules(range);
    final wageRule = wageRules.isEmpty ? null : wageRules.first;
    final savedPeriod = await _wageRepository.loadPayrollPeriod(range);
    final daily = _buildDaily(
      calendar.days,
      segments,
      wageRule,
      usePlannedTimes: attributionMode == StatisticsAttributionMode.workDate,
    );
    final payrollDaily = attributionMode == StatisticsAttributionMode.workDate
        ? daily
        : _buildDaily(calendar.days, workDateSegments, wageRule);
    final calculatedPayroll = wageRule == null
        ? null
        : _wageEngine.calculate(
            rule: wageRule,
            allowances: wageRule.allowances,
            deductions: wageRule.deductions,
            days: <PayrollDayInput>[
              for (final day in payrollDaily)
                PayrollDayInput(
                  date: day.date,
                  scheduleStatus: day.scheduleStatus,
                  hours: day.hours,
                  confirmed: day.confirmed,
                ),
            ],
          );
    final payroll = savedPeriod?.status == PayrollPeriodStatus.settled
        ? _wageEngine.restoreSnapshot(savedPeriod!.snapshotJson)
        : calculatedPayroll;
    return StatisticsReport(
      range: range,
      days: List<DailyStatistics>.unmodifiable(daily),
      expectedAttendanceDays: calendar.days
          .where(
            (day) =>
                day.status == DayStatus.work ||
                day.status == DayStatus.adjustedWorkday,
          )
          .length,
      actualAttendanceDays: daily
          .where((day) => day.hours.payableMinutes > 0)
          .length,
      restDays: calendar.days
          .where((day) => day.status == DayStatus.rest)
          .length,
      publicHolidayDays: calendar.days
          .where((day) => day.status == DayStatus.publicHoliday)
          .length,
      plannedMinutes: calendar.days.fold<int>(
        0,
        (sum, day) => sum + day.plannedPaidMinutes,
      ),
      rawActualMinutes: daily.fold<int>(
        0,
        (sum, day) => sum + day.hours.rawActualMinutes,
      ),
      payableMinutes: daily.fold<int>(
        0,
        (sum, day) => sum + day.hours.payableMinutes,
      ),
      normalMinutes: daily.fold<int>(
        0,
        (sum, day) => sum + day.hours.normalMinutes,
      ),
      overtimeMinutes: daily.fold<int>(
        0,
        (sum, day) => sum + day.hours.overtimeMinutes,
      ),
      lateCount: daily.where((day) => day.hours.late).length,
      earlyLeaveCount: daily.where((day) => day.hours.earlyLeave).length,
      missingPunchCount: daily.where((day) => day.hours.missingPunch).length,
      payroll: payroll,
      savedPeriod: savedPeriod,
    );
  }

  List<DailyStatistics> _buildDaily(
    List<ResolvedCalendarDay> calendarDays,
    List<AttendanceSegment> segments,
    WageRule? wageRule, {
    bool usePlannedTimes = true,
  }) {
    final grouped = <LocalDate, List<AttendanceSegment>>{};
    for (final segment in segments) {
      grouped
          .putIfAbsent(segment.workDate, () => <AttendanceSegment>[])
          .add(segment);
    }
    final daily = <DailyStatistics>[];
    for (final day in calendarDays) {
      final daySegments = grouped[day.date] ?? const <AttendanceSegment>[];
      final (plannedStart, plannedEnd) = usePlannedTimes
          ? _plannedTimes(day)
          : (null, null);
      final policy = WorkTimePolicy(
        normalLimitMinutes: 480,
        roundingMode: wageRule?.roundingMode ?? MinuteRoundingMode.none,
        roundingIncrementMinutes: wageRule?.roundingIncrementMinutes ?? 1,
      );
      daily.add(
        DailyStatistics(
          date: day.date,
          scheduleStatus: day.status,
          shiftName: day.shift?.name,
          hours: _attendanceEngine.calculate(
            segments: daySegments,
            policy: policy,
            plannedStartUtc: plannedStart,
            plannedEndUtc: plannedEnd,
          ),
          confirmed:
              daySegments.isNotEmpty &&
              daySegments.every((segment) => segment.confirmed),
        ),
      );
    }
    return daily;
  }

  Iterable<AttendanceSegment> _splitByNaturalDay(
    AttendanceSegment source,
  ) sync* {
    if (!source.isComplete) {
      yield source;
      return;
    }
    var cursor = source.clockInUtc!.toLocal();
    final end = source.clockOutUtc!.toLocal();
    var breakRemaining = source.unpaidBreakMinutes;
    var index = 0;
    while (cursor.isBefore(end)) {
      final nextMidnight = DateTime(cursor.year, cursor.month, cursor.day + 1);
      final portionEnd = nextMidnight.isBefore(end) ? nextMidnight : end;
      final duration = portionEnd.difference(cursor).inMinutes;
      final breakForPortion = breakRemaining < duration
          ? breakRemaining
          : duration;
      breakRemaining -= breakForPortion;
      yield AttendanceSegment(
        id: '${source.id}:natural:${index++}',
        workDate: LocalDate(cursor.year, cursor.month, cursor.day),
        clockInUtc: cursor.toUtc(),
        clockOutUtc: portionEnd.toUtc(),
        unpaidBreakMinutes: breakForPortion,
        source: source.source,
        status: source.status,
        editReason: source.editReason,
        note: source.note,
        createdTimezone: source.createdTimezone,
        confirmed: source.confirmed,
      );
      cursor = portionEnd;
    }
  }

  Future<PayrollPeriod> saveCalculation(DateRange range) async {
    final report = await build(range);
    final rule = (await _wageRepository.loadRules(range)).firstOrNull;
    final payroll = report.payroll;
    if (rule == null || payroll == null) {
      throw StateError('A wage rule is required before payroll calculation.');
    }
    final now = _clock.nowUtc();
    final localNow = now.toLocal();
    final today = LocalDate(localNow.year, localNow.month, localNow.day);
    final period = PayrollPeriod(
      id: report.savedPeriod?.id ?? _idGenerator.generate(),
      range: range,
      status: range.end.compareTo(today) < 0
          ? PayrollPeriodStatus.pendingConfirmation
          : PayrollPeriodStatus.estimating,
      calculatedMinor: payroll.estimatedTotalMinor,
      snapshotJson: _wageEngine.snapshot(
        rule: rule,
        generatedAtUtc: now,
        days: <PayrollDayInput>[
          for (final day in report.days)
            PayrollDayInput(
              date: day.date,
              scheduleStatus: day.scheduleStatus,
              hours: day.hours,
              confirmed: day.confirmed,
            ),
        ],
        result: payroll,
      ),
    );
    await _wageRepository.savePayrollPeriod(period);
    return period;
  }

  Future<PayrollPeriod> settle(
    DateRange range, {
    required int confirmedMinor,
  }) async {
    if (confirmedMinor < 0) throw ArgumentError.value(confirmedMinor);
    final existing = await _wageRepository.loadPayrollPeriod(range);
    if (existing?.status == PayrollPeriodStatus.settled) {
      final updated = PayrollPeriod(
        id: existing!.id,
        range: range,
        status: PayrollPeriodStatus.settled,
        calculatedMinor: existing.calculatedMinor,
        confirmedMinor: confirmedMinor,
        snapshotJson: existing.snapshotJson,
        confirmedAtUtc: _clock.nowUtc(),
      );
      await _wageRepository.savePayrollPeriod(updated);
      return updated;
    }
    final calculated = await saveCalculation(range);
    final settled = PayrollPeriod(
      id: calculated.id,
      range: range,
      status: PayrollPeriodStatus.settled,
      calculatedMinor: calculated.calculatedMinor,
      confirmedMinor: confirmedMinor,
      snapshotJson: calculated.snapshotJson,
      confirmedAtUtc: _clock.nowUtc(),
    );
    await _wageRepository.savePayrollPeriod(settled);
    return settled;
  }

  List<int> csvBytes(StatisticsReport report) {
    final buffer = StringBuffer('\ufeff')
      ..writeln(
        'date,schedule_status,shift,raw_minutes,payable_minutes,normal_minutes,overtime_minutes,missing_punch,confirmed,currency,estimated_minor',
      );
    for (final day in report.days) {
      buffer.writeln(
        <String>[
          day.date.toString(),
          day.scheduleStatus.name,
          _csv(day.shiftName ?? ''),
          '${day.hours.rawActualMinutes}',
          '${day.hours.payableMinutes}',
          '${day.hours.normalMinutes}',
          '${day.hours.overtimeMinutes}',
          '${day.hours.missingPunch}',
          '${day.confirmed}',
          report.payroll?.currency ?? '',
          '${report.payroll?.estimatedTotalMinor ?? ''}',
        ].join(','),
      );
    }
    return utf8.encode(buffer.toString());
  }

  (DateTime?, DateTime?) _plannedTimes(ResolvedCalendarDay day) {
    final shift = day.shift;
    if (shift == null) return (null, null);
    final start = DateTime(
      day.date.year,
      day.date.month,
      day.date.day,
    ).add(Duration(minutes: shift.startMinute));
    var end = DateTime(
      day.date.year,
      day.date.month,
      day.date.day,
    ).add(Duration(minutes: shift.endMinute));
    if (shift.crossDay || !end.isAfter(start)) {
      end = end.add(const Duration(days: 1));
    }
    return (start.toUtc(), end.toUtc());
  }

  String _csv(String value) => '"${value.replaceAll('"', '""')}"';
}
