# 班薪日历

面向单休、双休、大小周和轮班用户的本地优先 Flutter Android/iOS 应用。当前
V0.1.2 已实现排班日历、官方节假日、原生闹钟、打卡与工时、工资统计、受控 AI
助理、本地备份恢复及分项隐私删除。

## 公开下载

公开仓库：[moyutogit/banxin-calendar](https://github.com/moyutogit/banxin-calendar)

独立 Android 安装包在 GitHub Releases 的 `v0.1.2` 条目提供。该公开预览包使用
开发签名，适合功能验收，不可直接作为应用商店生产签名包。iOS 工程由 macOS CI
执行无签名构建验证；可安装 IPA 仍需使用开发者自己的 Apple 签名证书生成。

## 功能与安全边界

- 节假日更新使用可信 HTTPS 多节点回退，并区分网络、年份未发布和数据校验错误。
- AI 消息即时发送、正文与思考过程持续流式输出；思考过程可折叠并随会话保存。
- 全应用操作提示使用顶部队列弹出，不再从底部遮挡输入和导航区域。
- 确定性排班优先级：手工覆盖 > 公司安排 > 官方节假日 > 排班规则 > 默认规则。
- Android 精确闹钟与重启恢复；iOS 本地通知；不读取系统时钟已有闹钟。
- 多段/跨夜出勤、缺卡、工时取整、自然日拆分视图、三种工资模式和结算快照。
- AI 只经 ToolGateway 读取授权摘要；排班/闹钟写操作必须预览、逐次确认且可撤销。
- API 密钥只进入 Keychain/Keystore；SQLite 与普通备份不含密钥或敏感请求头。
- 备份采用 SQLite 一致性快照、SHA-256、临时库迁移、完整性检查和单事务恢复。

隐私说明见 [docs/privacy.md](docs/privacy.md)，需求覆盖见
[docs/requirements-traceability.md](docs/requirements-traceability.md)。

## 固定工具链

- Flutter 3.44.8 / Dart 3.12.2
- JDK 17，Android minSdk 26
- Xcode 16.4，iOS deployment target 15.0

## 完整验收

```powershell
flutter pub get
flutter gen-l10n
dart run build_runner build
dart run tool/check_dependency_licenses.dart
dart format --output=none --set-exit-if-changed lib test integration_test tool
flutter analyze
flutter test
flutter build apk --debug
```

macOS CI 另执行：

```bash
flutter build ios --debug --no-codesign
```

Android/iOS 的通知授权、精确闹钟、重启、锁屏和专注模式仍必须在对应真机完成最终
发布验收，模拟器和 CI 不能替代该项。
