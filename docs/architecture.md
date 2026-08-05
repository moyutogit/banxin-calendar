# 工程分层约束

本工程采用功能优先、分层明确的结构：

- `presentation` 只负责 UI 和页面状态，不访问数据库、HTTP 或平台通道。
- `application` 编排用例、事务和跨模块协作，不包含 Widget。
- `domain` 保持纯 Dart，不依赖 Flutter、Drift、HTTP 或原生 SDK。
- `data` 实现领域仓储接口并封装 Drift/HTTP DTO。
- `lib/platform` 只暴露受控平台能力，不泄漏 Kotlin/Swift 对象。

依赖方向固定为：calendar → schedule；attendance → schedule；wage →
attendance + schedule；statistics → schedule + attendance + wage；alarm →
schedule；assistant → application tool gateway。禁止 schedule 反向依赖。

安全边界：API Key、Bearer Token 和敏感请求头只写入系统安全存储；SQLite
和普通备份未来仅保存随机 `credential_ref`。AI Provider 不得直接访问仓储。
