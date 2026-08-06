# Database migrations

Every schema change increments `SchemaVersions.current`, adds an explicit
forward-only step in `AppDatabase._upgrade`, and adds a fixture that opens the
previous schema with the current application database.

- v1: `database_metadata`, the migration/audit foundation.
- v2: `user_settings`, matching the technical design baseline.
- v3: schedule facts and rebuildable cache: `shift_templates`,
  `schedule_rules`, `day_overrides`, `holiday_records`,
  `calendar_day_cache`, and `change_log`.
- v4: app-managed alarm templates, shift links, and scheduled instances.
- v5: attendance, leave, wage rules, and payroll settlement snapshots.
- v6: AI provider references, assistant persona, conversations, messages, and
  confirmed action audit records.
- v7: optional persisted model reasoning content on assistant messages.
- v8: local `assistant_memories` plus an independently configurable memory
  read/manage scope on the assistant persona.

`day_overrides` uses a partial unique index so only one non-deleted override can
exist for a date. Historical soft-deleted rows remain auditable.

Secrets are deliberately absent. Database rows may store only opaque secure
storage references once AI provider configuration is introduced.
