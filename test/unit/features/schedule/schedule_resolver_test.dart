import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_resolver.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_rules.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/schedule_fixtures.dart';

void main() {
  final resolver = ScheduleResolver();
  final target = LocalDate(2026, 8, 15);
  final effectiveRange = DateRange(
    start: LocalDate(2026, 1, 1),
    end: LocalDate(2026, 12, 31),
  );
  final workRule = WeeklyScheduleRule(
    id: RuleId('six-day'),
    name: '单休',
    effectiveRange: effectiveRange,
    priority: 10,
    week: sixDayWeek(),
  );

  test('uses user > company > holiday > schedule > default priority', () {
    final allLayers = ScheduleResolverInput(
      defaultWeek: standardFiveDayWeek(),
      rules: <ScheduleRule>[workRule],
      officialHolidays: <LocalDate, OfficialHoliday>{
        target: OfficialHoliday(
          id: 'holiday',
          date: target,
          status: DayStatus.publicHoliday,
        ),
      },
      companyOverrides: <LocalDate, CalendarOverride>{
        target: CalendarOverride(
          id: 'company',
          date: target,
          status: DayStatus.work,
          shift: dayShift(id: 'company-shift'),
        ),
      },
      userOverrides: <LocalDate, CalendarOverride>{
        target: CalendarOverride(
          id: 'user',
          date: target,
          status: DayStatus.rest,
        ),
      },
    );

    expect(
      resolver.resolveDay(target, allLayers).source,
      DaySource.userOverride,
    );

    final withoutUser = ScheduleResolverInput(
      defaultWeek: allLayers.defaultWeek,
      rules: allLayers.rules,
      officialHolidays: allLayers.officialHolidays,
      companyOverrides: allLayers.companyOverrides,
    );
    expect(
      resolver.resolveDay(target, withoutUser).source,
      DaySource.companyOverride,
    );

    final withoutCompany = ScheduleResolverInput(
      defaultWeek: allLayers.defaultWeek,
      rules: allLayers.rules,
      officialHolidays: allLayers.officialHolidays,
    );
    expect(
      resolver.resolveDay(target, withoutCompany).source,
      DaySource.officialHoliday,
    );

    final scheduleOnly = ScheduleResolverInput(
      defaultWeek: allLayers.defaultWeek,
      rules: allLayers.rules,
    );
    expect(
      resolver.resolveDay(target, scheduleOnly).source,
      DaySource.scheduleRule,
    );

    final defaultOnly = ScheduleResolverInput(
      defaultWeek: allLayers.defaultWeek,
    );
    expect(
      resolver.resolveDay(target, defaultOnly).source,
      DaySource.defaultRule,
    );
  });

  test('chooses the highest-priority schedule rule deterministically', () {
    final restRule = WeeklyScheduleRule(
      id: RuleId('higher-priority'),
      name: '临时规则',
      effectiveRange: effectiveRange,
      priority: 50,
      week: WeekTemplate(<int, ScheduleDayTemplate>{
        for (
          var weekday = DateTime.monday;
          weekday <= DateTime.sunday;
          weekday++
        )
          weekday: restTemplate(),
      }),
    );

    final result = resolver.resolveDay(
      target,
      ScheduleResolverInput(
        defaultWeek: standardFiveDayWeek(),
        rules: <ScheduleRule>[workRule, restRule],
      ),
    );

    expect(result.status, DayStatus.rest);
    expect(result.sourceId, 'higher-priority');
  });

  test('adjusted workday reuses the resolved baseline shift', () {
    final result = resolver.resolveDay(
      target,
      ScheduleResolverInput(
        defaultWeek: standardFiveDayWeek(),
        rules: <ScheduleRule>[workRule],
        officialHolidays: <LocalDate, OfficialHoliday>{
          target: OfficialHoliday(
            id: 'adjusted',
            date: target,
            status: DayStatus.adjustedWorkday,
          ),
        },
      ),
    );

    expect(result.status, DayStatus.adjustedWorkday);
    expect(result.shift?.id.value, 'shift-day');
    expect(result.plannedPaidMinutes, 480);
  });

  test('workday overrides require a concrete shift snapshot', () {
    expect(
      () => CalendarOverride(
        id: 'invalid-workday',
        date: target,
        status: DayStatus.work,
      ),
      throwsArgumentError,
    );
  });

  test('range resolution is inclusive and immutable', () {
    final results = resolver.resolveRange(
      DateRange(start: target, end: target.addDays(2)),
      ScheduleResolverInput(defaultWeek: standardFiveDayWeek()),
    );

    expect(results, hasLength(3));
    expect(() => results.add(results.first), throwsUnsupportedError);
  });

  test('future 24 calendar months resolve deterministically', () {
    final range = DateRange(
      start: LocalDate(2026, 9, 1),
      end: LocalDate(2028, 8, 31),
    );
    final alternatingRule = AlternatingWeekScheduleRule(
      id: RuleId('alternating'),
      name: '大小周',
      effectiveRange: DateRange(
        start: LocalDate(2026, 1, 1),
        end: LocalDate(2029, 12, 31),
      ),
      priority: 20,
      anchorWeekStart: LocalDate(2026, 8, 3),
      anchorWeek: sixDayWeek(),
      alternateWeek: standardFiveDayWeek(),
    );
    final input = ScheduleResolverInput(
      defaultWeek: standardFiveDayWeek(),
      rules: <ScheduleRule>[alternatingRule],
    );

    final first = resolver.resolveRange(range, input);
    final second = resolver.resolveRange(range, input);
    String signature(ResolvedCalendarDay day) => <Object?>[
      day.date,
      day.status.name,
      day.shift?.id.value,
      day.source.name,
      day.sourceId,
      day.plannedPaidMinutes,
      day.resolverVersion,
    ].join('|');

    expect(first, hasLength(range.start.daysUntil(range.end) + 1));
    expect(first.map(signature), orderedEquals(second.map(signature)));
    expect(first.map((day) => day.resolverVersion).toSet(), <int>{
      ScheduleResolver.resolverVersion,
    });
  });
}
