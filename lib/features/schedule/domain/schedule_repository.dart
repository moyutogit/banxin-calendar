import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_rules.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';

abstract interface class ScheduleRepository {
  Future<List<ShiftSnapshot>> loadEnabledShifts();

  Future<List<ScheduleRule>> loadRules(DateRange range);

  Future<Map<LocalDate, CalendarOverride>> loadUserOverrides(DateRange range);

  Future<Map<LocalDate, CalendarOverride>> loadCompanyOverrides(
    DateRange range,
  );

  Future<Map<LocalDate, OfficialHoliday>> loadOfficialHolidays(DateRange range);
}
