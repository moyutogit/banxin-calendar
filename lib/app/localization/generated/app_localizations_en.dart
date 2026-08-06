// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get assistantConfigureTitle => 'Configure AI provider';

  @override
  String get assistantProviderType => 'Provider type';

  @override
  String get assistantBaseUrl => 'API base URL';

  @override
  String get assistantEndpointPath => 'Endpoint path';

  @override
  String get assistantModelName => 'Model name';

  @override
  String get assistantApiKey => 'API key';

  @override
  String get assistantCustomHeaders => 'Advanced headers (JSON)';

  @override
  String get assistantTimeout => 'Timeout seconds';

  @override
  String get assistantMaxTokens => 'Maximum output tokens';

  @override
  String get assistantStream => 'Stream responses';

  @override
  String get assistantTestConnection => 'Test connection';

  @override
  String get assistantConnectionConnected => 'Connected';

  @override
  String get assistantConnectionNotTested => 'Not tested';

  @override
  String get assistantConnectionAuth => 'Authentication failed';

  @override
  String get assistantConnectionModel => 'Model not found or endpoint is wrong';

  @override
  String get assistantConnectionRate => 'Rate limited';

  @override
  String get assistantConnectionBalance => 'Insufficient balance';

  @override
  String get assistantConnectionNetwork => 'Network failure';

  @override
  String get assistantConnectionTls => 'TLS connection failed';

  @override
  String get assistantConnectionTimeout => 'Request timed out';

  @override
  String get assistantConnectionResponse => 'Incompatible response';

  @override
  String get assistantSettingsSaved => 'AI settings saved securely';

  @override
  String get assistantHostChangeWarning =>
      'The API host changed. The key will be sent to the new host. Continue?';

  @override
  String get assistantPersonaTitle => 'Persona and data permissions';

  @override
  String get assistantName => 'Assistant name';

  @override
  String get assistantPersonaGentle => 'Gentle companion';

  @override
  String get assistantPersonaProfessional => 'Concise professional';

  @override
  String get assistantPersonaLively => 'Lively and fun';

  @override
  String get assistantReplyLength => 'Reply length';

  @override
  String get assistantScopeSchedule => 'Allow schedule summaries';

  @override
  String get assistantScopeAttendance => 'Allow attendance summaries';

  @override
  String get assistantScopeWage => 'Allow wage amounts (off by default)';

  @override
  String get assistantScopeAlarm => 'Allow alarm status';

  @override
  String get assistantScopeNotes => 'Allow notes (off by default)';

  @override
  String get assistantNotConfigured =>
      'AI is not configured. Schedule, attendance, wage, and alarm features are unaffected.';

  @override
  String get assistantInputHint =>
      'Ask about schedules or hours, or propose a setting';

  @override
  String get assistantSend => 'Send';

  @override
  String get assistantStop => 'Stop generating';

  @override
  String get assistantQuickAttendance => 'Summarize this month\'s attendance';

  @override
  String get assistantQuickSchedule => 'Show the next 7 days';

  @override
  String get assistantQuickWage => 'Estimate this month\'s wage';

  @override
  String get assistantQuickAlarm => 'Check alarms';

  @override
  String get assistantProposalTitle => 'Change awaiting confirmation';

  @override
  String get assistantProposalConfirm => 'Confirm and apply';

  @override
  String get assistantProposalCancel => 'Cancel without changes';

  @override
  String get assistantActionSucceeded => 'The change was actually applied';

  @override
  String get assistantActionUndo => 'Undo change';

  @override
  String get assistantActionUndone => 'The change was undone';

  @override
  String get assistantSafetyRefusal =>
      'The request was refused by the safety policy';

  @override
  String get homeTodayShift => 'Today\'s shift';

  @override
  String get homeRestToday => 'Rest day';

  @override
  String get punchIn => 'Clock in';

  @override
  String get punchOut => 'Clock out';

  @override
  String get missingPunch => 'Missing punch';

  @override
  String get nextAlarm => 'Next alarm';

  @override
  String get monthlyEstimatedIncome => 'Estimated monthly income';

  @override
  String get attendanceDays => 'Attendance days';

  @override
  String get actualHours => 'Actual hours';

  @override
  String get overtimeHours => 'Overtime hours';

  @override
  String get futureSevenDays => 'Next 7 days';

  @override
  String get setupWageRule => 'Set up wage rule';

  @override
  String get attendanceTitle => 'Attendance';

  @override
  String get addAttendance => 'Add attendance';

  @override
  String get clockInTime => 'Clock-in time';

  @override
  String get clockOutTime => 'Clock-out time';

  @override
  String get unpaidBreak => 'Unpaid break';

  @override
  String get rawWorkMinutes => 'Raw actual minutes';

  @override
  String get payableWorkMinutes => 'Rounded payable minutes';

  @override
  String get normalWorkMinutes => 'Normal minutes';

  @override
  String get overtimeWorkMinutes => 'Overtime minutes';

  @override
  String get attendanceConfirmed => 'Attendance confirmed';

  @override
  String get attendanceReason => 'Edit reason';

  @override
  String get attendanceNote => 'Note (up to 500 characters)';

  @override
  String get payrollRecalculationWarning =>
      'This date is in a settled period. Payroll must be recalculated.';

  @override
  String get noAttendanceRecords => 'No attendance records';

  @override
  String get deleteRecord => 'Delete record';

  @override
  String get wageSettingsTitle => 'Wage rules';

  @override
  String get wageModeHourly => 'Hourly';

  @override
  String get wageModeDaily => 'Daily';

  @override
  String get wageModeMonthly => 'Monthly';

  @override
  String get baseRate => 'Base amount';

  @override
  String get currencyCode => 'Currency';

  @override
  String get workdayOvertimeRate => 'Workday overtime multiplier';

  @override
  String get restDayOvertimeRate => 'Rest-day overtime multiplier';

  @override
  String get holidayOvertimeRate => 'Public-holiday overtime multiplier';

  @override
  String get payPeriodStartDay => 'Pay period start day (1-28)';

  @override
  String get roundingIncrement => 'Time rounding increment';

  @override
  String get confirmedOnly => 'Count confirmed attendance only';

  @override
  String get wageDisclaimer =>
      'Payroll is a personal estimate and does not replace an employer payslip or legal calculation.';

  @override
  String get wageRuleSaved => 'Wage rule saved';

  @override
  String get statisticsThisWeek => 'This week';

  @override
  String get statisticsThisMonth => 'This month';

  @override
  String get statisticsLastMonth => 'Last month';

  @override
  String get expectedAttendance => 'Expected attendance';

  @override
  String get actualAttendance => 'Actual attendance';

  @override
  String get plannedHours => 'Planned hours';

  @override
  String get normalHours => 'Normal hours';

  @override
  String get lateCount => 'Late';

  @override
  String get earlyLeaveCount => 'Early leave';

  @override
  String get exportCsv => 'Export CSV';

  @override
  String get csvExported => 'CSV saved';

  @override
  String get payrollBreakdown => 'Payroll breakdown';

  @override
  String get basePay => 'Base pay';

  @override
  String get normalHoursPay => 'Normal-hours pay';

  @override
  String get overtimePay => 'Overtime pay';

  @override
  String get estimatedTotal => 'Estimated total';

  @override
  String get settlePayroll => 'Settle payroll';

  @override
  String get actualPaidAmount => 'Actual paid amount';

  @override
  String get estimatedDifference => 'Difference from estimate';

  @override
  String get numericDetails => 'Daily numeric details';

  @override
  String get alarmSettingsTitle => 'Smart alarms';

  @override
  String get alarmCapabilityAvailable => 'Reminder capability is available';

  @override
  String get alarmCapabilityPermissionRequired =>
      'Notification or exact alarm permission is required';

  @override
  String get alarmCapabilityUnavailable =>
      'Reminders are unavailable on this device';

  @override
  String get alarmPermissionAction => 'Check and authorize';

  @override
  String get alarmSyncAction => 'Run self-check';

  @override
  String get alarmSyncSuccess => 'Alarms synchronized';

  @override
  String get alarmSyncFailure =>
      'Some alarms failed to synchronize. You can retry later.';

  @override
  String get alarmAdjustedSoon =>
      'An alarm within the next 24 hours was adjusted';

  @override
  String get alarmTemplateNew => 'New alarm template';

  @override
  String get alarmTemplateEdit => 'Edit alarm template';

  @override
  String get alarmTemplateName => 'Name';

  @override
  String get alarmModeFixed => 'Fixed time';

  @override
  String get alarmModeRelative => 'Before shift starts';

  @override
  String get alarmTime => 'Reminder time';

  @override
  String get alarmOffsetMinutes => 'Minutes before';

  @override
  String get alarmLinkedShifts => 'Linked shifts (up to 5)';

  @override
  String get alarmVibrate => 'Vibrate';

  @override
  String get alarmVolumeRamp => 'Gradually increase volume';

  @override
  String get alarmSnoozeMinutes => 'Snooze minutes';

  @override
  String get alarmMaxSnooze => 'Maximum snoozes';

  @override
  String get alarmUpcoming => 'Upcoming alarms';

  @override
  String get alarmNoTemplates => 'No alarm templates yet';

  @override
  String get alarmNoUpcoming => 'No schedule alarms in the next 30 days';

  @override
  String get alarmPlatformDisclaimer =>
      'Android exact reminders depend on system permission and vendor background policies. iOS uses local notifications, which can be affected by Silent and Focus modes.';

  @override
  String get alarmSaveDidNotBlock =>
      'The template was saved, but alarm sync failed. Check permission and retry.';

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
