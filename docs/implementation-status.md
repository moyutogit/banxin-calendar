# 开发阶段状态

## 阶段 0：工程骨架

- Flutter 3.44.8 / Dart 3.12.2，Android Kotlin、iOS Swift。
- Material 3 主题、中文本地化、GoRouter 五入口导航、Riverpod 注入。
- Drift/SQLite Schema v2；显式 v1→v2 前向迁移和迁移测试。
- API 凭据通过 Keychain/Keystore 插件封装，数据库只允许保存随机引用。
- 结构化日志先经过字段和内联凭据脱敏。
- Windows 本地代码生成、格式、静态检查和 10 个单元/Widget 测试通过。
- Android debug APK 已在 API 36 / JDK 17 / NDK 28.2 工具链构建通过。
- iOS deployment target 15.0 和 macOS/Xcode 16.4 CI 已配置；Windows 无法
  执行 Xcode 构建，需由 macOS CI 完成该项验收。
- 设备集成测试已创建；本机没有已连接 Android/iOS 设备，因此未执行真机 smoke。

偏差与未决项：正式产品名、Logo、节假日数据源等沿用设计文档第 24 节，
不阻塞阶段 0。
