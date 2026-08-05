# Database migrations

Every schema change increments `SchemaVersions.current`, adds an explicit
forward-only step in `AppDatabase._upgrade`, and adds a fixture that opens the
previous schema with the current application database.

- v1: `database_metadata`, the migration/audit foundation.
- v2: `user_settings`, matching the technical design baseline.

Secrets are deliberately absent. Database rows may store only opaque secure
storage references once AI provider configuration is introduced.
