# 需求追踪表

| 需求组 | 目标阶段 | 当前实现入口 | 当前测试 | 状态 |
|---|---:|---|---|---|
| F-ONB | 1 | `features/onboarding` | 待阶段 1 | 未开始 |
| F-SCH | 1 | `features/schedule` 四层、Schema v3 | 优先级、大小周跨年、自定义周期负 offset、未来 24 个月、Repository 映射 | 进行中：引擎与只读持久化边界 |
| F-HOL | 1 | `holiday_records`、`DriftScheduleRepository` | 节假日范围读取、排班优先级 | 进行中：本地模型，尚无下载更新 |
| F-HOME | 1 | `features/home` | 基础导航 smoke test | 骨架 |
| F-CAL | 1 | `features/calendar`、`/schedule/rules` | 空状态路由、深色模式与 200% 字体 Widget 测试 | 进行中：入口，尚无月历 |
| F-ALM | 2 | `features/alarm`, `lib/platform` | 待阶段 2 真机测试 | 接口骨架 |
| F-ATT | 3 | `features/attendance` | 待阶段 3 | 未开始 |
| F-WAGE | 3 | `features/wage` | 待阶段 3 | 未开始 |
| F-AI | 4 | `features/assistant`, `assets/assistant` | 安全存储/脱敏基础测试 | 安全骨架 |

本表只标记实际完成能力；占位页面不计为功能需求完成。
