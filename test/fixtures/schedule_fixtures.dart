import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_rules.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';

ShiftSnapshot dayShift({String id = 'shift-day'}) {
  return ShiftSnapshot(
    id: ShiftId(id),
    name: '白班',
    shortName: '白',
    startMinute: 9 * 60,
    endMinute: 18 * 60,
    crossDay: false,
    unpaidBreakMinutes: 60,
    plannedPaidMinutes: 8 * 60,
    colorArgb: 0xFF3B82F6,
    isWorkday: true,
  );
}

ScheduleDayTemplate workTemplate({ShiftSnapshot? shift}) {
  return ScheduleDayTemplate(
    status: DayStatus.work,
    shift: shift ?? dayShift(),
  );
}

ScheduleDayTemplate restTemplate() {
  return ScheduleDayTemplate(status: DayStatus.rest);
}

WeekTemplate standardFiveDayWeek({ShiftSnapshot? shift}) {
  final work = workTemplate(shift: shift);
  final rest = restTemplate();
  return WeekTemplate(<int, ScheduleDayTemplate>{
    DateTime.monday: work,
    DateTime.tuesday: work,
    DateTime.wednesday: work,
    DateTime.thursday: work,
    DateTime.friday: work,
    DateTime.saturday: rest,
    DateTime.sunday: rest,
  });
}

WeekTemplate sixDayWeek({ShiftSnapshot? shift}) {
  final work = workTemplate(shift: shift);
  return WeekTemplate(<int, ScheduleDayTemplate>{
    DateTime.monday: work,
    DateTime.tuesday: work,
    DateTime.wednesday: work,
    DateTime.thursday: work,
    DateTime.friday: work,
    DateTime.saturday: work,
    DateTime.sunday: restTemplate(),
  });
}
