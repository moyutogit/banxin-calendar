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
