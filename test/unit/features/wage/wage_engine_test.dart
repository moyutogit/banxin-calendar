import 'dart:convert';

import 'package:banxin_calendar/features/attendance/domain/attendance_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';
import 'package:banxin_calendar/features/wage/domain/wage_engine.dart';
import 'package:banxin_calendar/features/wage/domain/wage_entities.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const engine = WageEngine();

  test('hourly wage includes normal and three overtime categories', () {
    final result = engine.calculate(
      rule: _rule(WageMode.hourly, rate: 3000),
      days: <PayrollDayInput>[
        _day('2026-08-10', DayStatus.work, normal: 480, overtime: 60),
        _day('2026-08-15', DayStatus.rest, normal: 0, overtime: 120),
        _day('2026-10-01', DayStatus.publicHoliday, normal: 0, overtime: 60),
      ],
    );

    expect(result.normalHoursPayMinor, 24000);
    expect(result.overtimePayMinor[OvertimeType.workday], 4500);
    expect(result.overtimePayMinor[OvertimeType.restDay], 12000);
    expect(result.overtimePayMinor[OvertimeType.publicHoliday], 9000);
    expect(result.estimatedTotalMinor, 49500);
  });

  test('daily wage pays attendance days and keeps traceable overtime', () {
    final result = engine.calculate(
      rule: _rule(WageMode.daily, rate: 20000),
      days: <PayrollDayInput>[
        _day('2026-08-10', DayStatus.work, normal: 480, overtime: 60),
        _day('2026-08-11', DayStatus.work, normal: 480),
      ],
    );
    expect(result.basePayMinor, 40000);
    expect(result.attendanceDays, 2);
    expect(result.overtimePayMinor[OvertimeType.workday], 3750);
  });

  test('monthly wage keeps base pay and applies additions and deductions', () {
    final result = engine.calculate(
      rule: _rule(WageMode.monthly, rate: 600000),
      days: <PayrollDayInput>[_day('2026-08-10', DayStatus.work, normal: 480)],
      allowances: const <MoneyLine>[
        MoneyLine(label: 'Night', amountMinor: 5000),
      ],
      deductions: const <MoneyLine>[
        MoneyLine(label: 'Leave', amountMinor: 2000),
      ],
    );
    expect(result.basePayMinor, 600000);
    expect(result.estimatedTotalMinor, 603000);
  });

  test(
    'settlement snapshot is stable and contains input and result detail',
    () {
      final rule = _rule(WageMode.hourly, rate: 3000);
      final days = <PayrollDayInput>[
        _day('2026-08-10', DayStatus.work, normal: 480, overtime: 180),
      ];
      final result = engine.calculate(rule: rule, days: days);
      final snapshot = engine.snapshot(
        rule: rule,
        generatedAtUtc: DateTime.utc(2026, 8, 31),
        days: days,
        result: result,
      );
      final json = jsonDecode(snapshot) as Map<String, Object?>;

      expect(json['engineVersion'], WageEngine.engineVersion);
      expect((json['days']! as List<Object?>), hasLength(1));
      expect(
        (json['result']! as Map<String, Object?>)['estimatedTotalMinor'],
        result.estimatedTotalMinor,
      );
    },
  );
}

WageRule _rule(WageMode mode, {required int rate}) => WageRule(
  id: 'rule',
  mode: mode,
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

PayrollDayInput _day(
  String date,
  DayStatus status, {
  required int normal,
  int overtime = 0,
}) => PayrollDayInput(
  date: LocalDate.parse(date),
  scheduleStatus: status,
  confirmed: true,
  hours: DailyHours(
    rawActualMinutes: normal + overtime,
    payableMinutes: normal + overtime,
    normalMinutes: normal,
    overtimeMinutes: overtime,
    missingPunch: false,
    late: false,
    earlyLeave: false,
  ),
);
