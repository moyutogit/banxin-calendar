import 'dart:convert';

import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';
import 'package:banxin_calendar/features/wage/domain/wage_entities.dart';

final class WageEngine {
  const WageEngine();

  static const int engineVersion = 1;

  PayrollResult calculate({
    required WageRule rule,
    required List<PayrollDayInput> days,
    List<MoneyLine> allowances = const <MoneyLine>[],
    List<MoneyLine> deductions = const <MoneyLine>[],
  }) {
    final eligible = rule.confirmedOnly
        ? days.where((day) => day.confirmed).toList()
        : days;
    final normalMinutes = eligible.fold<int>(
      0,
      (sum, day) => sum + day.hours.normalMinutes,
    );
    final attendanceDays = eligible
        .where((day) => day.hours.payableMinutes > 0)
        .length;
    final overtimeMinutes = <OvertimeType, int>{
      for (final type in OvertimeType.values) type: 0,
    };
    for (final day in eligible) {
      final type = _overtimeType(day.scheduleStatus);
      overtimeMinutes[type] =
          overtimeMinutes[type]! + day.hours.overtimeMinutes;
    }

    final basePay = switch (rule.mode) {
      WageMode.hourly => 0,
      WageMode.daily => attendanceDays * rule.baseRateMinor,
      WageMode.monthly => rule.baseRateMinor,
    };
    final normalHoursPay = rule.mode == WageMode.hourly
        ? _minutesPay(normalMinutes, rule.baseRateMinor)
        : 0;
    final baseHourlyRate = switch (rule.mode) {
      WageMode.hourly => rule.baseRateMinor,
      WageMode.daily => (rule.baseRateMinor * 60 / 480).round(),
      WageMode.monthly =>
        (rule.baseRateMinor * 60 / rule.normalMonthlyMinutes).round(),
    };
    final overtimePay = <OvertimeType, int>{};
    for (final type in OvertimeType.values) {
      final multiplier = rule.overtimeRateBasisPoints[type] ?? 10000;
      overtimePay[type] =
          (_minutesPay(overtimeMinutes[type]!, baseHourlyRate) *
                  multiplier /
                  10000)
              .round();
    }
    final allowanceTotal = allowances.fold<int>(
      0,
      (sum, line) => sum + line.amountMinor,
    );
    final deductionTotal = deductions.fold<int>(
      0,
      (sum, line) => sum + line.amountMinor,
    );
    final total =
        basePay +
        normalHoursPay +
        overtimePay.values.fold<int>(0, (sum, amount) => sum + amount) +
        allowanceTotal -
        deductionTotal;
    return PayrollResult(
      currency: rule.currency,
      basePayMinor: basePay,
      normalHoursPayMinor: normalHoursPay,
      overtimePayMinor: Map<OvertimeType, int>.unmodifiable(overtimePay),
      allowances: List<MoneyLine>.unmodifiable(allowances),
      deductions: List<MoneyLine>.unmodifiable(deductions),
      estimatedTotalMinor: total,
      normalMinutes: normalMinutes,
      overtimeMinutes: Map<OvertimeType, int>.unmodifiable(overtimeMinutes),
      attendanceDays: attendanceDays,
      traces: List<CalculationTrace>.unmodifiable(<CalculationTrace>[
        CalculationTrace(code: 'engine_version', description: '$engineVersion'),
        CalculationTrace(
          code: 'eligible_days',
          description: '${eligible.length}',
        ),
        CalculationTrace(code: 'normal_minutes', description: '$normalMinutes'),
        for (final type in OvertimeType.values)
          CalculationTrace(
            code: 'overtime_${type.name}',
            description:
                '${overtimeMinutes[type]} min × ${rule.overtimeRateBasisPoints[type] ?? 10000} bp',
          ),
      ]),
    );
  }

  String snapshot({
    required WageRule rule,
    required DateTime generatedAtUtc,
    required List<PayrollDayInput> days,
    required PayrollResult result,
  }) => jsonEncode(<String, Object?>{
    'engineVersion': engineVersion,
    'generatedAtUtc': generatedAtUtc.toIso8601String(),
    'rule': <String, Object?>{
      'id': rule.id,
      'mode': rule.mode.name,
      'currency': rule.currency,
      'baseRateMinor': rule.baseRateMinor,
      'overtimeRateBasisPoints': <String, int>{
        for (final entry in rule.overtimeRateBasisPoints.entries)
          entry.key.name: entry.value,
      },
      'roundingMode': rule.roundingMode.name,
      'roundingIncrementMinutes': rule.roundingIncrementMinutes,
      'confirmedOnly': rule.confirmedOnly,
    },
    'days': <Object?>[
      for (final day in days)
        <String, Object?>{
          'date': day.date.toString(),
          'scheduleStatus': day.scheduleStatus.name,
          'rawActualMinutes': day.hours.rawActualMinutes,
          'payableMinutes': day.hours.payableMinutes,
          'normalMinutes': day.hours.normalMinutes,
          'overtimeMinutes': day.hours.overtimeMinutes,
          'confirmed': day.confirmed,
        },
    ],
    'result': <String, Object?>{
      'basePayMinor': result.basePayMinor,
      'normalHoursPayMinor': result.normalHoursPayMinor,
      'overtimePayMinor': <String, int>{
        for (final entry in result.overtimePayMinor.entries)
          entry.key.name: entry.value,
      },
      'allowances': <Object?>[
        for (final line in result.allowances)
          <String, Object?>{
            'label': line.label,
            'amountMinor': line.amountMinor,
          },
      ],
      'deductions': <Object?>[
        for (final line in result.deductions)
          <String, Object?>{
            'label': line.label,
            'amountMinor': line.amountMinor,
          },
      ],
      'estimatedTotalMinor': result.estimatedTotalMinor,
      'normalMinutes': result.normalMinutes,
      'overtimeMinutes': <String, int>{
        for (final entry in result.overtimeMinutes.entries)
          entry.key.name: entry.value,
      },
      'attendanceDays': result.attendanceDays,
    },
  });

  PayrollResult restoreSnapshot(String snapshotJson) {
    final snapshot = jsonDecode(snapshotJson) as Map<String, Object?>;
    final rule = snapshot['rule']! as Map<String, Object?>;
    final result = snapshot['result']! as Map<String, Object?>;
    final overtimePay = result['overtimePayMinor']! as Map<String, Object?>;
    final overtimeMinutes = result['overtimeMinutes']! as Map<String, Object?>;
    List<MoneyLine> decodeLines(String key) =>
        (result[key]! as List<Object?>).map((value) {
          final line = value! as Map<String, Object?>;
          return MoneyLine(
            label: line['label']! as String,
            amountMinor: line['amountMinor']! as int,
          );
        }).toList();
    return PayrollResult(
      currency: rule['currency']! as String,
      basePayMinor: result['basePayMinor']! as int,
      normalHoursPayMinor: result['normalHoursPayMinor']! as int,
      overtimePayMinor: <OvertimeType, int>{
        for (final entry in overtimePay.entries)
          OvertimeType.values.byName(entry.key): entry.value! as int,
      },
      allowances: decodeLines('allowances'),
      deductions: decodeLines('deductions'),
      estimatedTotalMinor: result['estimatedTotalMinor']! as int,
      normalMinutes: result['normalMinutes']! as int,
      overtimeMinutes: <OvertimeType, int>{
        for (final entry in overtimeMinutes.entries)
          OvertimeType.values.byName(entry.key): entry.value! as int,
      },
      attendanceDays: result['attendanceDays']! as int,
      traces: const <CalculationTrace>[
        CalculationTrace(code: 'source', description: 'settlement_snapshot'),
      ],
    );
  }

  int _minutesPay(int minutes, int hourlyRateMinor) =>
      (minutes * hourlyRateMinor / 60).round();

  OvertimeType _overtimeType(DayStatus status) => switch (status) {
    DayStatus.publicHoliday => OvertimeType.publicHoliday,
    DayStatus.rest || DayStatus.leave => OvertimeType.restDay,
    DayStatus.work || DayStatus.adjustedWorkday => OvertimeType.workday,
  };
}
