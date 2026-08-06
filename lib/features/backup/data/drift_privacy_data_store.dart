import 'package:banxin_calendar/core/database/app_database.dart';
import 'package:banxin_calendar/features/backup/domain/backup_repository.dart';

final class DriftPrivacyDataStore implements PrivacyDataStore {
  const DriftPrivacyDataStore(this._database);

  final AppDatabase _database;

  @override
  Future<void> clearConversations() async {
    await _database.transaction(() async {
      final actions = await _database
          .customSelect('SELECT COUNT(*) AS count FROM ai_actions')
          .getSingle();
      final retainedActions = actions.read<int>('count');
      await _database.customStatement('DELETE FROM assistant_memories');
      await _database.customStatement('DELETE FROM messages');
      if (retainedActions == 0) {
        await _database.customStatement('DELETE FROM conversations');
        return;
      }
      await _database.customStatement('''
        INSERT OR IGNORE INTO conversations (
          id, title, model_snapshot_json, created_at, updated_at, archived_at
        ) VALUES ('privacy-retained-action-audit', '本地操作审计', '{}', 0, 0, 0)
      ''');
      await _database.customStatement('''
        UPDATE ai_actions
        SET conversation_id = 'privacy-retained-action-audit'
      ''');
      await _database.customStatement('''
        DELETE FROM conversations
        WHERE id <> 'privacy-retained-action-audit'
      ''');
    });
  }

  @override
  Future<void> clearAssistantActions() async {
    await _database.transaction(() async {
      await _database.customStatement('DELETE FROM ai_actions');
      await _database.customStatement('''
        DELETE FROM conversations
        WHERE id = 'privacy-retained-action-audit'
      ''');
    });
  }

  @override
  Future<List<String>> loadCredentialReferences() async {
    final rows = await _database.customSelect('''
      SELECT credential_ref, custom_headers_ref FROM ai_provider_configs
    ''').get();
    return <String>{
      ...rows.map((row) => row.read<String>('credential_ref')),
      ...rows
          .map((row) => row.readNullable<String>('custom_headers_ref'))
          .nonNulls,
    }.where((reference) => reference != 'backup-excluded').toList();
  }

  @override
  Future<void> clearAssistantConfiguration() async {
    await _database.transaction(() async {
      await _database.customStatement('DELETE FROM ai_provider_configs');
      await _database.customStatement('DELETE FROM assistant_personas');
    });
  }

  @override
  Future<void> clearWorkforceData() async {
    await _database.transaction(() async {
      await _database.customStatement('DELETE FROM payroll_periods');
      await _database.customStatement('DELETE FROM wage_rules');
      await _database.customStatement('DELETE FROM leave_records');
      await _database.customStatement('DELETE FROM attendance_records');
    });
  }

  @override
  Future<void> clearAllData() async {
    const tables = <String>[
      'assistant_memories',
      'messages',
      'ai_actions',
      'conversations',
      'shift_alarm_templates',
      'alarm_instances',
      'alarm_templates',
      'day_overrides',
      'calendar_day_cache',
      'schedule_rules',
      'holiday_records',
      'attendance_records',
      'leave_records',
      'payroll_periods',
      'wage_rules',
      'assistant_personas',
      'ai_provider_configs',
      'change_log',
      'shift_templates',
      'user_settings',
      'database_metadata',
    ];
    await _database.transaction(() async {
      for (final table in tables) {
        await _database.customStatement('DELETE FROM $table');
      }
    });
  }
}
