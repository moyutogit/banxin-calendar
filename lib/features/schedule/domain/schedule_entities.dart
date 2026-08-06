import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';

enum DayStatus { work, adjustedWorkday, rest, publicHoliday, leave }

enum DaySource {
  defaultRule,
  scheduleRule,
  officialHoliday,
  companyOverride,
  userOverride,
}

enum DayTag {
  late,
  earlyLeave,
  missingPunch,
  absence,
  overtime,
  shiftSwap,
  businessTrip,
  manualEdit,
}

final class ShiftSnapshot {
  ShiftSnapshot({
    required this.id,
    required this.name,
    required this.shortName,
    required this.startMinute,
    required this.endMinute,
    required this.crossDay,
    required this.unpaidBreakMinutes,
    required this.plannedPaidMinutes,
    required this.colorArgb,
    required this.isWorkday,
  }) {
    if (name.trim().isEmpty || name.length > 12) {
      throw ArgumentError.value(name, 'name', 'Shift name must be 1-12 chars.');
    }
    if (shortName.trim().isEmpty || shortName.length > 3) {
      throw ArgumentError.value(
        shortName,
        'shortName',
        'Shift short name must be 1-3 chars.',
      );
    }
    if (startMinute < 0 || startMinute >= minutesPerDay) {
      throw ArgumentError.value(startMinute, 'startMinute');
    }
    if (endMinute < 0 || endMinute >= minutesPerDay) {
      throw ArgumentError.value(endMinute, 'endMinute');
    }
    if (unpaidBreakMinutes < 0 || unpaidBreakMinutes > 480) {
      throw ArgumentError.value(unpaidBreakMinutes, 'unpaidBreakMinutes');
    }
    if (plannedPaidMinutes < 0) {
      throw ArgumentError.value(plannedPaidMinutes, 'plannedPaidMinutes');
    }
  }

  static const int minutesPerDay = 24 * 60;

  final ShiftId id;
  final String name;
  final String shortName;
  final int startMinute;
  final int endMinute;
  final bool crossDay;
  final int unpaidBreakMinutes;
  final int plannedPaidMinutes;
  final int colorArgb;
  final bool isWorkday;
}

final class ResolvedCalendarDay {
  const ResolvedCalendarDay({
    required this.date,
    required this.status,
    required this.shift,
    required this.source,
    required this.plannedPaidMinutes,
    required this.tags,
    required this.resolverVersion,
    this.sourceId,
  });

  final LocalDate date;
  final DayStatus status;
  final ShiftSnapshot? shift;
  final DaySource source;
  final String? sourceId;
  final int plannedPaidMinutes;
  final List<DayTag> tags;
  final int resolverVersion;
}

final class ScheduleDayTemplate {
  ScheduleDayTemplate({required this.status, this.shift}) {
    if ((status == DayStatus.work || status == DayStatus.adjustedWorkday) &&
        shift == null) {
      throw ArgumentError('A workday template requires a shift snapshot.');
    }
  }

  final DayStatus status;
  final ShiftSnapshot? shift;

  int get plannedPaidMinutes => shift?.plannedPaidMinutes ?? 0;
}

final class CalendarOverride {
  CalendarOverride({
    required this.id,
    required this.date,
    required this.status,
    this.shift,
    List<DayTag> tags = const <DayTag>[DayTag.manualEdit],
  }) : tags = List<DayTag>.unmodifiable(tags) {
    if ((status == DayStatus.work || status == DayStatus.adjustedWorkday) &&
        shift == null) {
      throw ArgumentError('A workday override requires a shift snapshot.');
    }
  }

  final String id;
  final LocalDate date;
  final DayStatus status;
  final ShiftSnapshot? shift;
  final List<DayTag> tags;
}

final class OfficialHoliday {
  OfficialHoliday({
    required this.id,
    required this.date,
    required this.status,
    this.shift,
  }) {
    if (status != DayStatus.publicHoliday &&
        status != DayStatus.adjustedWorkday) {
      throw ArgumentError(
        'Official holiday must be a holiday or adjusted workday.',
      );
    }
  }

  final String id;
  final LocalDate date;
  final DayStatus status;
  final ShiftSnapshot? shift;
}
