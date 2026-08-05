// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

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
  String get calendarDescription => '月历、日期详情和排班覆盖将在阶段 1 接入确定性排班引擎。';

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
