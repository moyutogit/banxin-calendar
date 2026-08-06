import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In zh, this message translates to:
  /// **'班薪日历'**
  String get appTitle;

  /// No description provided for @tabHome.
  ///
  /// In zh, this message translates to:
  /// **'首页'**
  String get tabHome;

  /// No description provided for @tabCalendar.
  ///
  /// In zh, this message translates to:
  /// **'日历'**
  String get tabCalendar;

  /// No description provided for @tabAssistant.
  ///
  /// In zh, this message translates to:
  /// **'AI 助理'**
  String get tabAssistant;

  /// No description provided for @tabStatistics.
  ///
  /// In zh, this message translates to:
  /// **'统计'**
  String get tabStatistics;

  /// No description provided for @tabSettings.
  ///
  /// In zh, this message translates to:
  /// **'我的'**
  String get tabSettings;

  /// No description provided for @homeHeadline.
  ///
  /// In zh, this message translates to:
  /// **'今天，从清楚的排班开始'**
  String get homeHeadline;

  /// No description provided for @homeDescription.
  ///
  /// In zh, this message translates to:
  /// **'阶段 0 已接通基础导航、主题、状态管理和本地数据底座。'**
  String get homeDescription;

  /// No description provided for @calendarDescription.
  ///
  /// In zh, this message translates to:
  /// **'月历、日期详情和排班覆盖使用确定性排班引擎。'**
  String get calendarDescription;

  /// No description provided for @scheduleNotConfiguredTitle.
  ///
  /// In zh, this message translates to:
  /// **'尚未配置排班'**
  String get scheduleNotConfiguredTitle;

  /// No description provided for @scheduleNotConfiguredDescription.
  ///
  /// In zh, this message translates to:
  /// **'配置排班规则后，日历将在本地生成可核对的工作日、休息日和班次结果。'**
  String get scheduleNotConfiguredDescription;

  /// No description provided for @configureScheduleRules.
  ///
  /// In zh, this message translates to:
  /// **'配置排班规则'**
  String get configureScheduleRules;

  /// No description provided for @scheduleRulesTitle.
  ///
  /// In zh, this message translates to:
  /// **'排班规则'**
  String get scheduleRulesTitle;

  /// No description provided for @scheduleRulesEmptyTitle.
  ///
  /// In zh, this message translates to:
  /// **'还没有排班规则'**
  String get scheduleRulesEmptyTitle;

  /// No description provided for @scheduleRulesEmptyDescription.
  ///
  /// In zh, this message translates to:
  /// **'排班结果由本地确定性引擎计算；手工改单、公司安排和官方节假日会按固定优先级覆盖规则。'**
  String get scheduleRulesEmptyDescription;

  /// No description provided for @supportedScheduleModes.
  ///
  /// In zh, this message translates to:
  /// **'支持的排班模式'**
  String get supportedScheduleModes;

  /// No description provided for @scheduleModeFiveDay.
  ///
  /// In zh, this message translates to:
  /// **'双休'**
  String get scheduleModeFiveDay;

  /// No description provided for @scheduleModeSixDay.
  ///
  /// In zh, this message translates to:
  /// **'单休'**
  String get scheduleModeSixDay;

  /// No description provided for @scheduleModeAlternatingWeek.
  ///
  /// In zh, this message translates to:
  /// **'大小周'**
  String get scheduleModeAlternatingWeek;

  /// No description provided for @scheduleModeCustomCycle.
  ///
  /// In zh, this message translates to:
  /// **'自定义周期'**
  String get scheduleModeCustomCycle;

  /// No description provided for @assistantDescription.
  ///
  /// In zh, this message translates to:
  /// **'AI 是可选增强模块；未配置模型不影响核心功能。'**
  String get assistantDescription;

  /// No description provided for @statisticsDescription.
  ///
  /// In zh, this message translates to:
  /// **'统计只消费领域引擎的确定性结果，不在页面重复计算。'**
  String get statisticsDescription;

  /// No description provided for @settingsDescription.
  ///
  /// In zh, this message translates to:
  /// **'排班、闹钟、工资、节假日、隐私和备份设置入口。'**
  String get settingsDescription;

  /// No description provided for @foundationReady.
  ///
  /// In zh, this message translates to:
  /// **'工程骨架已就绪'**
  String get foundationReady;

  /// No description provided for @notConfigured.
  ///
  /// In zh, this message translates to:
  /// **'尚未配置'**
  String get notConfigured;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
