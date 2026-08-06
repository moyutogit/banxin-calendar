// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get alarmSettingsTitle => '智能闹钟';

  @override
  String get alarmCapabilityAvailable => '提醒能力正常';

  @override
  String get alarmCapabilityPermissionRequired => '需要通知或精确闹钟权限';

  @override
  String get alarmCapabilityUnavailable => '当前设备无法提供提醒能力';

  @override
  String get alarmPermissionAction => '检查并授权';

  @override
  String get alarmSyncAction => '立即自检';

  @override
  String get alarmSyncSuccess => '闹钟已同步';

  @override
  String get alarmSyncFailure => '部分闹钟同步失败，可稍后重试';

  @override
  String get alarmAdjustedSoon => '未来 24 小时内的闹钟已调整';

  @override
  String get alarmTemplateNew => '新增闹钟模板';

  @override
  String get alarmTemplateEdit => '编辑闹钟模板';

  @override
  String get alarmTemplateName => '名称';

  @override
  String get alarmModeFixed => '固定时间';

  @override
  String get alarmModeRelative => '班次开始前';

  @override
  String get alarmTime => '提醒时间';

  @override
  String get alarmOffsetMinutes => '提前分钟数';

  @override
  String get alarmLinkedShifts => '关联班次（最多 5 个）';

  @override
  String get alarmVibrate => '振动';

  @override
  String get alarmVolumeRamp => '音量渐强';

  @override
  String get alarmSnoozeMinutes => '稍后提醒分钟数';

  @override
  String get alarmMaxSnooze => '最大稍后次数';

  @override
  String get alarmUpcoming => '未来闹钟';

  @override
  String get alarmNoTemplates => '尚未创建闹钟模板';

  @override
  String get alarmNoUpcoming => '未来 30 天没有排班闹钟';

  @override
  String get alarmPlatformDisclaimer =>
      'Android 精确提醒受系统权限和厂商后台策略影响；iOS 使用本地通知，静音和专注模式可能影响提醒。';

  @override
  String get alarmSaveDidNotBlock => '模板已保存，但闹钟同步失败，请检查权限后重试。';

  @override
  String get appTitle => '班薪日历';

  @override
  String get tabHome => '首页';

  @override
  String get tabCalendar => '日历';

  @override
  String get tabAssistant => 'AI 助理';

  @override
  String get tabStatistics => '统计';

  @override
  String get tabSettings => '我的';

  @override
  String get homeHeadline => '今天，从清楚的排班开始';

  @override
  String get homeDescription => '阶段 0 已接通基础导航、主题、状态管理和本地数据底座。';

  @override
  String get calendarDescription => '月历、日期详情和排班覆盖使用确定性排班引擎。';

  @override
  String get scheduleNotConfiguredTitle => '尚未配置排班';

  @override
  String get scheduleNotConfiguredDescription =>
      '配置排班规则后，日历将在本地生成可核对的工作日、休息日和班次结果。';

  @override
  String get configureScheduleRules => '配置排班规则';

  @override
  String get scheduleRulesTitle => '排班规则';

  @override
  String get scheduleRulesEmptyTitle => '还没有排班规则';

  @override
  String get scheduleRulesEmptyDescription =>
      '排班结果由本地确定性引擎计算；手工改单、公司安排和官方节假日会按固定优先级覆盖规则。';

  @override
  String get supportedScheduleModes => '支持的排班模式';

  @override
  String get scheduleModeFiveDay => '双休';

  @override
  String get scheduleModeSixDay => '单休';

  @override
  String get scheduleModeAlternatingWeek => '大小周';

  @override
  String get scheduleModeCustomCycle => '自定义周期';

  @override
  String get scheduleSetupTitle => '新建排班';

  @override
  String get editScheduleRuleTitle => '编辑排班';

  @override
  String get setupStepMode => '排班模式';

  @override
  String get setupStepShift => '默认班次';

  @override
  String get setupStepCycle => '周期设置';

  @override
  String get setupStepPreview => '确认预览';

  @override
  String get ruleNameLabel => '规则名称';

  @override
  String get shiftNameLabel => '班次名称';

  @override
  String get shiftShortNameLabel => '班次简称';

  @override
  String get shiftStartLabel => '上班时间';

  @override
  String get shiftEndLabel => '下班时间';

  @override
  String get unpaidBreakLabel => '不计薪休息（分钟）';

  @override
  String get crossDayLabel => '跨日班次';

  @override
  String get anchorDateLabel => '锚点日期';

  @override
  String get customCycleLabel => '自定义周期';

  @override
  String get customCycleHint => '用逗号输入“工”或“休”，例如：工,工,夜,夜,休,休';

  @override
  String get actionContinue => '继续';

  @override
  String get actionBack => '上一步';

  @override
  String get actionSave => '保存';

  @override
  String get actionCancel => '取消';

  @override
  String get actionRetry => '重试';

  @override
  String get actionEdit => '编辑';

  @override
  String get actionDuplicate => '复制';

  @override
  String get actionDetails => '详情';

  @override
  String get setupPreviewTitle => '未来 14 天预览';

  @override
  String get setupSavedMessage => '排班已保存';

  @override
  String get invalidFormMessage => '请检查输入内容';

  @override
  String get newScheduleRule => '新建规则';

  @override
  String get ruleEnabled => '已启用';

  @override
  String get ruleDisabled => '已停用';

  @override
  String get calendarToday => '今天';

  @override
  String get calendarPreviousMonth => '上个月';

  @override
  String get calendarNextMonth => '下个月';

  @override
  String get calendarFilter => '筛选';

  @override
  String get calendarAddSchedule => '添加排班';

  @override
  String get weekdayMonday => '一';

  @override
  String get weekdayTuesday => '二';

  @override
  String get weekdayWednesday => '三';

  @override
  String get weekdayThursday => '四';

  @override
  String get weekdayFriday => '五';

  @override
  String get weekdaySaturday => '六';

  @override
  String get weekdaySunday => '日';

  @override
  String get dayStatusWork => '工作';

  @override
  String get dayStatusAdjustedWorkday => '调休上班';

  @override
  String get dayStatusRest => '休息';

  @override
  String get dayStatusPublicHoliday => '法定节假日';

  @override
  String get dayStatusLeave => '请假';

  @override
  String get daySourceDefaultRule => '默认设置';

  @override
  String get daySourceScheduleRule => '排班规则';

  @override
  String get daySourceOfficialHoliday => '官方节假日';

  @override
  String get daySourceCompanyOverride => '公司安排';

  @override
  String get daySourceUserOverride => '手工修改';

  @override
  String get plannedMinutesLabel => '计划分钟';

  @override
  String get modifySchedule => '修改排班';

  @override
  String get restoreRuleResult => '恢复规则结果';

  @override
  String get batchSelection => '批量选择';

  @override
  String get clearSelection => '清除选择';

  @override
  String get selectStatusLabel => '新状态';

  @override
  String get selectShiftLabel => '工作班次';

  @override
  String get previewChanges => '预览修改';

  @override
  String get confirmChanges => '确认修改';

  @override
  String get calendarLoading => '正在生成排班…';

  @override
  String get calendarLoadError => '排班加载失败';

  @override
  String get dayDetailsTitle => '日期详情';

  @override
  String get noShiftLabel => '无班次';

  @override
  String get shiftTimeLabel => '计划时段';

  @override
  String get endsNextDay => '次日结束';

  @override
  String get setAsWork => '设为工作';

  @override
  String get setAsRest => '设为休息';

  @override
  String get minuteUnit => '分钟';

  @override
  String get adjustedWorkBadge => '班';

  @override
  String get holidayBadge => '假';

  @override
  String get leaveBadge => '请';

  @override
  String get defaultScheduleName => '默认排班';

  @override
  String get defaultShiftName => '白班';

  @override
  String get defaultShiftShortName => '白';

  @override
  String get defaultCyclePattern => '工,工,休,休';

  @override
  String get holidaySettingsTitle => '节假日与调休';

  @override
  String get useOfficialHoliday => '使用官方节假日安排';

  @override
  String get updateHolidayData => '更新节假日数据';

  @override
  String get holidayYearLabel => '年份';

  @override
  String get holidayUpdateAdded => '新增';

  @override
  String get holidayUpdateRemoved => '删除';

  @override
  String get holidayUpdateChanged => '变化';

  @override
  String get holidayOfflineRetained => '更新失败，已保留最近一次本地数据';

  @override
  String get holidayDataVersion => '数据版本';

  @override
  String get holidaySourcePapers => '国务院来源文件';

  @override
  String get settingsScheduleAndShift => '排班与班次';

  @override
  String get settingsAlarm => '智能闹钟';

  @override
  String get settingsWage => '工资规则';

  @override
  String get settingsAssistant => 'AI 助理设置';

  @override
  String get settingsBackup => '备份与导出';

  @override
  String get shiftTemplatesTitle => '班次模板';

  @override
  String get newShiftTemplate => '新增班次';

  @override
  String get shiftDisableBlocked => '该班次仍被启用中的排班规则引用，请先替换或停用规则';

  @override
  String get assistantDescription => 'AI 是可选增强模块；未配置模型不影响核心功能。';

  @override
  String get statisticsDescription => '统计只消费领域引擎的确定性结果，不在页面重复计算。';

  @override
  String get settingsDescription => '排班、闹钟、工资、节假日、隐私和备份设置入口。';

  @override
  String get foundationReady => '工程骨架已就绪';

  @override
  String get notConfigured => '尚未配置';
}
