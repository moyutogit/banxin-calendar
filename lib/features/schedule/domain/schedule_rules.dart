import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';

abstract class ScheduleRule {
  ScheduleRule({
    required this.id,
    required this.name,
    required this.effectiveRange,
    required this.priority,
  }) {
    if (name.trim().isEmpty) {
      throw ArgumentError.value(name, 'name', 'Rule name must not be empty.');
    }
  }

  final RuleId id;
  final String name;
  final DateRange effectiveRange;
  final int priority;

  bool appliesTo(LocalDate date) => effectiveRange.contains(date);

  ScheduleDayTemplate evaluate(LocalDate date);
}

final class WeekTemplate {
  WeekTemplate(Map<int, ScheduleDayTemplate> days)
    : _days = Map<int, ScheduleDayTemplate>.unmodifiable(days) {
    final expected = <int>{
      DateTime.monday,
      DateTime.tuesday,
      DateTime.wednesday,
      DateTime.thursday,
      DateTime.friday,
      DateTime.saturday,
      DateTime.sunday,
    };
    if (_days.keys.toSet().difference(expected).isNotEmpty ||
        expected.difference(_days.keys.toSet()).isNotEmpty) {
      throw ArgumentError('A week template must define Monday through Sunday.');
    }
  }

  final Map<int, ScheduleDayTemplate> _days;

  ScheduleDayTemplate forWeekday(int weekday) => _days[weekday]!;
}

final class WeeklyScheduleRule extends ScheduleRule {
  WeeklyScheduleRule({
    required super.id,
    required super.name,
    required super.effectiveRange,
    required super.priority,
    required this.week,
  });

  final WeekTemplate week;

  @override
  ScheduleDayTemplate evaluate(LocalDate date) => week.forWeekday(date.weekday);
}

final class CycleScheduleRule extends ScheduleRule {
  CycleScheduleRule({
    required super.id,
    required super.name,
    required super.effectiveRange,
    required super.priority,
    required this.anchorDate,
    required List<ScheduleDayTemplate> cycle,
  }) : cycle = List<ScheduleDayTemplate>.unmodifiable(cycle) {
    if (cycle.isEmpty || cycle.length > 31) {
      throw ArgumentError.value(cycle.length, 'cycle', 'Expected 1-31 days.');
    }
  }

  final LocalDate anchorDate;
  final List<ScheduleDayTemplate> cycle;

  @override
  ScheduleDayTemplate evaluate(LocalDate date) {
    final offset = anchorDate.daysUntil(date);
    final normalized = ((offset % cycle.length) + cycle.length) % cycle.length;
    return cycle[normalized];
  }
}

final class AlternatingWeekScheduleRule extends ScheduleRule {
  AlternatingWeekScheduleRule({
    required super.id,
    required super.name,
    required super.effectiveRange,
    required super.priority,
    required this.anchorWeekStart,
    required this.anchorWeek,
    required this.alternateWeek,
  }) {
    if (anchorWeekStart.weekday != DateTime.monday) {
      throw ArgumentError('Alternating-week anchor must be a Monday.');
    }
  }

  final LocalDate anchorWeekStart;
  final WeekTemplate anchorWeek;
  final WeekTemplate alternateWeek;

  @override
  ScheduleDayTemplate evaluate(LocalDate date) {
    final dayOffset = anchorWeekStart.daysUntil(date);
    final weekOffset = _floorDivide(dayOffset, DateTime.daysPerWeek);
    final template = weekOffset.isEven ? anchorWeek : alternateWeek;
    return template.forWeekday(date.weekday);
  }

  int _floorDivide(int dividend, int divisor) {
    final quotient = dividend ~/ divisor;
    final remainder = dividend % divisor;
    if (dividend < 0 && remainder != 0) {
      return quotient - 1;
    }
    return quotient;
  }
}
