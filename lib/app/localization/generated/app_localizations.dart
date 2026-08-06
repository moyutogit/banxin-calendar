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

  /// No description provided for @assistantConfigureTitle.
  ///
  /// In zh, this message translates to:
  /// **'配置 AI 模型'**
  String get assistantConfigureTitle;

  /// No description provided for @assistantProviderType.
  ///
  /// In zh, this message translates to:
  /// **'接口类型'**
  String get assistantProviderType;

  /// No description provided for @assistantBaseUrl.
  ///
  /// In zh, this message translates to:
  /// **'API 地址'**
  String get assistantBaseUrl;

  /// No description provided for @assistantEndpointPath.
  ///
  /// In zh, this message translates to:
  /// **'请求路径'**
  String get assistantEndpointPath;

  /// No description provided for @assistantModelName.
  ///
  /// In zh, this message translates to:
  /// **'模型名称'**
  String get assistantModelName;

  /// No description provided for @assistantApiKey.
  ///
  /// In zh, this message translates to:
  /// **'API 密钥'**
  String get assistantApiKey;

  /// No description provided for @assistantCustomHeaders.
  ///
  /// In zh, this message translates to:
  /// **'高级请求头（JSON）'**
  String get assistantCustomHeaders;

  /// No description provided for @assistantTimeout.
  ///
  /// In zh, this message translates to:
  /// **'超时秒数'**
  String get assistantTimeout;

  /// No description provided for @assistantMaxTokens.
  ///
  /// In zh, this message translates to:
  /// **'最大输出长度'**
  String get assistantMaxTokens;

  /// No description provided for @assistantStream.
  ///
  /// In zh, this message translates to:
  /// **'流式响应'**
  String get assistantStream;

  /// No description provided for @assistantTestConnection.
  ///
  /// In zh, this message translates to:
  /// **'测试连接'**
  String get assistantTestConnection;

  /// No description provided for @assistantConnectionConnected.
  ///
  /// In zh, this message translates to:
  /// **'连接成功'**
  String get assistantConnectionConnected;

  /// No description provided for @assistantConnectionNotTested.
  ///
  /// In zh, this message translates to:
  /// **'尚未测试'**
  String get assistantConnectionNotTested;

  /// No description provided for @assistantConnectionAuth.
  ///
  /// In zh, this message translates to:
  /// **'鉴权失败'**
  String get assistantConnectionAuth;

  /// No description provided for @assistantConnectionModel.
  ///
  /// In zh, this message translates to:
  /// **'模型不存在或路径错误'**
  String get assistantConnectionModel;

  /// No description provided for @assistantConnectionRate.
  ///
  /// In zh, this message translates to:
  /// **'请求限流'**
  String get assistantConnectionRate;

  /// No description provided for @assistantConnectionBalance.
  ///
  /// In zh, this message translates to:
  /// **'余额不足'**
  String get assistantConnectionBalance;

  /// No description provided for @assistantConnectionNetwork.
  ///
  /// In zh, this message translates to:
  /// **'网络连接失败'**
  String get assistantConnectionNetwork;

  /// No description provided for @assistantConnectionTls.
  ///
  /// In zh, this message translates to:
  /// **'TLS 安全连接失败'**
  String get assistantConnectionTls;

  /// No description provided for @assistantConnectionTimeout.
  ///
  /// In zh, this message translates to:
  /// **'请求超时'**
  String get assistantConnectionTimeout;

  /// No description provided for @assistantConnectionResponse.
  ///
  /// In zh, this message translates to:
  /// **'响应格式不兼容'**
  String get assistantConnectionResponse;

  /// No description provided for @assistantSettingsSaved.
  ///
  /// In zh, this message translates to:
  /// **'AI 设置已安全保存'**
  String get assistantSettingsSaved;

  /// No description provided for @assistantHostChangeWarning.
  ///
  /// In zh, this message translates to:
  /// **'API 域名已变化，密钥将发送到新域名。确认继续吗？'**
  String get assistantHostChangeWarning;

  /// No description provided for @assistantPersonaTitle.
  ///
  /// In zh, this message translates to:
  /// **'助理性格与权限'**
  String get assistantPersonaTitle;

  /// No description provided for @assistantName.
  ///
  /// In zh, this message translates to:
  /// **'助理名称'**
  String get assistantName;

  /// No description provided for @assistantPersonaStyle.
  ///
  /// In zh, this message translates to:
  /// **'性格与说话风格'**
  String get assistantPersonaStyle;

  /// No description provided for @assistantPersonaGentle.
  ///
  /// In zh, this message translates to:
  /// **'温柔陪伴'**
  String get assistantPersonaGentle;

  /// No description provided for @assistantPersonaProfessional.
  ///
  /// In zh, this message translates to:
  /// **'简洁专业'**
  String get assistantPersonaProfessional;

  /// No description provided for @assistantPersonaLively.
  ///
  /// In zh, this message translates to:
  /// **'活泼有趣'**
  String get assistantPersonaLively;

  /// No description provided for @assistantPersonaHumorous.
  ///
  /// In zh, this message translates to:
  /// **'幽默风趣'**
  String get assistantPersonaHumorous;

  /// No description provided for @assistantPersonaSarcastic.
  ///
  /// In zh, this message translates to:
  /// **'吐槽毒舌'**
  String get assistantPersonaSarcastic;

  /// No description provided for @assistantPersonaCalm.
  ///
  /// In zh, this message translates to:
  /// **'冷静克制'**
  String get assistantPersonaCalm;

  /// No description provided for @assistantReplyLength.
  ///
  /// In zh, this message translates to:
  /// **'回复长度'**
  String get assistantReplyLength;

  /// No description provided for @assistantReplyShort.
  ///
  /// In zh, this message translates to:
  /// **'精炼'**
  String get assistantReplyShort;

  /// No description provided for @assistantReplyMedium.
  ///
  /// In zh, this message translates to:
  /// **'适中'**
  String get assistantReplyMedium;

  /// No description provided for @assistantReplyLong.
  ///
  /// In zh, this message translates to:
  /// **'详细啰嗦'**
  String get assistantReplyLong;

  /// No description provided for @assistantScopeSchedule.
  ///
  /// In zh, this message translates to:
  /// **'允许读取排班'**
  String get assistantScopeSchedule;

  /// No description provided for @assistantScopeAttendance.
  ///
  /// In zh, this message translates to:
  /// **'允许读取出勤汇总'**
  String get assistantScopeAttendance;

  /// No description provided for @assistantScopeWage.
  ///
  /// In zh, this message translates to:
  /// **'允许读取工资金额（默认关闭）'**
  String get assistantScopeWage;

  /// No description provided for @assistantScopeAlarm.
  ///
  /// In zh, this message translates to:
  /// **'允许读取闹钟状态'**
  String get assistantScopeAlarm;

  /// No description provided for @assistantScopeNotes.
  ///
  /// In zh, this message translates to:
  /// **'允许读取备注（默认关闭）'**
  String get assistantScopeNotes;

  /// No description provided for @assistantScopeMemory.
  ///
  /// In zh, this message translates to:
  /// **'允许读取和管理本地智能体记忆'**
  String get assistantScopeMemory;

  /// No description provided for @assistantNotConfigured.
  ///
  /// In zh, this message translates to:
  /// **'AI 尚未配置；排班、打卡、工资和闹钟不受影响。'**
  String get assistantNotConfigured;

  /// No description provided for @assistantInputHint.
  ///
  /// In zh, this message translates to:
  /// **'询问排班、工时或提出设置方案'**
  String get assistantInputHint;

  /// No description provided for @assistantSend.
  ///
  /// In zh, this message translates to:
  /// **'发送'**
  String get assistantSend;

  /// No description provided for @assistantStop.
  ///
  /// In zh, this message translates to:
  /// **'停止生成'**
  String get assistantStop;

  /// No description provided for @assistantThinking.
  ///
  /// In zh, this message translates to:
  /// **'思考过程'**
  String get assistantThinking;

  /// No description provided for @assistantThinkingInProgress.
  ///
  /// In zh, this message translates to:
  /// **'正在思考…'**
  String get assistantThinkingInProgress;

  /// No description provided for @assistantPreparingResponse.
  ///
  /// In zh, this message translates to:
  /// **'正在准备回复…'**
  String get assistantPreparingResponse;

  /// No description provided for @assistantRequestFailed.
  ///
  /// In zh, this message translates to:
  /// **'AI 请求失败，请检查模型连接后重试'**
  String get assistantRequestFailed;

  /// No description provided for @assistantQuickAttendance.
  ///
  /// In zh, this message translates to:
  /// **'总结本月出勤'**
  String get assistantQuickAttendance;

  /// No description provided for @assistantQuickSchedule.
  ///
  /// In zh, this message translates to:
  /// **'查看未来 7 天排班'**
  String get assistantQuickSchedule;

  /// No description provided for @assistantQuickWage.
  ///
  /// In zh, this message translates to:
  /// **'预估本月工资'**
  String get assistantQuickWage;

  /// No description provided for @assistantQuickAlarm.
  ///
  /// In zh, this message translates to:
  /// **'检查闹钟'**
  String get assistantQuickAlarm;

  /// No description provided for @assistantQuickPermissionRequired.
  ///
  /// In zh, this message translates to:
  /// **'请先在助理设置中开启对应的数据读取权限'**
  String get assistantQuickPermissionRequired;

  /// No description provided for @assistantProposalTitle.
  ///
  /// In zh, this message translates to:
  /// **'待确认的修改'**
  String get assistantProposalTitle;

  /// No description provided for @assistantProposalConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确认执行'**
  String get assistantProposalConfirm;

  /// No description provided for @assistantProposalCancel.
  ///
  /// In zh, this message translates to:
  /// **'取消，不修改'**
  String get assistantProposalCancel;

  /// No description provided for @assistantActionSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'修改已真实执行'**
  String get assistantActionSucceeded;

  /// No description provided for @assistantActionUndo.
  ///
  /// In zh, this message translates to:
  /// **'撤销修改'**
  String get assistantActionUndo;

  /// No description provided for @assistantActionUndone.
  ///
  /// In zh, this message translates to:
  /// **'修改已撤销'**
  String get assistantActionUndone;

  /// No description provided for @assistantSafetyRefusal.
  ///
  /// In zh, this message translates to:
  /// **'该请求已按安全规则拒绝'**
  String get assistantSafetyRefusal;

  /// No description provided for @assistantConversations.
  ///
  /// In zh, this message translates to:
  /// **'对话列表'**
  String get assistantConversations;

  /// No description provided for @assistantNewConversation.
  ///
  /// In zh, this message translates to:
  /// **'开启新对话'**
  String get assistantNewConversation;

  /// No description provided for @assistantCurrentConversation.
  ///
  /// In zh, this message translates to:
  /// **'当前对话'**
  String get assistantCurrentConversation;

  /// No description provided for @assistantEmptyConversation.
  ///
  /// In zh, this message translates to:
  /// **'新对话已开启，问我任何排班、出勤、工资或闹钟问题吧。'**
  String get assistantEmptyConversation;

  /// No description provided for @onboardingProgress.
  ///
  /// In zh, this message translates to:
  /// **'开始设置 {current}/{total}'**
  String onboardingProgress(int current, int total);

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In zh, this message translates to:
  /// **'欢迎使用班薪日历'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeBody.
  ///
  /// In zh, this message translates to:
  /// **'用一份明确的排班联动日历、闹钟、出勤和工资预估；AI 助理是可选增强，不影响离线核心功能。'**
  String get onboardingWelcomeBody;

  /// No description provided for @onboardingPrivacyTitle.
  ///
  /// In zh, this message translates to:
  /// **'数据默认只在本机'**
  String get onboardingPrivacyTitle;

  /// No description provided for @onboardingPrivacyBody.
  ///
  /// In zh, this message translates to:
  /// **'排班、打卡、工资、对话和智能体记忆保存在本地。API 密钥只进入系统 Keychain/Keystore；只有获得相应数据权限时，AI 才能读取最小范围摘要。'**
  String get onboardingPrivacyBody;

  /// No description provided for @onboardingScheduleTitle.
  ///
  /// In zh, this message translates to:
  /// **'先配置排班'**
  String get onboardingScheduleTitle;

  /// No description provided for @onboardingScheduleBody.
  ///
  /// In zh, this message translates to:
  /// **'选择双休、单休、大小周或 1—31 天自定义周期，设置班次后核对未来 14 天预览。排班是完成引导的必要步骤。'**
  String get onboardingScheduleBody;

  /// No description provided for @onboardingScheduleRequired.
  ///
  /// In zh, this message translates to:
  /// **'请先保存至少一条排班规则，并核对 14 天预览。'**
  String get onboardingScheduleRequired;

  /// No description provided for @onboardingHolidayTitle.
  ///
  /// In zh, this message translates to:
  /// **'节假日与调休'**
  String get onboardingHolidayTitle;

  /// No description provided for @onboardingHolidayBody.
  ///
  /// In zh, this message translates to:
  /// **'可更新中国大陆官方节假日数据。离线时继续使用本地缓存，官方更新不会覆盖你的手工改单。此步可稍后完成。'**
  String get onboardingHolidayBody;

  /// No description provided for @onboardingWageTitle.
  ///
  /// In zh, this message translates to:
  /// **'工资规则（可跳过）'**
  String get onboardingWageTitle;

  /// No description provided for @onboardingWageBody.
  ///
  /// In zh, this message translates to:
  /// **'支持时薪、日薪、月薪和三类加班。跳过后首页只显示设置入口，不会虚构金额。'**
  String get onboardingWageBody;

  /// No description provided for @onboardingAlarmTitle.
  ///
  /// In zh, this message translates to:
  /// **'智能闹钟（可跳过）'**
  String get onboardingAlarmTitle;

  /// No description provided for @onboardingAlarmBody.
  ///
  /// In zh, this message translates to:
  /// **'只有你主动进入并启用闹钟时才申请通知或精确闹钟权限。跳过后首页会保留非阻塞设置提示。'**
  String get onboardingAlarmBody;

  /// No description provided for @onboardingDoneTitle.
  ///
  /// In zh, this message translates to:
  /// **'设置完成'**
  String get onboardingDoneTitle;

  /// No description provided for @onboardingDoneBody.
  ///
  /// In zh, this message translates to:
  /// **'现在可以从首页查看今日班次、打卡、未来安排和提醒状态；所有设置之后都可修改。'**
  String get onboardingDoneBody;

  /// No description provided for @onboardingStartUsing.
  ///
  /// In zh, this message translates to:
  /// **'开始使用'**
  String get onboardingStartUsing;

  /// No description provided for @homeTodayShift.
  ///
  /// In zh, this message translates to:
  /// **'今日班次'**
  String get homeTodayShift;

  /// No description provided for @homeRestToday.
  ///
  /// In zh, this message translates to:
  /// **'今天休息'**
  String get homeRestToday;

  /// No description provided for @punchIn.
  ///
  /// In zh, this message translates to:
  /// **'上班打卡'**
  String get punchIn;

  /// No description provided for @punchOut.
  ///
  /// In zh, this message translates to:
  /// **'下班打卡'**
  String get punchOut;

  /// No description provided for @missingPunch.
  ///
  /// In zh, this message translates to:
  /// **'缺卡'**
  String get missingPunch;

  /// No description provided for @nextAlarm.
  ///
  /// In zh, this message translates to:
  /// **'下一个闹钟'**
  String get nextAlarm;

  /// No description provided for @monthlyEstimatedIncome.
  ///
  /// In zh, this message translates to:
  /// **'本月预计收入'**
  String get monthlyEstimatedIncome;

  /// No description provided for @attendanceDays.
  ///
  /// In zh, this message translates to:
  /// **'出勤天数'**
  String get attendanceDays;

  /// No description provided for @actualHours.
  ///
  /// In zh, this message translates to:
  /// **'实际工时'**
  String get actualHours;

  /// No description provided for @overtimeHours.
  ///
  /// In zh, this message translates to:
  /// **'加班工时'**
  String get overtimeHours;

  /// No description provided for @futureSevenDays.
  ///
  /// In zh, this message translates to:
  /// **'未来 7 天'**
  String get futureSevenDays;

  /// No description provided for @setupWageRule.
  ///
  /// In zh, this message translates to:
  /// **'设置工资规则'**
  String get setupWageRule;

  /// No description provided for @attendanceTitle.
  ///
  /// In zh, this message translates to:
  /// **'出勤记录'**
  String get attendanceTitle;

  /// No description provided for @addAttendance.
  ///
  /// In zh, this message translates to:
  /// **'补录出勤'**
  String get addAttendance;

  /// No description provided for @clockInTime.
  ///
  /// In zh, this message translates to:
  /// **'上班时间'**
  String get clockInTime;

  /// No description provided for @clockOutTime.
  ///
  /// In zh, this message translates to:
  /// **'下班时间'**
  String get clockOutTime;

  /// No description provided for @unpaidBreak.
  ///
  /// In zh, this message translates to:
  /// **'不计薪休息'**
  String get unpaidBreak;

  /// No description provided for @rawWorkMinutes.
  ///
  /// In zh, this message translates to:
  /// **'原始实际分钟'**
  String get rawWorkMinutes;

  /// No description provided for @payableWorkMinutes.
  ///
  /// In zh, this message translates to:
  /// **'取整后计薪分钟'**
  String get payableWorkMinutes;

  /// No description provided for @normalWorkMinutes.
  ///
  /// In zh, this message translates to:
  /// **'正常工时分钟'**
  String get normalWorkMinutes;

  /// No description provided for @overtimeWorkMinutes.
  ///
  /// In zh, this message translates to:
  /// **'加班分钟'**
  String get overtimeWorkMinutes;

  /// No description provided for @attendanceConfirmed.
  ///
  /// In zh, this message translates to:
  /// **'已确认出勤'**
  String get attendanceConfirmed;

  /// No description provided for @attendanceReason.
  ///
  /// In zh, this message translates to:
  /// **'修改原因'**
  String get attendanceReason;

  /// No description provided for @attendanceNote.
  ///
  /// In zh, this message translates to:
  /// **'备注（最多 500 字）'**
  String get attendanceNote;

  /// No description provided for @payrollRecalculationWarning.
  ///
  /// In zh, this message translates to:
  /// **'该日期属于已结算周期，工资需要重新计算。'**
  String get payrollRecalculationWarning;

  /// No description provided for @noAttendanceRecords.
  ///
  /// In zh, this message translates to:
  /// **'暂无出勤记录'**
  String get noAttendanceRecords;

  /// No description provided for @deleteRecord.
  ///
  /// In zh, this message translates to:
  /// **'删除记录'**
  String get deleteRecord;

  /// No description provided for @wageSettingsTitle.
  ///
  /// In zh, this message translates to:
  /// **'工资规则'**
  String get wageSettingsTitle;

  /// No description provided for @wageModeHourly.
  ///
  /// In zh, this message translates to:
  /// **'时薪'**
  String get wageModeHourly;

  /// No description provided for @wageModeDaily.
  ///
  /// In zh, this message translates to:
  /// **'日薪'**
  String get wageModeDaily;

  /// No description provided for @wageModeMonthly.
  ///
  /// In zh, this message translates to:
  /// **'月薪'**
  String get wageModeMonthly;

  /// No description provided for @baseRate.
  ///
  /// In zh, this message translates to:
  /// **'基本金额（元）'**
  String get baseRate;

  /// No description provided for @currencyCode.
  ///
  /// In zh, this message translates to:
  /// **'币种'**
  String get currencyCode;

  /// No description provided for @workdayOvertimeRate.
  ///
  /// In zh, this message translates to:
  /// **'工作日加班倍率'**
  String get workdayOvertimeRate;

  /// No description provided for @restDayOvertimeRate.
  ///
  /// In zh, this message translates to:
  /// **'休息日加班倍率'**
  String get restDayOvertimeRate;

  /// No description provided for @holidayOvertimeRate.
  ///
  /// In zh, this message translates to:
  /// **'法定节假日加班倍率'**
  String get holidayOvertimeRate;

  /// No description provided for @payPeriodStartDay.
  ///
  /// In zh, this message translates to:
  /// **'计薪周期起始日（1-28）'**
  String get payPeriodStartDay;

  /// No description provided for @roundingIncrement.
  ///
  /// In zh, this message translates to:
  /// **'工时取整分钟'**
  String get roundingIncrement;

  /// No description provided for @confirmedOnly.
  ///
  /// In zh, this message translates to:
  /// **'仅计算已确认出勤'**
  String get confirmedOnly;

  /// No description provided for @wageDisclaimer.
  ///
  /// In zh, this message translates to:
  /// **'工资结果仅为个人预估，不替代企业工资条或法定核算。'**
  String get wageDisclaimer;

  /// No description provided for @wageRuleSaved.
  ///
  /// In zh, this message translates to:
  /// **'工资规则已保存'**
  String get wageRuleSaved;

  /// No description provided for @statisticsThisWeek.
  ///
  /// In zh, this message translates to:
  /// **'本周'**
  String get statisticsThisWeek;

  /// No description provided for @statisticsThisMonth.
  ///
  /// In zh, this message translates to:
  /// **'本月'**
  String get statisticsThisMonth;

  /// No description provided for @statisticsLastMonth.
  ///
  /// In zh, this message translates to:
  /// **'上月'**
  String get statisticsLastMonth;

  /// No description provided for @statisticsByWorkDate.
  ///
  /// In zh, this message translates to:
  /// **'按班次开始日'**
  String get statisticsByWorkDate;

  /// No description provided for @statisticsByNaturalDay.
  ///
  /// In zh, this message translates to:
  /// **'按自然日拆分'**
  String get statisticsByNaturalDay;

  /// No description provided for @expectedAttendance.
  ///
  /// In zh, this message translates to:
  /// **'应出勤'**
  String get expectedAttendance;

  /// No description provided for @actualAttendance.
  ///
  /// In zh, this message translates to:
  /// **'实际出勤'**
  String get actualAttendance;

  /// No description provided for @plannedHours.
  ///
  /// In zh, this message translates to:
  /// **'计划工时'**
  String get plannedHours;

  /// No description provided for @normalHours.
  ///
  /// In zh, this message translates to:
  /// **'正常工时'**
  String get normalHours;

  /// No description provided for @lateCount.
  ///
  /// In zh, this message translates to:
  /// **'迟到'**
  String get lateCount;

  /// No description provided for @earlyLeaveCount.
  ///
  /// In zh, this message translates to:
  /// **'早退'**
  String get earlyLeaveCount;

  /// No description provided for @exportCsv.
  ///
  /// In zh, this message translates to:
  /// **'导出 CSV'**
  String get exportCsv;

  /// No description provided for @csvExported.
  ///
  /// In zh, this message translates to:
  /// **'CSV 已保存'**
  String get csvExported;

  /// No description provided for @payrollBreakdown.
  ///
  /// In zh, this message translates to:
  /// **'工资明细'**
  String get payrollBreakdown;

  /// No description provided for @basePay.
  ///
  /// In zh, this message translates to:
  /// **'基本工资'**
  String get basePay;

  /// No description provided for @normalHoursPay.
  ///
  /// In zh, this message translates to:
  /// **'正常工时工资'**
  String get normalHoursPay;

  /// No description provided for @overtimePay.
  ///
  /// In zh, this message translates to:
  /// **'加班工资'**
  String get overtimePay;

  /// No description provided for @workdayOvertimePay.
  ///
  /// In zh, this message translates to:
  /// **'工作日加班工资'**
  String get workdayOvertimePay;

  /// No description provided for @restDayOvertimePay.
  ///
  /// In zh, this message translates to:
  /// **'休息日加班工资'**
  String get restDayOvertimePay;

  /// No description provided for @holidayOvertimePay.
  ///
  /// In zh, this message translates to:
  /// **'法定节假日加班工资'**
  String get holidayOvertimePay;

  /// No description provided for @fixedAllowance.
  ///
  /// In zh, this message translates to:
  /// **'固定补贴（元）'**
  String get fixedAllowance;

  /// No description provided for @fixedDeduction.
  ///
  /// In zh, this message translates to:
  /// **'固定扣款（元）'**
  String get fixedDeduction;

  /// No description provided for @estimatedTotal.
  ///
  /// In zh, this message translates to:
  /// **'预估合计'**
  String get estimatedTotal;

  /// No description provided for @settlePayroll.
  ///
  /// In zh, this message translates to:
  /// **'确认结算'**
  String get settlePayroll;

  /// No description provided for @actualPaidAmount.
  ///
  /// In zh, this message translates to:
  /// **'实发金额（元）'**
  String get actualPaidAmount;

  /// No description provided for @estimatedDifference.
  ///
  /// In zh, this message translates to:
  /// **'与预估差额'**
  String get estimatedDifference;

  /// No description provided for @numericDetails.
  ///
  /// In zh, this message translates to:
  /// **'每日数值明细'**
  String get numericDetails;

  /// No description provided for @alarmSettingsTitle.
  ///
  /// In zh, this message translates to:
  /// **'智能闹钟'**
  String get alarmSettingsTitle;

  /// No description provided for @alarmCapabilityAvailable.
  ///
  /// In zh, this message translates to:
  /// **'提醒能力正常'**
  String get alarmCapabilityAvailable;

  /// No description provided for @alarmCapabilityPermissionRequired.
  ///
  /// In zh, this message translates to:
  /// **'需要通知或精确闹钟权限'**
  String get alarmCapabilityPermissionRequired;

  /// No description provided for @alarmCapabilityUnavailable.
  ///
  /// In zh, this message translates to:
  /// **'当前设备无法提供提醒能力'**
  String get alarmCapabilityUnavailable;

  /// No description provided for @alarmPermissionAction.
  ///
  /// In zh, this message translates to:
  /// **'检查并授权'**
  String get alarmPermissionAction;

  /// No description provided for @alarmSyncAction.
  ///
  /// In zh, this message translates to:
  /// **'立即自检'**
  String get alarmSyncAction;

  /// No description provided for @alarmSyncSuccess.
  ///
  /// In zh, this message translates to:
  /// **'闹钟已同步'**
  String get alarmSyncSuccess;

  /// No description provided for @alarmSyncFailure.
  ///
  /// In zh, this message translates to:
  /// **'部分闹钟同步失败，可稍后重试'**
  String get alarmSyncFailure;

  /// No description provided for @alarmAdjustedSoon.
  ///
  /// In zh, this message translates to:
  /// **'未来 24 小时内的闹钟已调整'**
  String get alarmAdjustedSoon;

  /// No description provided for @alarmTemplateNew.
  ///
  /// In zh, this message translates to:
  /// **'新增闹钟模板'**
  String get alarmTemplateNew;

  /// No description provided for @alarmTemplateEdit.
  ///
  /// In zh, this message translates to:
  /// **'编辑闹钟模板'**
  String get alarmTemplateEdit;

  /// No description provided for @alarmTemplateName.
  ///
  /// In zh, this message translates to:
  /// **'名称'**
  String get alarmTemplateName;

  /// No description provided for @alarmModeFixed.
  ///
  /// In zh, this message translates to:
  /// **'固定时间'**
  String get alarmModeFixed;

  /// No description provided for @alarmModeRelative.
  ///
  /// In zh, this message translates to:
  /// **'班次开始前'**
  String get alarmModeRelative;

  /// No description provided for @alarmTime.
  ///
  /// In zh, this message translates to:
  /// **'提醒时间'**
  String get alarmTime;

  /// No description provided for @alarmOffsetMinutes.
  ///
  /// In zh, this message translates to:
  /// **'提前分钟数'**
  String get alarmOffsetMinutes;

  /// No description provided for @alarmLinkedShifts.
  ///
  /// In zh, this message translates to:
  /// **'关联班次（最多 5 个）'**
  String get alarmLinkedShifts;

  /// No description provided for @alarmVibrate.
  ///
  /// In zh, this message translates to:
  /// **'振动'**
  String get alarmVibrate;

  /// No description provided for @alarmVolumeRamp.
  ///
  /// In zh, this message translates to:
  /// **'音量渐强'**
  String get alarmVolumeRamp;

  /// No description provided for @alarmSnoozeMinutes.
  ///
  /// In zh, this message translates to:
  /// **'稍后提醒分钟数'**
  String get alarmSnoozeMinutes;

  /// No description provided for @alarmMaxSnooze.
  ///
  /// In zh, this message translates to:
  /// **'最大稍后次数'**
  String get alarmMaxSnooze;

  /// No description provided for @alarmUpcoming.
  ///
  /// In zh, this message translates to:
  /// **'未来闹钟'**
  String get alarmUpcoming;

  /// No description provided for @alarmNoTemplates.
  ///
  /// In zh, this message translates to:
  /// **'尚未创建闹钟模板'**
  String get alarmNoTemplates;

  /// No description provided for @alarmNoUpcoming.
  ///
  /// In zh, this message translates to:
  /// **'未来 30 天没有排班闹钟'**
  String get alarmNoUpcoming;

  /// No description provided for @alarmPlatformDisclaimer.
  ///
  /// In zh, this message translates to:
  /// **'Android 精确提醒受系统权限和厂商后台策略影响；iOS 使用本地通知，静音和专注模式可能影响提醒。'**
  String get alarmPlatformDisclaimer;

  /// No description provided for @alarmSaveDidNotBlock.
  ///
  /// In zh, this message translates to:
  /// **'模板已保存，但闹钟同步失败，请检查权限后重试。'**
  String get alarmSaveDidNotBlock;

  /// No description provided for @alarmDeleteTitle.
  ///
  /// In zh, this message translates to:
  /// **'删除闹钟模板？'**
  String get alarmDeleteTitle;

  /// No description provided for @alarmDeleteDescription.
  ///
  /// In zh, this message translates to:
  /// **'删除“{name}”后，关联的未来排班闹钟会被取消。'**
  String alarmDeleteDescription(String name);

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

  /// No description provided for @holidayNetworkUnavailable.
  ///
  /// In zh, this message translates to:
  /// **'无法连接节假日数据源，请检查网络或 VPN 后重试；本地数据未受影响'**
  String get holidayNetworkUnavailable;

  /// No description provided for @holidayYearUnavailable.
  ///
  /// In zh, this message translates to:
  /// **'该年份的官方节假日安排尚未发布；本地数据未受影响'**
  String get holidayYearUnavailable;

  /// No description provided for @holidayDataInvalid.
  ///
  /// In zh, this message translates to:
  /// **'下载的节假日数据未通过校验，已拒绝导入；本地数据未受影响'**
  String get holidayDataInvalid;

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

  /// No description provided for @backupSettingsTitle.
  ///
  /// In zh, this message translates to:
  /// **'备份、恢复与隐私'**
  String get backupSettingsTitle;

  /// No description provided for @localBackupTitle.
  ///
  /// In zh, this message translates to:
  /// **'本地安全备份'**
  String get localBackupTitle;

  /// No description provided for @localBackupDescription.
  ///
  /// In zh, this message translates to:
  /// **'备份使用 SQLite 一致性快照并附带版本、日期范围和 SHA-256 校验；API 密钥与敏感请求头不会写入备份。'**
  String get localBackupDescription;

  /// No description provided for @automaticBackup.
  ///
  /// In zh, this message translates to:
  /// **'自动本地备份'**
  String get automaticBackup;

  /// No description provided for @automaticBackupDescription.
  ///
  /// In zh, this message translates to:
  /// **'每天首次启动时最多创建一份，并至少保留最近 7 份。'**
  String get automaticBackupDescription;

  /// No description provided for @createBackupNow.
  ///
  /// In zh, this message translates to:
  /// **'立即创建备份'**
  String get createBackupNow;

  /// No description provided for @backupCreated.
  ///
  /// In zh, this message translates to:
  /// **'本地备份已创建并校验'**
  String get backupCreated;

  /// No description provided for @recentBackups.
  ///
  /// In zh, this message translates to:
  /// **'最近备份'**
  String get recentBackups;

  /// No description provided for @noBackups.
  ///
  /// In zh, this message translates to:
  /// **'尚无本地备份'**
  String get noBackups;

  /// No description provided for @backupSchema.
  ///
  /// In zh, this message translates to:
  /// **'数据库 v{version}'**
  String backupSchema(int version);

  /// No description provided for @backupCredentialsExcluded.
  ///
  /// In zh, this message translates to:
  /// **'安全凭据已排除'**
  String get backupCredentialsExcluded;

  /// No description provided for @backupEmptyRange.
  ///
  /// In zh, this message translates to:
  /// **'暂无业务日期范围'**
  String get backupEmptyRange;

  /// No description provided for @restoreBackupTitle.
  ///
  /// In zh, this message translates to:
  /// **'恢复这份备份？'**
  String get restoreBackupTitle;

  /// No description provided for @restoreBackupRisk.
  ///
  /// In zh, this message translates to:
  /// **'备份时间：{createdAt}\n数据范围：{dataRange}\n\n恢复会覆盖当前业务数据。系统会先备份当前数据，再校验文件、迁移临时数据库并在单个事务中替换；API 密钥不会从备份恢复。'**
  String restoreBackupRisk(String createdAt, String dataRange);

  /// No description provided for @restoreBackupAction.
  ///
  /// In zh, this message translates to:
  /// **'恢复'**
  String get restoreBackupAction;

  /// No description provided for @restoreBackupSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'备份已恢复，缓存与闹钟已重建'**
  String get restoreBackupSucceeded;

  /// No description provided for @restoreBackupAlarmWarning.
  ///
  /// In zh, this message translates to:
  /// **'数据已恢复；闹钟重建未完全成功，请到闹钟设置重试'**
  String get restoreBackupAlarmWarning;

  /// No description provided for @privacyDataTitle.
  ///
  /// In zh, this message translates to:
  /// **'隐私与数据删除'**
  String get privacyDataTitle;

  /// No description provided for @privacyDataDescription.
  ///
  /// In zh, this message translates to:
  /// **'各类数据可独立清除。除模型安全凭据外，清除前会创建本地安全备份；每项操作都需要两次确认。'**
  String get privacyDataDescription;

  /// No description provided for @clearConversations.
  ///
  /// In zh, this message translates to:
  /// **'清除对话'**
  String get clearConversations;

  /// No description provided for @clearConversationsDescription.
  ///
  /// In zh, this message translates to:
  /// **'删除消息、对话和智能体记忆，保留独立的 AI 操作审计记录。'**
  String get clearConversationsDescription;

  /// No description provided for @clearAssistantActions.
  ///
  /// In zh, this message translates to:
  /// **'清除 AI 操作历史'**
  String get clearAssistantActions;

  /// No description provided for @clearAssistantActionsDescription.
  ///
  /// In zh, this message translates to:
  /// **'删除提案、确认、执行与撤销记录，不修改当前业务数据。'**
  String get clearAssistantActionsDescription;

  /// No description provided for @clearAssistantConfiguration.
  ///
  /// In zh, this message translates to:
  /// **'清除模型配置与凭据'**
  String get clearAssistantConfiguration;

  /// No description provided for @clearAssistantConfigurationDescription.
  ///
  /// In zh, this message translates to:
  /// **'永久删除接口配置、性格设置以及 Keychain/Keystore 中的密钥，普通备份无法恢复密钥。'**
  String get clearAssistantConfigurationDescription;

  /// No description provided for @clearWorkforce.
  ///
  /// In zh, this message translates to:
  /// **'清除工资与考勤'**
  String get clearWorkforce;

  /// No description provided for @clearWorkforceDescription.
  ///
  /// In zh, this message translates to:
  /// **'删除考勤、请假、工资规则和结算快照，保留排班。'**
  String get clearWorkforceDescription;

  /// No description provided for @clearAllData.
  ///
  /// In zh, this message translates to:
  /// **'清除全部 App 数据'**
  String get clearAllData;

  /// No description provided for @clearAllDataDescription.
  ///
  /// In zh, this message translates to:
  /// **'删除全部本地业务数据、AI 数据和安全凭据；本地备份文件仍保留。'**
  String get clearAllDataDescription;

  /// No description provided for @clearDataContinue.
  ///
  /// In zh, this message translates to:
  /// **'继续'**
  String get clearDataContinue;

  /// No description provided for @clearDataSecondConfirm.
  ///
  /// In zh, this message translates to:
  /// **'再次确认清除'**
  String get clearDataSecondConfirm;

  /// No description provided for @clearDataSecondConfirmBody.
  ///
  /// In zh, this message translates to:
  /// **'这是第二次确认。执行后当前页面中的相应数据会立即删除。'**
  String get clearDataSecondConfirmBody;

  /// No description provided for @clearDataConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确认清除'**
  String get clearDataConfirm;

  /// No description provided for @clearDataSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'所选数据已清除'**
  String get clearDataSucceeded;

  /// No description provided for @exportDiagnostics.
  ///
  /// In zh, this message translates to:
  /// **'导出脱敏诊断包'**
  String get exportDiagnostics;

  /// No description provided for @diagnosticsExported.
  ///
  /// In zh, this message translates to:
  /// **'脱敏诊断包已保存'**
  String get diagnosticsExported;

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
