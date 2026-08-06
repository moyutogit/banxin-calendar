import 'dart:io';

import 'package:banxin_calendar/core/database/migrations/schema_versions.dart';
import 'package:banxin_calendar/core/database/tables/ai_actions.dart';
import 'package:banxin_calendar/core/database/tables/ai_provider_configs.dart';
import 'package:banxin_calendar/core/database/tables/alarm_instances.dart';
import 'package:banxin_calendar/core/database/tables/alarm_templates.dart';
import 'package:banxin_calendar/core/database/tables/assistant_memories.dart';
import 'package:banxin_calendar/core/database/tables/assistant_personas.dart';
import 'package:banxin_calendar/core/database/tables/attendance_records.dart';
import 'package:banxin_calendar/core/database/tables/calendar_day_cache.dart';
import 'package:banxin_calendar/core/database/tables/change_log.dart';
import 'package:banxin_calendar/core/database/tables/conversations.dart';
import 'package:banxin_calendar/core/database/tables/database_metadata.dart';
import 'package:banxin_calendar/core/database/tables/day_overrides.dart';
import 'package:banxin_calendar/core/database/tables/holiday_records.dart';
import 'package:banxin_calendar/core/database/tables/leave_records.dart';
import 'package:banxin_calendar/core/database/tables/messages.dart';
import 'package:banxin_calendar/core/database/tables/payroll_periods.dart';
import 'package:banxin_calendar/core/database/tables/schedule_rules.dart';
import 'package:banxin_calendar/core/database/tables/shift_alarm_templates.dart';
import 'package:banxin_calendar/core/database/tables/shift_templates.dart';
import 'package:banxin_calendar/core/database/tables/user_settings.dart';
import 'package:banxin_calendar/core/database/tables/wage_rules.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: <Type>[
    DatabaseMetadata,
    UserSettings,
    ShiftTemplates,
    ScheduleRules,
    DayOverrides,
    HolidayRecords,
    CalendarDayCache,
    ChangeLog,
    AlarmTemplates,
    ShiftAlarmTemplates,
    AlarmInstances,
    AttendanceRecords,
    LeaveRecords,
    WageRules,
    PayrollPeriods,
    AiProviderConfigs,
    AssistantPersonas,
    AssistantMemories,
    Conversations,
    Messages,
    AiActions,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  AppDatabase.inMemory() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => SchemaVersions.current;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      await migrator.createAll();
      await _createScheduleIndexes();
      await _createAlarmIndexes();
      await _createWorkforceIndexes();
      await _createAssistantIndexes();
    },
    onUpgrade: _upgrade,
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
      await customStatement('PRAGMA journal_mode = WAL');
    },
  );

  Future<void> ensureReady() async {
    await customSelect('SELECT 1').getSingle();
  }

  Future<void> _upgrade(Migrator migrator, int from, int to) async {
    if (from < SchemaVersions.metadataFoundation ||
        from >= to ||
        to > SchemaVersions.current) {
      throw UnsupportedError('Unsupported database migration: v$from to v$to');
    }

    if (from < SchemaVersions.userSettings) {
      await migrator.createTable(userSettings);
    }

    if (from < SchemaVersions.scheduleFoundation) {
      await migrator.createTable(shiftTemplates);
      await migrator.createTable(scheduleRules);
      await migrator.createTable(dayOverrides);
      await migrator.createTable(holidayRecords);
      await migrator.createTable(calendarDayCache);
      await migrator.createTable(changeLog);
      await _createScheduleIndexes();
    }

    if (from < SchemaVersions.alarmFoundation) {
      await migrator.createTable(alarmTemplates);
      await migrator.createTable(shiftAlarmTemplates);
      await migrator.createTable(alarmInstances);
      await _createAlarmIndexes();
    }

    if (from < SchemaVersions.workforceFoundation) {
      await migrator.createTable(attendanceRecords);
      await migrator.createTable(leaveRecords);
      await migrator.createTable(wageRules);
      await migrator.createTable(payrollPeriods);
      await _createWorkforceIndexes();
    }

    if (from < SchemaVersions.assistantFoundation) {
      await migrator.createTable(aiProviderConfigs);
      await migrator.createTable(assistantPersonas);
      await migrator.createTable(assistantMemories);
      await migrator.createTable(conversations);
      await migrator.createTable(messages);
      await migrator.createTable(aiActions);
      await _createAssistantIndexes();
    } else {
      if (from < SchemaVersions.assistantReasoning) {
        await migrator.addColumn(messages, messages.reasoningContent);
      }
      if (from < SchemaVersions.assistantAgentMemory) {
        if (await _tableExists('assistant_personas')) {
          if (!await _columnExists('assistant_personas', 'memory_read')) {
            await migrator.addColumn(
              assistantPersonas,
              assistantPersonas.memoryRead,
            );
          }
        } else {
          await migrator.createTable(assistantPersonas);
        }
        if (!await _tableExists('assistant_memories')) {
          await migrator.createTable(assistantMemories);
        }
        await _createAssistantMemoryIndexes();
      }
    }
  }

  Future<void> _createScheduleIndexes() async {
    await customStatement('''
      CREATE UNIQUE INDEX IF NOT EXISTS idx_day_overrides_active_date
      ON day_overrides(work_date)
      WHERE deleted_at IS NULL
    ''');
    await customStatement('''
      CREATE INDEX IF NOT EXISTS idx_day_overrides_date_deleted
      ON day_overrides(work_date, deleted_at)
    ''');
    await customStatement('''
      CREATE INDEX IF NOT EXISTS idx_holiday_records_region_date
      ON holiday_records(region, work_date)
    ''');
    await customStatement('''
      CREATE INDEX IF NOT EXISTS idx_schedule_rules_effective
      ON schedule_rules(effective_start, effective_end, enabled)
    ''');
  }

  Future<void> _createAlarmIndexes() async {
    await customStatement('''
      CREATE UNIQUE INDEX IF NOT EXISTS idx_shift_alarm_templates_active
      ON shift_alarm_templates(shift_template_id, alarm_template_id)
      WHERE deleted_at IS NULL
    ''');
    await customStatement('''
      CREATE INDEX IF NOT EXISTS idx_alarm_instances_trigger_status
      ON alarm_instances(trigger_at, status)
    ''');
    await customStatement('''
      CREATE INDEX IF NOT EXISTS idx_alarm_instances_schedule_date
      ON alarm_instances(schedule_date)
    ''');
  }

  Future<void> _createWorkforceIndexes() async {
    await customStatement('''
      CREATE INDEX IF NOT EXISTS idx_attendance_work_date_deleted
      ON attendance_records(work_date, deleted_at)
    ''');
    await customStatement('''
      CREATE INDEX IF NOT EXISTS idx_leave_work_date_deleted
      ON leave_records(work_date, deleted_at)
    ''');
    await customStatement('''
      CREATE INDEX IF NOT EXISTS idx_wage_rules_effective
      ON wage_rules(effective_start, effective_end)
    ''');
  }

  Future<void> _createAssistantIndexes() async {
    await customStatement('''
      CREATE INDEX IF NOT EXISTS idx_messages_conversation_created
      ON messages(conversation_id, created_at)
    ''');
    await customStatement('''
      CREATE INDEX IF NOT EXISTS idx_ai_actions_status_created
      ON ai_actions(status, created_at)
    ''');
    await _createAssistantMemoryIndexes();
  }

  Future<void> _createAssistantMemoryIndexes() async {
    await customStatement('''
      CREATE INDEX IF NOT EXISTS idx_assistant_memories_active_updated
      ON assistant_memories(deleted_at, updated_at)
    ''');
  }

  Future<bool> _tableExists(String name) async {
    final row = await customSelect(
      'SELECT 1 FROM sqlite_master WHERE type = ? AND name = ? LIMIT 1',
      variables: <Variable<Object>>[
        const Variable<String>('table'),
        Variable<String>(name),
      ],
    ).getSingleOrNull();
    return row != null;
  }

  Future<bool> _columnExists(String table, String column) async {
    final rows = await customSelect('PRAGMA table_info($table)').get();
    return rows.any((row) => row.read<String>('name') == column);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final databaseFile = File(
      path.join(documentsDirectory.path, 'banxin_calendar.sqlite'),
    );
    return NativeDatabase.createInBackground(databaseFile);
  });
}
