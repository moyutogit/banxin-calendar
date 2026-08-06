# 班薪日历

Flutter Android/iOS 工程，已完成开发设计文档的“阶段 0：工程骨架”，
正在推进“阶段 1：排班闭环”。当前增量包含确定性排班领域引擎、未来 24 个月
稳定性验证、Drift Schema v3 与排班规则入口；规则编辑和完整月历仍在开发中。

## 下载

[下载 v0.1.0-alpha.0 Android 开发预览包](https://github.com/moyutogit/banxin-calendar/releases/tag/v0.1.0-alpha.0)

该版本用于阶段 0 工程验证，使用开发签名，不作为生产发布包。

## 固定工具链

- Flutter 3.44.8（stable，revision `058e0af2c2`）
- Dart 3.12.2
- JDK 17
- Android minSdk 26
- iOS deployment target 15.0

`pubspec.lock` 必须提交；CI 不使用 `latest` SDK。

## 本地验收

```powershell
flutter pub get
flutter gen-l10n
dart run build_runner build
dart format --output=none --set-exit-if-changed lib test integration_test
flutter analyze
flutter test
flutter test test/unit/core/database/app_database_migration_test.dart
flutter build apk --debug
```

`flutter_riverpod` 当前锁定在 2.6.1：3.4.2 与本 SDK 固定的
`flutter_test`、Drift 2.34 的 analyzer/build_runner 组合无法共同解析，因而使用
包解析器确认的最新兼容稳定版。

iOS 只能在 macOS/Xcode 环境执行：

```bash
flutter build ios --debug --no-codesign
```

工程边界见 `docs/architecture.md`，实际需求覆盖状态见
`docs/requirements-traceability.md`。
