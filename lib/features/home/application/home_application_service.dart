import 'package:banxin_calendar/core/time/app_clock.dart';
import 'package:banxin_calendar/features/alarm/domain/alarm_entities.dart';
import 'package:banxin_calendar/features/alarm/domain/alarm_repository.dart';
import 'package:banxin_calendar/features/attendance/application/attendance_application_service.dart';
import 'package:banxin_calendar/features/schedule/application/schedule_application_service.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';
import 'package:banxin_calendar/features/statistics/application/statistics_service.dart';
import 'package:banxin_calendar/features/statistics/domain/statistics_entities.dart';

final class HomeDashboard {
  const HomeDashboard({
    required this.today,
    required this.nextSevenDays,
    required this.attendance,
    required this.month,
    required this.nextAlarm,
    required this.scheduleConfigured,
  });

  final ResolvedCalendarDay? today;
  final List<ResolvedCalendarDay> nextSevenDays;
  final AttendanceDayView attendance;
  final StatisticsReport month;
  final AlarmInstance? nextAlarm;
  final bool scheduleConfigured;
}

final class HomeApplicationService {
  const HomeApplicationService(
    this._schedule,
    this._attendance,
    this._statistics,
    this._alarms, {
    this._clock = const SystemAppClock(),
  });

  final ScheduleApplicationService _schedule;
  final AttendanceApplicationService _attendance;
  final StatisticsService _statistics;
  final AlarmRepository _alarms;
  final AppClock _clock;

  Future<HomeDashboard> load() async {
    final localNow = _clock.nowUtc().toLocal();
    final today = LocalDate(localNow.year, localNow.month, localNow.day);
    final calendarFuture = _schedule.loadCalendar(
      DateRange(start: today, end: today.addDays(6)),
    );
    final attendanceFuture = _attendance.loadDay(today);
    final monthStart = LocalDate(today.year, today.month, 1);
    final nextMonth = today.month == 12
        ? LocalDate(today.year + 1, 1, 1)
        : LocalDate(today.year, today.month + 1, 1);
    final statisticsFuture = _statistics.build(
      DateRange(start: monthStart, end: nextMonth.addDays(-1)),
    );
    final alarmFuture = _alarms.loadUpcomingInstances(_clock.nowUtc());
    final calendar = await calendarFuture;
    final alarms = await alarmFuture;
    return HomeDashboard(
      today: calendar.days.firstOrNull,
      nextSevenDays: calendar.days,
      attendance: await attendanceFuture,
      month: await statisticsFuture,
      nextAlarm: alarms.firstOrNull,
      scheduleConfigured: calendar.configured,
    );
  }

  Future<AttendanceMutationResult> punchToday() {
    final localNow = _clock.nowUtc().toLocal();
    return _attendance.punch(
      LocalDate(localNow.year, localNow.month, localNow.day),
    );
  }
}
