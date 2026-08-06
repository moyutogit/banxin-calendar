import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_rules.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';

abstract interface class ScheduleRepository {
  Future<List<ShiftSnapshot>> loadEnabledShifts();

  Future<List<StoredShiftTemplate>> loadStoredShifts();

  Future<List<StoredScheduleRule>> loadStoredRules();

  Future<List<ScheduleRule>> loadRules(DateRange range);

  Future<Map<LocalDate, CalendarOverride>> loadUserOverrides(DateRange range);

  Future<Map<LocalDate, CalendarOverride>> loadCompanyOverrides(
    DateRange range,
  );

  Future<Map<LocalDate, OfficialHoliday>> loadOfficialHolidays(DateRange range);

  Future<bool> isOfficialHolidayEnabled();

  Future<void> setOfficialHolidayEnabled({required bool enabled});

  Future<String> loadInputVersion();

  Future<Map<LocalDate, ResolvedCalendarDay>> loadCachedDays({
    required DateRange range,
    required String inputVersion,
    required int resolverVersion,
  });

  Future<void> replaceCachedDays({
    required List<ResolvedCalendarDay> days,
    required String inputVersion,
  });

  Future<void> saveShift(ShiftSnapshot shift);

  Future<void> setShiftEnabled(ShiftId id, {required bool enabled});

  Future<void> saveScheduleSetup({
    required ShiftSnapshot shift,
    required ScheduleRule rule,
  });

  Future<void> saveRule(ScheduleRule rule, {required bool enabled});

  Future<void> setRuleEnabled(RuleId id, {required bool enabled});

  Future<void> saveOverrides(
    List<CalendarOverride> overrides, {
    required DaySource source,
  });

  Future<void> restoreOverrides(DateRange range, {required DaySource source});

  Future<HolidayUpdateSummary> replaceOfficialHolidays({
    required String region,
    required String dataVersion,
    required List<HolidayImportRecord> holidays,
    required int updatedAt,
  });
}
