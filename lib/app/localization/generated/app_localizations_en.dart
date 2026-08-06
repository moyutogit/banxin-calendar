// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Shift & Pay Calendar';

  @override
  String get tabHome => 'Home';

  @override
  String get tabCalendar => 'Calendar';

  @override
  String get tabAssistant => 'Assistant';

  @override
  String get tabStatistics => 'Statistics';

  @override
  String get tabSettings => 'Profile';

  @override
  String get homeHeadline => 'Start today with a clear schedule';

  @override
  String get homeDescription =>
      'Phase 0 wires navigation, theming, state management, and local data foundations.';

  @override
  String get calendarDescription =>
      'Calendar details and overrides use the deterministic scheduling engine.';

  @override
  String get scheduleNotConfiguredTitle => 'Schedule not configured';

  @override
  String get scheduleNotConfiguredDescription =>
      'Configure a schedule rule to generate verifiable workdays, rest days, and shifts locally.';

  @override
  String get configureScheduleRules => 'Configure schedule rules';

  @override
  String get scheduleRulesTitle => 'Schedule rules';

  @override
  String get scheduleRulesEmptyTitle => 'No schedule rules yet';

  @override
  String get scheduleRulesEmptyDescription =>
      'Schedule results are calculated by the local deterministic engine. Manual overrides, company arrangements, and official holidays take precedence in a fixed order.';

  @override
  String get supportedScheduleModes => 'Supported schedule modes';

  @override
  String get scheduleModeFiveDay => 'Five-day week';

  @override
  String get scheduleModeSixDay => 'Six-day week';

  @override
  String get scheduleModeAlternatingWeek => 'Alternating weeks';

  @override
  String get scheduleModeCustomCycle => 'Custom cycle';

  @override
  String get scheduleSetupTitle => 'New schedule';

  @override
  String get editScheduleRuleTitle => 'Edit schedule';

  @override
  String get setupStepMode => 'Schedule mode';

  @override
  String get setupStepShift => 'Default shift';

  @override
  String get setupStepCycle => 'Cycle settings';

  @override
  String get setupStepPreview => 'Confirm preview';

  @override
  String get ruleNameLabel => 'Rule name';

  @override
  String get shiftNameLabel => 'Shift name';

  @override
  String get shiftShortNameLabel => 'Shift abbreviation';

  @override
  String get shiftStartLabel => 'Start time';

  @override
  String get shiftEndLabel => 'End time';

  @override
  String get unpaidBreakLabel => 'Unpaid break (minutes)';

  @override
  String get crossDayLabel => 'Cross-midnight shift';

  @override
  String get anchorDateLabel => 'Anchor date';

  @override
  String get customCycleLabel => 'Custom cycle';

  @override
  String get customCycleHint =>
      'Enter work or rest separated by commas, for example: work,work,rest,rest';

  @override
  String get actionContinue => 'Continue';

  @override
  String get actionBack => 'Back';

  @override
  String get actionSave => 'Save';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get actionRetry => 'Retry';

  @override
  String get actionEdit => 'Edit';

  @override
  String get actionDuplicate => 'Duplicate';

  @override
  String get actionDetails => 'Details';

  @override
  String get setupPreviewTitle => 'Next 14 days';

  @override
  String get setupSavedMessage => 'Schedule saved';

  @override
  String get invalidFormMessage => 'Check the entered values';

  @override
  String get newScheduleRule => 'New rule';

  @override
  String get ruleEnabled => 'Enabled';

  @override
  String get ruleDisabled => 'Disabled';

  @override
  String get calendarToday => 'Today';

  @override
  String get calendarPreviousMonth => 'Previous month';

  @override
  String get calendarNextMonth => 'Next month';

  @override
  String get calendarFilter => 'Filter';

  @override
  String get calendarAddSchedule => 'Add schedule';

  @override
  String get weekdayMonday => 'M';

  @override
  String get weekdayTuesday => 'T';

  @override
  String get weekdayWednesday => 'W';

  @override
  String get weekdayThursday => 'T';

  @override
  String get weekdayFriday => 'F';

  @override
  String get weekdaySaturday => 'S';

  @override
  String get weekdaySunday => 'S';

  @override
  String get dayStatusWork => 'Work';

  @override
  String get dayStatusAdjustedWorkday => 'Adjusted workday';

  @override
  String get dayStatusRest => 'Rest';

  @override
  String get dayStatusPublicHoliday => 'Public holiday';

  @override
  String get dayStatusLeave => 'Leave';

  @override
  String get daySourceDefaultRule => 'Default settings';

  @override
  String get daySourceScheduleRule => 'Schedule rule';

  @override
  String get daySourceOfficialHoliday => 'Official holiday';

  @override
  String get daySourceCompanyOverride => 'Company arrangement';

  @override
  String get daySourceUserOverride => 'Manual override';

  @override
  String get plannedMinutesLabel => 'Planned minutes';

  @override
  String get modifySchedule => 'Modify schedule';

  @override
  String get restoreRuleResult => 'Restore rule result';

  @override
  String get batchSelection => 'Batch selection';

  @override
  String get clearSelection => 'Clear selection';

  @override
  String get selectStatusLabel => 'New status';

  @override
  String get selectShiftLabel => 'Work shift';

  @override
  String get previewChanges => 'Preview changes';

  @override
  String get confirmChanges => 'Confirm changes';

  @override
  String get calendarLoading => 'Generating schedule…';

  @override
  String get calendarLoadError => 'Could not load schedule';

  @override
  String get dayDetailsTitle => 'Day details';

  @override
  String get noShiftLabel => 'No shift';

  @override
  String get shiftTimeLabel => 'Planned time';

  @override
  String get endsNextDay => 'Ends next day';

  @override
  String get setAsWork => 'Set as work';

  @override
  String get setAsRest => 'Set as rest';

  @override
  String get minuteUnit => 'minutes';

  @override
  String get adjustedWorkBadge => 'W';

  @override
  String get holidayBadge => 'H';

  @override
  String get leaveBadge => 'L';

  @override
  String get defaultScheduleName => 'Default schedule';

  @override
  String get defaultShiftName => 'Day shift';

  @override
  String get defaultShiftShortName => 'Day';

  @override
  String get defaultCyclePattern => 'work,work,rest,rest';

  @override
  String get holidaySettingsTitle => 'Holidays and adjustments';

  @override
  String get useOfficialHoliday => 'Use official holiday arrangements';

  @override
  String get updateHolidayData => 'Update holiday data';

  @override
  String get holidayYearLabel => 'Year';

  @override
  String get holidayUpdateAdded => 'Added';

  @override
  String get holidayUpdateRemoved => 'Removed';

  @override
  String get holidayUpdateChanged => 'Changed';

  @override
  String get holidayOfflineRetained =>
      'Update failed. The latest local data was retained.';

  @override
  String get holidayDataVersion => 'Data version';

  @override
  String get holidaySourcePapers => 'Government source documents';

  @override
  String get settingsScheduleAndShift => 'Schedule and shifts';

  @override
  String get settingsAlarm => 'Smart alarms';

  @override
  String get settingsWage => 'Wage rules';

  @override
  String get settingsAssistant => 'Assistant settings';

  @override
  String get settingsBackup => 'Backup and export';

  @override
  String get shiftTemplatesTitle => 'Shift templates';

  @override
  String get newShiftTemplate => 'New shift';

  @override
  String get shiftDisableBlocked =>
      'This shift is referenced by an enabled schedule rule. Replace or disable that rule first.';

  @override
  String get assistantDescription =>
      'AI is optional; core features continue to work without a model provider.';

  @override
  String get statisticsDescription =>
      'Statistics consume deterministic domain results instead of recalculating in widgets.';

  @override
  String get settingsDescription =>
      'Schedule, alarm, wage, holiday, privacy, and backup settings.';

  @override
  String get foundationReady => 'Project foundation ready';

  @override
  String get notConfigured => 'Not configured';
}
