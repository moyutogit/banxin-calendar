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
仅保存随机 `credential_ref`，普通备份还会把该引用脱敏为不可用占位符。AI
Provider 不得直接访问仓储，所有模型工具调用必须经过 ToolGateway。

备份恢复依赖方向为 `presentation → application → domain repository → data`。
Data 层用 SQLite `VACUUM INTO` 获取一致性快照，在临时数据库执行迁移、
`integrity_check` 与外键检查，再在正式连接的单个事务中导入；缓存和平台闹钟属于
可重建派生状态，不随快照直接恢复。
