import 'dart:io';

import 'package:banxin_calendar/core/database/migrations/schema_versions.dart';
import 'package:banxin_calendar/core/database/tables/alarm_instances.dart';
import 'package:banxin_calendar/core/database/tables/alarm_templates.dart';
import 'package:banxin_calendar/core/database/tables/calendar_day_cache.dart';
import 'package:banxin_calendar/core/database/tables/change_log.dart';
import 'package:banxin_calendar/core/database/tables/database_metadata.dart';
import 'package:banxin_calendar/core/database/tables/day_overrides.dart';
import 'package:banxin_calendar/core/database/tables/holiday_records.dart';
import 'package:banxin_calendar/core/database/tables/schedule_rules.dart';
import 'package:banxin_calendar/core/database/tables/shift_alarm_templates.dart';
import 'package:banxin_calendar/core/database/tables/shift_templates.dart';
import 'package:banxin_calendar/core/database/tables/user_settings.dart';
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
