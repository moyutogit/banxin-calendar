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
      expect(repository.cachedWrites, 1);
    },
  );

  test('returns a complete versioned cache without reloading facts', () async {
    final target = LocalDate(2026, 8, 15);
    final cachedDay = ResolvedCalendarDay(
      date: target,
      status: DayStatus.rest,
      shift: null,
      source: DaySource.scheduleRule,
      sourceId: 'cached-rule',
      plannedPaidMinutes: 0,
      tags: const <DayTag>[],
      resolverVersion: ScheduleResolver.resolverVersion,
    );
    final repository = _FixtureScheduleRepository(
      userOverrides: const <LocalDate, CalendarOverride>{},
      cached: <LocalDate, ResolvedCalendarDay>{target: cachedDay},
    );
    final useCase = ResolveCalendarRange(repository, ScheduleResolver());

    final result = await useCase(
      range: DateRange(start: target, end: target),
      defaultWeek: sixDayWeek(),
    );

    expect(result.single.sourceId, 'cached-rule');
    expect(repository.requestedRanges, isEmpty);
    expect(repository.cachedWrites, 0);
  });
}

final class _FixtureScheduleRepository implements ScheduleRepository {
  _FixtureScheduleRepository({
    required this.userOverrides,
    this.cached = const <LocalDate, ResolvedCalendarDay>{},
  });

  final Map<LocalDate, CalendarOverride> userOverrides;
  final Map<LocalDate, ResolvedCalendarDay> cached;
  final List<DateRange> requestedRanges = <DateRange>[];
  var cachedWrites = 0;

  @override
  Future<Map<LocalDate, ResolvedCalendarDay>> loadCachedDays({
    required DateRange range,
    required String inputVersion,
    required int resolverVersion,
  }) async => cached;

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
  Future<List<StoredShiftTemplate>> loadStoredShifts() async {
    return const <StoredShiftTemplate>[];
  }

  @override
  Future<String> loadInputVersion() async => '0';

  @override
  Future<bool> isOfficialHolidayEnabled() async => true;

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
  Future<List<StoredScheduleRule>> loadStoredRules() async {
    return const <StoredScheduleRule>[];
  }

  @override
  Future<void> replaceCachedDays({
    required List<ResolvedCalendarDay> days,
    required String inputVersion,
  }) async {
    cachedWrites++;
  }

  @override
  Future<HolidayUpdateSummary> replaceOfficialHolidays({
    required String region,
    required String dataVersion,
    required List<HolidayImportRecord> holidays,
    required int updatedAt,
  }) async {
    return const HolidayUpdateSummary(added: 0, removed: 0, changed: 0);
  }

  @override
  Future<void> restoreOverrides(
    DateRange range, {
    required DaySource source,
  }) async {}

  @override
  Future<void> saveOverrides(
    List<CalendarOverride> overrides, {
    required DaySource source,
  }) async {}

  @override
  Future<void> saveRule(ScheduleRule rule, {required bool enabled}) async {}

  @override
  Future<void> saveScheduleSetup({
    required ShiftSnapshot shift,
    required ScheduleRule rule,
  }) async {}

  @override
  Future<void> saveShift(ShiftSnapshot shift) async {}

  @override
  Future<void> setRuleEnabled(RuleId id, {required bool enabled}) async {}

  @override
  Future<void> setShiftEnabled(ShiftId id, {required bool enabled}) async {}

  @override
  Future<void> setOfficialHolidayEnabled({required bool enabled}) async {}

  @override
  Future<Map<LocalDate, CalendarOverride>> loadUserOverrides(
    DateRange range,
  ) async {
    requestedRanges.add(range);
    return userOverrides;
  }
}
