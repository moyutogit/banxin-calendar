// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get assistantConfigureTitle => '配置 AI 模型';

  @override
  String get assistantProviderType => '接口类型';

  @override
  String get assistantBaseUrl => 'API 地址';

  @override
  String get assistantEndpointPath => '请求路径';

  @override
  String get assistantModelName => '模型名称';

  @override
  String get assistantApiKey => 'API 密钥';

  @override
  String get assistantCustomHeaders => '高级请求头（JSON）';

  @override
  String get assistantTimeout => '超时秒数';

  @override
  String get assistantMaxTokens => '最大输出长度';

  @override
  String get assistantStream => '流式响应';

  @override
  String get assistantTestConnection => '测试连接';

  @override
  String get assistantConnectionConnected => '连接成功';

  @override
  String get assistantConnectionNotTested => '尚未测试';

  @override
  String get assistantConnectionAuth => '鉴权失败';

  @override
  String get assistantConnectionModel => '模型不存在或路径错误';

  @override
  String get assistantConnectionRate => '请求限流';

  @override
  String get assistantConnectionBalance => '余额不足';

  @override
  String get assistantConnectionNetwork => '网络连接失败';

  @override
  String get assistantConnectionTls => 'TLS 安全连接失败';

  @override
  String get assistantConnectionTimeout => '请求超时';

  @override
  String get assistantConnectionResponse => '响应格式不兼容';

  @override
  String get assistantSettingsSaved => 'AI 设置已安全保存';

  @override
  String get assistantHostChangeWarning => 'API 域名已变化，密钥将发送到新域名。确认继续吗？';

  @override
  String get assistantPersonaTitle => '助理性格与权限';

  @override
  String get assistantName => '助理名称';

  @override
  String get assistantPersonaGentle => '温柔陪伴';

  @override
  String get assistantPersonaProfessional => '简洁专业';

  @override
  String get assistantPersonaLively => '活泼有趣';

  @override
  String get assistantReplyLength => '回复长度';

  @override
  String get assistantScopeSchedule => '允许读取排班';

  @override
  String get assistantScopeAttendance => '允许读取出勤汇总';

  @override
  String get assistantScopeWage => '允许读取工资金额（默认关闭）';

  @override
  String get assistantScopeAlarm => '允许读取闹钟状态';

  @override
  String get assistantScopeNotes => '允许读取备注（默认关闭）';

  @override
  String get assistantNotConfigured => 'AI 尚未配置；排班、打卡、工资和闹钟不受影响。';

  @override
  String get assistantInputHint => '询问排班、工时或提出设置方案';

  @override
  String get assistantSend => '发送';

  @override
  String get assistantStop => '停止生成';

  @override
  String get assistantThinking => '思考过程';

  @override
  String get assistantThinkingInProgress => '正在思考…';

  @override
  String get assistantPreparingResponse => '正在准备回复…';

  @override
  String get assistantRequestFailed => 'AI 请求失败，请检查模型连接后重试';

  @override
  String get assistantQuickAttendance => '总结本月出勤';

  @override
  String get assistantQuickSchedule => '查看未来 7 天排班';

  @override
  String get assistantQuickWage => '预估本月工资';

  @override
  String get assistantQuickAlarm => '检查闹钟';

  @override
  String get assistantQuickPermissionRequired => '请先在助理设置中开启对应的数据读取权限';

  @override
  String get assistantProposalTitle => '待确认的修改';

  @override
  String get assistantProposalConfirm => '确认执行';

  @override
  String get assistantProposalCancel => '取消，不修改';

  @override
  String get assistantActionSucceeded => '修改已真实执行';

  @override
  String get assistantActionUndo => '撤销修改';

  @override
  String get assistantActionUndone => '修改已撤销';

  @override
  String get assistantSafetyRefusal => '该请求已按安全规则拒绝';

  @override
  String onboardingProgress(int current, int total) {
    return '开始设置 $current/$total';
  }

  @override
  String get onboardingWelcomeTitle => '欢迎使用班薪日历';

  @override
  String get onboardingWelcomeBody =>
      '用一份明确的排班联动日历、闹钟、出勤和工资预估；AI 助理是可选增强，不影响离线核心功能。';

  @override
  String get onboardingPrivacyTitle => '数据默认只在本机';

  @override
  String get onboardingPrivacyBody =>
      '排班、打卡、工资和对话保存在本地。API 密钥只进入系统 Keychain/Keystore；只有获得相应数据权限时，AI 才能读取最小范围摘要。';

  @override
  String get onboardingScheduleTitle => '先配置排班';

  @override
  String get onboardingScheduleBody =>
      '选择双休、单休、大小周或 1—31 天自定义周期，设置班次后核对未来 14 天预览。排班是完成引导的必要步骤。';

  @override
  String get onboardingScheduleRequired => '请先保存至少一条排班规则，并核对 14 天预览。';

  @override
  String get onboardingHolidayTitle => '节假日与调休';

  @override
  String get onboardingHolidayBody =>
      '可更新中国大陆官方节假日数据。离线时继续使用本地缓存，官方更新不会覆盖你的手工改单。此步可稍后完成。';

  @override
  String get onboardingWageTitle => '工资规则（可跳过）';

  @override
  String get onboardingWageBody => '支持时薪、日薪、月薪和三类加班。跳过后首页只显示设置入口，不会虚构金额。';

  @override
  String get onboardingAlarmTitle => '智能闹钟（可跳过）';

  @override
  String get onboardingAlarmBody =>
      '只有你主动进入并启用闹钟时才申请通知或精确闹钟权限。跳过后首页会保留非阻塞设置提示。';

  @override
  String get onboardingDoneTitle => '设置完成';

  @override
  String get onboardingDoneBody => '现在可以从首页查看今日班次、打卡、未来安排和提醒状态；所有设置之后都可修改。';

  @override
  String get onboardingStartUsing => '开始使用';

  @override
  String get homeTodayShift => '今日班次';

  @override
  String get homeRestToday => '今天休息';

  @override
  String get punchIn => '上班打卡';

  @override
  String get punchOut => '下班打卡';

  @override
  String get missingPunch => '缺卡';

  @override
  String get nextAlarm => '下一个闹钟';

  @override
  String get monthlyEstimatedIncome => '本月预计收入';

  @override
  String get attendanceDays => '出勤天数';

  @override
  String get actualHours => '实际工时';

  @override
  String get overtimeHours => '加班工时';

  @override
  String get futureSevenDays => '未来 7 天';

  @override
  String get setupWageRule => '设置工资规则';

  @override
  String get attendanceTitle => '出勤记录';

  @override
  String get addAttendance => '补录出勤';

  @override
  String get clockInTime => '上班时间';

  @override
  String get clockOutTime => '下班时间';

  @override
  String get unpaidBreak => '不计薪休息';

  @override
  String get rawWorkMinutes => '原始实际分钟';

  @override
  String get payableWorkMinutes => '取整后计薪分钟';

  @override
  String get normalWorkMinutes => '正常工时分钟';

  @override
  String get overtimeWorkMinutes => '加班分钟';

  @override
  String get attendanceConfirmed => '已确认出勤';

  @override
  String get attendanceReason => '修改原因';

  @override
  String get attendanceNote => '备注（最多 500 字）';

  @override
  String get payrollRecalculationWarning => '该日期属于已结算周期，工资需要重新计算。';

  @override
  String get noAttendanceRecords => '暂无出勤记录';

  @override
  String get deleteRecord => '删除记录';

  @override
  String get wageSettingsTitle => '工资规则';

  @override
  String get wageModeHourly => '时薪';

  @override
  String get wageModeDaily => '日薪';

  @override
  String get wageModeMonthly => '月薪';

  @override
  String get baseRate => '基本金额（元）';

  @override
  String get currencyCode => '币种';

  @override
  String get workdayOvertimeRate => '工作日加班倍率';

  @override
  String get restDayOvertimeRate => '休息日加班倍率';

  @override
  String get holidayOvertimeRate => '法定节假日加班倍率';

  @override
  String get payPeriodStartDay => '计薪周期起始日（1-28）';

  @override
  String get roundingIncrement => '工时取整分钟';

  @override
  String get confirmedOnly => '仅计算已确认出勤';

  @override
  String get wageDisclaimer => '工资结果仅为个人预估，不替代企业工资条或法定核算。';

  @override
  String get wageRuleSaved => '工资规则已保存';

  @override
  String get statisticsThisWeek => '本周';

  @override
  String get statisticsThisMonth => '本月';

  @override
  String get statisticsLastMonth => '上月';

  @override
  String get statisticsByWorkDate => '按班次开始日';

  @override
  String get statisticsByNaturalDay => '按自然日拆分';

  @override
  String get expectedAttendance => '应出勤';

  @override
  String get actualAttendance => '实际出勤';

  @override
  String get plannedHours => '计划工时';

  @override
  String get normalHours => '正常工时';

  @override
  String get lateCount => '迟到';

  @override
  String get earlyLeaveCount => '早退';

  @override
  String get exportCsv => '导出 CSV';

  @override
  String get csvExported => 'CSV 已保存';

  @override
  String get payrollBreakdown => '工资明细';

  @override
  String get basePay => '基本工资';

  @override
  String get normalHoursPay => '正常工时工资';

  @override
  String get overtimePay => '加班工资';

  @override
  String get workdayOvertimePay => '工作日加班工资';

  @override
  String get restDayOvertimePay => '休息日加班工资';

  @override
  String get holidayOvertimePay => '法定节假日加班工资';

  @override
  String get fixedAllowance => '固定补贴（元）';

  @override
  String get fixedDeduction => '固定扣款（元）';

  @override
  String get estimatedTotal => '预估合计';

  @override
  String get settlePayroll => '确认结算';

  @override
  String get actualPaidAmount => '实发金额（元）';

  @override
  String get estimatedDifference => '与预估差额';

  @override
  String get numericDetails => '每日数值明细';

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
  String get alarmDeleteTitle => '删除闹钟模板？';

  @override
  String alarmDeleteDescription(String name) {
    return '删除“$name”后，关联的未来排班闹钟会被取消。';
  }

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
  String get holidayNetworkUnavailable => '无法连接节假日数据源，请检查网络或 VPN 后重试；本地数据未受影响';

  @override
  String get holidayYearUnavailable => '该年份的官方节假日安排尚未发布；本地数据未受影响';

  @override
  String get holidayDataInvalid => '下载的节假日数据未通过校验，已拒绝导入；本地数据未受影响';

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
  String get backupSettingsTitle => '备份、恢复与隐私';

  @override
  String get localBackupTitle => '本地安全备份';

  @override
  String get localBackupDescription =>
      '备份使用 SQLite 一致性快照并附带版本、日期范围和 SHA-256 校验；API 密钥与敏感请求头不会写入备份。';

  @override
  String get automaticBackup => '自动本地备份';

  @override
  String get automaticBackupDescription => '每天首次启动时最多创建一份，并至少保留最近 7 份。';

  @override
  String get createBackupNow => '立即创建备份';

  @override
  String get backupCreated => '本地备份已创建并校验';

  @override
  String get recentBackups => '最近备份';

  @override
  String get noBackups => '尚无本地备份';

  @override
  String backupSchema(int version) {
    return '数据库 v$version';
  }

  @override
  String get backupCredentialsExcluded => '安全凭据已排除';

  @override
  String get backupEmptyRange => '暂无业务日期范围';

  @override
  String get restoreBackupTitle => '恢复这份备份？';

  @override
  String restoreBackupRisk(String createdAt, String dataRange) {
    return '备份时间：$createdAt\n数据范围：$dataRange\n\n恢复会覆盖当前业务数据。系统会先备份当前数据，再校验文件、迁移临时数据库并在单个事务中替换；API 密钥不会从备份恢复。';
  }

  @override
  String get restoreBackupAction => '恢复';

  @override
  String get restoreBackupSucceeded => '备份已恢复，缓存与闹钟已重建';

  @override
  String get restoreBackupAlarmWarning => '数据已恢复；闹钟重建未完全成功，请到闹钟设置重试';

  @override
  String get privacyDataTitle => '隐私与数据删除';

  @override
  String get privacyDataDescription =>
      '各类数据可独立清除。除模型安全凭据外，清除前会创建本地安全备份；每项操作都需要两次确认。';

  @override
  String get clearConversations => '清除对话';

  @override
  String get clearConversationsDescription => '删除消息和对话内容，保留独立的 AI 操作审计记录。';

  @override
  String get clearAssistantActions => '清除 AI 操作历史';

  @override
  String get clearAssistantActionsDescription => '删除提案、确认、执行与撤销记录，不修改当前业务数据。';

  @override
  String get clearAssistantConfiguration => '清除模型配置与凭据';

  @override
  String get clearAssistantConfigurationDescription =>
      '永久删除接口配置、性格设置以及 Keychain/Keystore 中的密钥，普通备份无法恢复密钥。';

  @override
  String get clearWorkforce => '清除工资与考勤';

  @override
  String get clearWorkforceDescription => '删除考勤、请假、工资规则和结算快照，保留排班。';

  @override
  String get clearAllData => '清除全部 App 数据';

  @override
  String get clearAllDataDescription => '删除全部本地业务数据、AI 数据和安全凭据；本地备份文件仍保留。';

  @override
  String get clearDataContinue => '继续';

  @override
  String get clearDataSecondConfirm => '再次确认清除';

  @override
  String get clearDataSecondConfirmBody => '这是第二次确认。执行后当前页面中的相应数据会立即删除。';

  @override
  String get clearDataConfirm => '确认清除';

  @override
  String get clearDataSucceeded => '所选数据已清除';

  @override
  String get exportDiagnostics => '导出脱敏诊断包';

  @override
  String get diagnosticsExported => '脱敏诊断包已保存';

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
