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

  /// No description provided for @scheduleSetupTitle.
  ///
  /// In zh, this message translates to:
  /// **'新建排班'**
  String get scheduleSetupTitle;

  /// No description provided for @editScheduleRuleTitle.
  ///
  /// In zh, this message translates to:
  /// **'编辑排班'**
  String get editScheduleRuleTitle;

  /// No description provided for @setupStepMode.
  ///
  /// In zh, this message translates to:
  /// **'排班模式'**
  String get setupStepMode;

  /// No description provided for @setupStepShift.
  ///
  /// In zh, this message translates to:
  /// **'默认班次'**
  String get setupStepShift;

  /// No description provided for @setupStepCycle.
  ///
  /// In zh, this message translates to:
  /// **'周期设置'**
  String get setupStepCycle;

  /// No description provided for @setupStepPreview.
  ///
  /// In zh, this message translates to:
  /// **'确认预览'**
  String get setupStepPreview;

  /// No description provided for @ruleNameLabel.
  ///
  /// In zh, this message translates to:
  /// **'规则名称'**
  String get ruleNameLabel;

  /// No description provided for @shiftNameLabel.
  ///
  /// In zh, this message translates to:
  /// **'班次名称'**
  String get shiftNameLabel;

  /// No description provided for @shiftShortNameLabel.
  ///
  /// In zh, this message translates to:
  /// **'班次简称'**
  String get shiftShortNameLabel;

  /// No description provided for @shiftStartLabel.
  ///
  /// In zh, this message translates to:
  /// **'上班时间'**
  String get shiftStartLabel;

  /// No description provided for @shiftEndLabel.
  ///
  /// In zh, this message translates to:
  /// **'下班时间'**
  String get shiftEndLabel;

  /// No description provided for @unpaidBreakLabel.
  ///
  /// In zh, this message translates to:
  /// **'不计薪休息（分钟）'**
  String get unpaidBreakLabel;

  /// No description provided for @crossDayLabel.
  ///
  /// In zh, this message translates to:
  /// **'跨日班次'**
  String get crossDayLabel;

  /// No description provided for @anchorDateLabel.
  ///
  /// In zh, this message translates to:
  /// **'锚点日期'**
  String get anchorDateLabel;

  /// No description provided for @customCycleLabel.
  ///
  /// In zh, this message translates to:
  /// **'自定义周期'**
  String get customCycleLabel;

  /// No description provided for @customCycleHint.
  ///
  /// In zh, this message translates to:
  /// **'用逗号输入“工”或“休”，例如：工,工,夜,夜,休,休'**
  String get customCycleHint;

  /// No description provided for @actionContinue.
  ///
  /// In zh, this message translates to:
  /// **'继续'**
  String get actionContinue;

  /// No description provided for @actionBack.
  ///
  /// In zh, this message translates to:
  /// **'上一步'**
  String get actionBack;

  /// No description provided for @actionSave.
  ///
  /// In zh, this message translates to:
  /// **'保存'**
  String get actionSave;

  /// No description provided for @actionCancel.
  ///
  /// In zh, this message translates to:
  /// **'取消'**
  String get actionCancel;

  /// No description provided for @actionRetry.
  ///
  /// In zh, this message translates to:
  /// **'重试'**
  String get actionRetry;

  /// No description provided for @actionEdit.
  ///
  /// In zh, this message translates to:
  /// **'编辑'**
  String get actionEdit;

  /// No description provided for @actionDuplicate.
  ///
  /// In zh, this message translates to:
  /// **'复制'**
  String get actionDuplicate;

  /// No description provided for @actionDetails.
  ///
  /// In zh, this message translates to:
  /// **'详情'**
  String get actionDetails;

  /// No description provided for @setupPreviewTitle.
  ///
  /// In zh, this message translates to:
  /// **'未来 14 天预览'**
  String get setupPreviewTitle;

  /// No description provided for @setupSavedMessage.
  ///
  /// In zh, this message translates to:
  /// **'排班已保存'**
  String get setupSavedMessage;

  /// No description provided for @invalidFormMessage.
  ///
  /// In zh, this message translates to:
  /// **'请检查输入内容'**
  String get invalidFormMessage;

  /// No description provided for @newScheduleRule.
  ///
  /// In zh, this message translates to:
  /// **'新建规则'**
  String get newScheduleRule;

  /// No description provided for @ruleEnabled.
  ///
  /// In zh, this message translates to:
  /// **'已启用'**
  String get ruleEnabled;

  /// No description provided for @ruleDisabled.
  ///
  /// In zh, this message translates to:
  /// **'已停用'**
  String get ruleDisabled;

  /// No description provided for @calendarToday.
  ///
  /// In zh, this message translates to:
  /// **'今天'**
  String get calendarToday;

  /// No description provided for @calendarPreviousMonth.
  ///
  /// In zh, this message translates to:
  /// **'上个月'**
  String get calendarPreviousMonth;

  /// No description provided for @calendarNextMonth.
  ///
  /// In zh, this message translates to:
  /// **'下个月'**
  String get calendarNextMonth;

  /// No description provided for @calendarFilter.
  ///
  /// In zh, this message translates to:
  /// **'筛选'**
  String get calendarFilter;

  /// No description provided for @calendarAddSchedule.
  ///
  /// In zh, this message translates to:
  /// **'添加排班'**
  String get calendarAddSchedule;

  /// No description provided for @weekdayMonday.
  ///
  /// In zh, this message translates to:
  /// **'一'**
  String get weekdayMonday;

  /// No description provided for @weekdayTuesday.
  ///
  /// In zh, this message translates to:
  /// **'二'**
  String get weekdayTuesday;

  /// No description provided for @weekdayWednesday.
  ///
  /// In zh, this message translates to:
  /// **'三'**
  String get weekdayWednesday;

  /// No description provided for @weekdayThursday.
  ///
  /// In zh, this message translates to:
  /// **'四'**
  String get weekdayThursday;

  /// No description provided for @weekdayFriday.
  ///
  /// In zh, this message translates to:
  /// **'五'**
  String get weekdayFriday;

  /// No description provided for @weekdaySaturday.
  ///
  /// In zh, this message translates to:
  /// **'六'**
  String get weekdaySaturday;

  /// No description provided for @weekdaySunday.
  ///
  /// In zh, this message translates to:
  /// **'日'**
  String get weekdaySunday;

  /// No description provided for @dayStatusWork.
  ///
  /// In zh, this message translates to:
  /// **'工作'**
  String get dayStatusWork;

  /// No description provided for @dayStatusAdjustedWorkday.
  ///
  /// In zh, this message translates to:
  /// **'调休上班'**
  String get dayStatusAdjustedWorkday;

  /// No description provided for @dayStatusRest.
  ///
  /// In zh, this message translates to:
  /// **'休息'**
  String get dayStatusRest;

  /// No description provided for @dayStatusPublicHoliday.
  ///
  /// In zh, this message translates to:
  /// **'法定节假日'**
  String get dayStatusPublicHoliday;

  /// No description provided for @dayStatusLeave.
  ///
  /// In zh, this message translates to:
  /// **'请假'**
  String get dayStatusLeave;

  /// No description provided for @daySourceDefaultRule.
  ///
  /// In zh, this message translates to:
  /// **'默认设置'**
  String get daySourceDefaultRule;

  /// No description provided for @daySourceScheduleRule.
  ///
  /// In zh, this message translates to:
  /// **'排班规则'**
  String get daySourceScheduleRule;

  /// No description provided for @daySourceOfficialHoliday.
  ///
  /// In zh, this message translates to:
  /// **'官方节假日'**
  String get daySourceOfficialHoliday;

  /// No description provided for @daySourceCompanyOverride.
  ///
  /// In zh, this message translates to:
  /// **'公司安排'**
  String get daySourceCompanyOverride;

  /// No description provided for @daySourceUserOverride.
  ///
  /// In zh, this message translates to:
  /// **'手工修改'**
  String get daySourceUserOverride;

  /// No description provided for @plannedMinutesLabel.
  ///
  /// In zh, this message translates to:
  /// **'计划分钟'**
  String get plannedMinutesLabel;

  /// No description provided for @modifySchedule.
  ///
  /// In zh, this message translates to:
  /// **'修改排班'**
  String get modifySchedule;

  /// No description provided for @restoreRuleResult.
  ///
  /// In zh, this message translates to:
  /// **'恢复规则结果'**
  String get restoreRuleResult;

  /// No description provided for @batchSelection.
  ///
  /// In zh, this message translates to:
  /// **'批量选择'**
  String get batchSelection;

  /// No description provided for @clearSelection.
  ///
  /// In zh, this message translates to:
  /// **'清除选择'**
  String get clearSelection;

  /// No description provided for @selectStatusLabel.
  ///
  /// In zh, this message translates to:
  /// **'新状态'**
  String get selectStatusLabel;

  /// No description provided for @selectShiftLabel.
  ///
  /// In zh, this message translates to:
  /// **'工作班次'**
  String get selectShiftLabel;

  /// No description provided for @previewChanges.
  ///
  /// In zh, this message translates to:
  /// **'预览修改'**
  String get previewChanges;

  /// No description provided for @confirmChanges.
  ///
  /// In zh, this message translates to:
  /// **'确认修改'**
  String get confirmChanges;

  /// No description provided for @calendarLoading.
  ///
  /// In zh, this message translates to:
  /// **'正在生成排班…'**
  String get calendarLoading;

  /// No description provided for @calendarLoadError.
  ///
  /// In zh, this message translates to:
  /// **'排班加载失败'**
  String get calendarLoadError;

  /// No description provided for @dayDetailsTitle.
  ///
  /// In zh, this message translates to:
  /// **'日期详情'**
  String get dayDetailsTitle;

  /// No description provided for @noShiftLabel.
  ///
  /// In zh, this message translates to:
  /// **'无班次'**
  String get noShiftLabel;

  /// No description provided for @shiftTimeLabel.
  ///
  /// In zh, this message translates to:
  /// **'计划时段'**
  String get shiftTimeLabel;

  /// No description provided for @endsNextDay.
  ///
  /// In zh, this message translates to:
  /// **'次日结束'**
  String get endsNextDay;

  /// No description provided for @setAsWork.
  ///
  /// In zh, this message translates to:
  /// **'设为工作'**
  String get setAsWork;

  /// No description provided for @setAsRest.
  ///
  /// In zh, this message translates to:
  /// **'设为休息'**
  String get setAsRest;

  /// No description provided for @minuteUnit.
  ///
  /// In zh, this message translates to:
  /// **'分钟'**
  String get minuteUnit;

  /// No description provided for @adjustedWorkBadge.
  ///
  /// In zh, this message translates to:
  /// **'班'**
  String get adjustedWorkBadge;

  /// No description provided for @holidayBadge.
  ///
  /// In zh, this message translates to:
  /// **'假'**
  String get holidayBadge;

  /// No description provided for @leaveBadge.
  ///
  /// In zh, this message translates to:
  /// **'请'**
  String get leaveBadge;

  /// No description provided for @defaultScheduleName.
  ///
  /// In zh, this message translates to:
  /// **'默认排班'**
  String get defaultScheduleName;

  /// No description provided for @defaultShiftName.
  ///
  /// In zh, this message translates to:
  /// **'白班'**
  String get defaultShiftName;

  /// No description provided for @defaultShiftShortName.
  ///
  /// In zh, this message translates to:
  /// **'白'**
  String get defaultShiftShortName;

  /// No description provided for @defaultCyclePattern.
  ///
  /// In zh, this message translates to:
  /// **'工,工,休,休'**
  String get defaultCyclePattern;

  /// No description provided for @holidaySettingsTitle.
  ///
  /// In zh, this message translates to:
  /// **'节假日与调休'**
  String get holidaySettingsTitle;

  /// No description provided for @useOfficialHoliday.
  ///
  /// In zh, this message translates to:
  /// **'使用官方节假日安排'**
  String get useOfficialHoliday;

  /// No description provided for @updateHolidayData.
  ///
  /// In zh, this message translates to:
  /// **'更新节假日数据'**
  String get updateHolidayData;

  /// No description provided for @holidayYearLabel.
  ///
  /// In zh, this message translates to:
  /// **'年份'**
  String get holidayYearLabel;

  /// No description provided for @holidayUpdateAdded.
  ///
  /// In zh, this message translates to:
  /// **'新增'**
  String get holidayUpdateAdded;

  /// No description provided for @holidayUpdateRemoved.
  ///
  /// In zh, this message translates to:
  /// **'删除'**
  String get holidayUpdateRemoved;

  /// No description provided for @holidayUpdateChanged.
  ///
  /// In zh, this message translates to:
  /// **'变化'**
  String get holidayUpdateChanged;

  /// No description provided for @holidayOfflineRetained.
  ///
  /// In zh, this message translates to:
  /// **'更新失败，已保留最近一次本地数据'**
  String get holidayOfflineRetained;

  /// No description provided for @holidayDataVersion.
  ///
  /// In zh, this message translates to:
  /// **'数据版本'**
  String get holidayDataVersion;

  /// No description provided for @holidaySourcePapers.
  ///
  /// In zh, this message translates to:
  /// **'国务院来源文件'**
  String get holidaySourcePapers;

  /// No description provided for @settingsScheduleAndShift.
  ///
  /// In zh, this message translates to:
  /// **'排班与班次'**
  String get settingsScheduleAndShift;

  /// No description provided for @settingsAlarm.
  ///
  /// In zh, this message translates to:
  /// **'智能闹钟'**
  String get settingsAlarm;

  /// No description provided for @settingsWage.
  ///
  /// In zh, this message translates to:
  /// **'工资规则'**
  String get settingsWage;

  /// No description provided for @settingsAssistant.
  ///
  /// In zh, this message translates to:
  /// **'AI 助理设置'**
  String get settingsAssistant;

  /// No description provided for @settingsBackup.
  ///
  /// In zh, this message translates to:
  /// **'备份与导出'**
  String get settingsBackup;

  /// No description provided for @shiftTemplatesTitle.
  ///
  /// In zh, this message translates to:
  /// **'班次模板'**
  String get shiftTemplatesTitle;

  /// No description provided for @newShiftTemplate.
  ///
  /// In zh, this message translates to:
  /// **'新增班次'**
  String get newShiftTemplate;

  /// No description provided for @shiftDisableBlocked.
  ///
  /// In zh, this message translates to:
  /// **'该班次仍被启用中的排班规则引用，请先替换或停用规则'**
  String get shiftDisableBlocked;

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
