# 开发阶段状态

## 阶段 1：排班闭环（进行中）

- 已建立 `schedule/domain`、`application`、`data`、`presentation` 四层实现；
  Presentation 不直接访问 Drift，Data 通过 Domain Repository 返回领域对象。
- 已实现 `LocalDate`、`DateRange`、强类型班次/规则 ID、班次快照、周规则、
  1～31 天自定义周期、大小周规则和确定性解析器。
- 已固定 `用户覆盖 > 公司安排 > 官方节假日 > 排班规则 > 默认规则` 优先级，
  并覆盖跨年、闰日、负 offset、规则优先级及未来 24 个月稳定性测试。
- Drift/SQLite 已升级到 Schema v3，增加班次、规则、覆盖、节假日、可重建
  日历缓存和变更日志；包含 v1/v2 前向迁移、外键和软删除唯一约束测试。
- 排班 Data Repository 已实现启用/软删除过滤、日期范围查询和班次快照读取；
  损坏的持久化规则载荷会明确失败，不静默降级。
- 日历已提供真实空状态并接入 `/schedule/rules` 路由，支持模式说明已国际化。

未完成：规则/班次编辑事务、缓存失效与重建、节假日下载、完整月历与日期详情、
单日/批量覆盖及变更撤销。上述能力完成前不把 F-SCH/F-HOL/F-CAL 标记为完成。

## 阶段 0：工程骨架

- Flutter 3.44.8 / Dart 3.12.2，Android Kotlin、iOS Swift。
- Material 3 主题、中文本地化、GoRouter 五入口导航、Riverpod 注入。
- Drift/SQLite 阶段 0 基线为 Schema v2；现已由阶段 1 增量前向迁移到 v3。
- API 凭据通过 Keychain/Keystore 插件封装，数据库只允许保存随机引用。
- 结构化日志先经过字段和内联凭据脱敏。
- Windows 本地代码生成、格式、静态检查和 10 个单元/Widget 测试通过。
- Android debug APK 已在 API 36 / JDK 17 / NDK 28.2 工具链构建通过。
- iOS deployment target 15.0 和 macOS/Xcode 16.4 CI 已配置；Windows 无法
  执行 Xcode 构建，需由 macOS CI 完成该项验收。
- 设备集成测试已创建；本机没有已连接 Android/iOS 设备，因此未执行真机 smoke。

偏差与未决项：正式产品名、Logo、节假日数据源等沿用设计文档第 24 节，
不阻塞阶段 0。
