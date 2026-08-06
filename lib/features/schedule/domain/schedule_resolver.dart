import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_rules.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';

final class ScheduleResolverInput {
  ScheduleResolverInput({
    required this.defaultWeek,
    List<ScheduleRule> rules = const <ScheduleRule>[],
    Map<LocalDate, CalendarOverride> userOverrides =
        const <LocalDate, CalendarOverride>{},
    Map<LocalDate, CalendarOverride> companyOverrides =
        const <LocalDate, CalendarOverride>{},
    Map<LocalDate, OfficialHoliday> officialHolidays =
        const <LocalDate, OfficialHoliday>{},
  }) : rules = List<ScheduleRule>.unmodifiable(rules),
       userOverrides = Map<LocalDate, CalendarOverride>.unmodifiable(
         userOverrides,
       ),
       companyOverrides = Map<LocalDate, CalendarOverride>.unmodifiable(
         companyOverrides,
       ),
       officialHolidays = Map<LocalDate, OfficialHoliday>.unmodifiable(
         officialHolidays,
       );

  final WeekTemplate defaultWeek;
  final List<ScheduleRule> rules;
  final Map<LocalDate, CalendarOverride> userOverrides;
  final Map<LocalDate, CalendarOverride> companyOverrides;
  final Map<LocalDate, OfficialHoliday> officialHolidays;
}

final class ScheduleResolver {
  static const int resolverVersion = 1;

  ResolvedCalendarDay resolveDay(LocalDate date, ScheduleResolverInput input) {
    final userOverride = input.userOverrides[date];
    if (userOverride != null) {
      return _fromOverride(userOverride, DaySource.userOverride);
    }

    final companyOverride = input.companyOverrides[date];
    if (companyOverride != null) {
      return _fromOverride(companyOverride, DaySource.companyOverride);
    }

    final holiday = input.officialHolidays[date];
    if (holiday != null) {
      final shift =
          holiday.shift ??
          (holiday.status == DayStatus.adjustedWorkday
              ? _resolveRuleBaseline(date, input).shift
              : null);
      return ResolvedCalendarDay(
        date: date,
        status: holiday.status,
        shift: shift,
        source: DaySource.officialHoliday,
        sourceId: holiday.id,
        plannedPaidMinutes: shift?.plannedPaidMinutes ?? 0,
        tags: const <DayTag>[],
        resolverVersion: resolverVersion,
      );
    }

    return _resolveRuleBaseline(date, input);
  }

  List<ResolvedCalendarDay> resolveRange(
    DateRange range,
    ScheduleResolverInput input,
  ) {
    return List<ResolvedCalendarDay>.unmodifiable(
      range.dates.map((date) => resolveDay(date, input)),
    );
  }

  ResolvedCalendarDay _resolveRuleBaseline(
    LocalDate date,
    ScheduleResolverInput input,
  ) {
    final candidates =
        input.rules.where((rule) => rule.appliesTo(date)).toList()
          ..sort((left, right) {
            final priorityOrder = right.priority.compareTo(left.priority);
            if (priorityOrder != 0) {
              return priorityOrder;
            }
            return left.id.value.compareTo(right.id.value);
          });

    if (candidates.isNotEmpty) {
      final rule = candidates.first;
      return _fromTemplate(
        date: date,
        template: rule.evaluate(date),
        source: DaySource.scheduleRule,
        sourceId: rule.id.value,
      );
    }

    return _fromTemplate(
      date: date,
      template: input.defaultWeek.forWeekday(date.weekday),
      source: DaySource.defaultRule,
    );
  }

  ResolvedCalendarDay _fromOverride(
    CalendarOverride override,
    DaySource source,
  ) {
    return ResolvedCalendarDay(
      date: override.date,
      status: override.status,
      shift: override.shift,
      source: source,
      sourceId: override.id,
      plannedPaidMinutes: override.shift?.plannedPaidMinutes ?? 0,
      tags: override.tags,
      resolverVersion: resolverVersion,
    );
  }

  ResolvedCalendarDay _fromTemplate({
    required LocalDate date,
    required ScheduleDayTemplate template,
    required DaySource source,
    String? sourceId,
  }) {
    return ResolvedCalendarDay(
      date: date,
      status: template.status,
      shift: template.shift,
      source: source,
      sourceId: sourceId,
      plannedPaidMinutes: template.plannedPaidMinutes,
      tags: const <DayTag>[],
      resolverVersion: resolverVersion,
    );
  }
}
