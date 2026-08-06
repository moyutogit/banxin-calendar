# 需求追踪表

| 需求组 | 实现入口 | 主要自动化验收 | 状态 |
|---|---|---|---|
| F-ONB | `features/onboarding`、`schedule_setup_page.dart` | 七步首启、排班必填、14 天预览 Widget/应用服务测试 | 已实现 |
| F-SCH | `features/schedule` 四层、Schema v3 | 优先级、大小周跨年、1—31 天周期、批量预览、缓存、事务回滚、24 个月稳定性 | 已实现 |
| F-HOL | `features/holiday`、`holiday_records` | 离线保留、年份/重复校验、差异统计、不覆盖手工结果 | 已实现 |
| F-HOME | `features/home` | 工作/休息、缺卡、工资未配置、闹钟状态、未来 7 天联动 | 已实现 |
| F-CAL | `features/calendar` | 月历缓存 <300ms、筛选不写数据、长按批量、深色/200% 字体 | 已实现 |
| F-ALM | `features/alarm`、Kotlin/Swift bridge、Schema v4 | 工作/休息生成、差异同步、幂等、失败重试状态、CI 双端编译 | 代码完成；真机发布验收待设备 |
| F-ATT | `features/attendance`、Schema v5 | 多段重叠、缺卡、跨夜、24h 上限、已结算提示、自然日拆分 | 已实现 |
| F-WAGE | `features/wage`、`features/statistics` | 时/日/月薪、三类加班、补贴扣款、结算快照、实发差额、CSV 同源 | 已实现 |
| F-AI | `features/assistant`、`assets/assistant`、Schema v7 | HTTPS/密钥隔离、权限最小化、即时发送、正文/思考流式与折叠持久化、DeepSeek 工具调用回放、一次性 HMAC token、过期/版本校验、排班与闹钟确认/撤销 | 已实现 |
| 数据/隐私 | `features/backup`、`docs/privacy.md` | 一致性快照、凭据排除、checksum、临时迁移、原子恢复、7 份保留、二次确认清理 | 已实现 |

## 发布前仍需外部条件

- Android/iOS 真机权限允许、拒绝、撤销、重启、锁屏和省电/专注模式矩阵。
- Android 商店正式签名和 Apple Developer 签名证书由发布方 CI Secret 提供；仓库不含证书。
- 用户选择的 AI 服务商可用性、计费与隐私条款不由本应用控制。
