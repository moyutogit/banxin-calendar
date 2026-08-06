import 'package:banxin_calendar/features/schedule/application/resolve_calendar_range.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_repository.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_resolver.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_rules.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/schedule_fixtures.dart';

void main() {
  test(
    'loads repository facts and resolves through the domain engine',
    () async {
      final target = LocalDate(2026, 8, 15);
      final repository = _FixtureScheduleRepository(
        userOverrides: <LocalDate, CalendarOverride>{
          target: CalendarOverride(
            id: 'user-rest',
            date: target,
            status: DayStatus.rest,
          ),
        },
      );
      final useCase = ResolveCalendarRange(repository, ScheduleResolver());

      final result = await useCase(
        range: DateRange(start: target, end: target),
        defaultWeek: sixDayWeek(),
      );

      expect(result.single.status, DayStatus.rest);
      expect(result.single.source, DaySource.userOverride);
      expect(repository.requestedRanges, hasLength(4));
    },
  );
}

final class _FixtureScheduleRepository implements ScheduleRepository {
  _FixtureScheduleRepository({required this.userOverrides});

  final Map<LocalDate, CalendarOverride> userOverrides;
  final List<DateRange> requestedRanges = <DateRange>[];

  @override
  Future<Map<LocalDate, CalendarOverride>> loadCompanyOverrides(
    DateRange range,
  ) async {
    requestedRanges.add(range);
    return const <LocalDate, CalendarOverride>{};
  }

  @override
  Future<List<ShiftSnapshot>> loadEnabledShifts() async {
    return const <ShiftSnapshot>[];
  }

  @override
  Future<Map<LocalDate, OfficialHoliday>> loadOfficialHolidays(
    DateRange range,
  ) async {
    requestedRanges.add(range);
    return const <LocalDate, OfficialHoliday>{};
  }

  @override
  Future<List<ScheduleRule>> loadRules(DateRange range) async {
    requestedRanges.add(range);
    return const <ScheduleRule>[];
  }

  @override
  Future<Map<LocalDate, CalendarOverride>> loadUserOverrides(
    DateRange range,
  ) async {
    requestedRanges.add(range);
    return userOverrides;
  }
}
