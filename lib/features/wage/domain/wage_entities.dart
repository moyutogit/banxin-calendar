import 'package:banxin_calendar/features/attendance/domain/attendance_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';

enum WageMode { hourly, daily, monthly }

enum OvertimeType { workday, restDay, publicHoliday }

enum PayrollPeriodStatus { estimating, pendingConfirmation, settled }

final class WageRule {
  WageRule({
    required this.id,
    required this.mode,
    required this.currency,
    required this.baseRateMinor,
    required this.overtimeRateBasisPoints,
    required this.periodStartDay,
    required this.roundingMode,
    required this.roundingIncrementMinutes,
    required this.confirmedOnly,
    required this.effectiveRange,
    this.normalMonthlyMinutes = 10440,
  }) {
    if (currency.length != 3) {
      throw ArgumentError.value(currency, 'currency');
    }
    if (baseRateMinor < 0) {
      throw ArgumentError.value(baseRateMinor, 'baseRateMinor');
    }
    if (periodStartDay < 1 || periodStartDay > 28) {
      throw ArgumentError.value(periodStartDay, 'periodStartDay');
    }
    if (normalMonthlyMinutes < 1) {
      throw ArgumentError.value(normalMonthlyMinutes, 'normalMonthlyMinutes');
    }
  }

  final String id;
  final WageMode mode;
  final String currency;
  final int baseRateMinor;
  final Map<OvertimeType, int> overtimeRateBasisPoints;
  final int periodStartDay;
  final MinuteRoundingMode roundingMode;
  final int roundingIncrementMinutes;
  final bool confirmedOnly;
  final DateRange effectiveRange;
  final int normalMonthlyMinutes;
}

final class PayrollDayInput {
  const PayrollDayInput({
    required this.date,
    required this.scheduleStatus,
    required this.hours,
    required this.confirmed,
  });

  final LocalDate date;
  final DayStatus scheduleStatus;
  final DailyHours hours;
  final bool confirmed;
}

final class MoneyLine {
  const MoneyLine({required this.label, required this.amountMinor});

  final String label;
  final int amountMinor;
}

final class CalculationTrace {
  const CalculationTrace({required this.code, required this.description});

  final String code;
  final String description;
}

final class PayrollResult {
  const PayrollResult({
    required this.currency,
    required this.basePayMinor,
    required this.normalHoursPayMinor,
    required this.overtimePayMinor,
    required this.allowances,
    required this.deductions,
    required this.estimatedTotalMinor,
    required this.normalMinutes,
    required this.overtimeMinutes,
    required this.attendanceDays,
    required this.traces,
  });

  final String currency;
  final int basePayMinor;
  final int normalHoursPayMinor;
  final Map<OvertimeType, int> overtimePayMinor;
  final List<MoneyLine> allowances;
  final List<MoneyLine> deductions;
  final int estimatedTotalMinor;
  final int normalMinutes;
  final Map<OvertimeType, int> overtimeMinutes;
  final int attendanceDays;
  final List<CalculationTrace> traces;
}

final class PayrollPeriod {
  const PayrollPeriod({
    required this.id,
    required this.range,
    required this.status,
    required this.calculatedMinor,
    required this.snapshotJson,
    this.confirmedMinor,
    this.confirmedAtUtc,
  });

  final String id;
  final DateRange range;
  final PayrollPeriodStatus status;
  final int calculatedMinor;
  final int? confirmedMinor;
  final String snapshotJson;
  final DateTime? confirmedAtUtc;
}
