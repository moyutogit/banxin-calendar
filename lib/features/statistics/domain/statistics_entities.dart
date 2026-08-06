import 'package:banxin_calendar/features/attendance/domain/attendance_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';
import 'package:banxin_calendar/features/wage/domain/wage_entities.dart';

enum StatisticsAttributionMode { workDate, naturalDay }

final class DailyStatistics {
  const DailyStatistics({
    required this.date,
    required this.scheduleStatus,
    required this.shiftName,
    required this.hours,
    required this.confirmed,
  });

  final LocalDate date;
  final DayStatus scheduleStatus;
  final String? shiftName;
  final DailyHours hours;
  final bool confirmed;
}

final class StatisticsReport {
  const StatisticsReport({
    required this.range,
    required this.days,
    required this.expectedAttendanceDays,
    required this.actualAttendanceDays,
    required this.restDays,
    required this.publicHolidayDays,
    required this.plannedMinutes,
    required this.rawActualMinutes,
    required this.payableMinutes,
    required this.normalMinutes,
    required this.overtimeMinutes,
    required this.lateCount,
    required this.earlyLeaveCount,
    required this.missingPunchCount,
    required this.payroll,
    required this.savedPeriod,
  });

  final DateRange range;
  final List<DailyStatistics> days;
  final int expectedAttendanceDays;
  final int actualAttendanceDays;
  final int restDays;
  final int publicHolidayDays;
  final int plannedMinutes;
  final int rawActualMinutes;
  final int payableMinutes;
  final int normalMinutes;
  final int overtimeMinutes;
  final int lateCount;
  final int earlyLeaveCount;
  final int missingPunchCount;
  final PayrollResult? payroll;
  final PayrollPeriod? savedPeriod;
}
