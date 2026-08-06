import 'package:banxin_calendar/app/localization/generated/app_localizations.dart';
import 'package:banxin_calendar/features/schedule/application/schedule_application_service.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';

extension ScheduleLocalizations on AppLocalizations {
  String scheduleModeLabel(SchedulePresetMode mode) {
    return switch (mode) {
      SchedulePresetMode.fiveDay => scheduleModeFiveDay,
      SchedulePresetMode.sixDay => scheduleModeSixDay,
      SchedulePresetMode.alternatingWeek => scheduleModeAlternatingWeek,
      SchedulePresetMode.customCycle => scheduleModeCustomCycle,
    };
  }

  String dayStatusLabel(DayStatus status) {
    return switch (status) {
      DayStatus.work => dayStatusWork,
      DayStatus.adjustedWorkday => dayStatusAdjustedWorkday,
      DayStatus.rest => dayStatusRest,
      DayStatus.publicHoliday => dayStatusPublicHoliday,
      DayStatus.leave => dayStatusLeave,
    };
  }

  String daySourceLabel(DaySource source) {
    return switch (source) {
      DaySource.defaultRule => daySourceDefaultRule,
      DaySource.scheduleRule => daySourceScheduleRule,
      DaySource.officialHoliday => daySourceOfficialHoliday,
      DaySource.companyOverride => daySourceCompanyOverride,
      DaySource.userOverride => daySourceUserOverride,
    };
  }
}
