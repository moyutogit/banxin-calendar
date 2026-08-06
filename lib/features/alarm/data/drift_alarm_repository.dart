import 'package:banxin_calendar/core/database/app_database.dart' as database;
import 'package:banxin_calendar/core/ids/stable_id_generator.dart';
import 'package:banxin_calendar/core/time/app_clock.dart';
import 'package:banxin_calendar/features/alarm/domain/alarm_entities.dart';
import 'package:banxin_calendar/features/alarm/domain/alarm_repository.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';
import 'package:drift/drift.dart';

final class DriftAlarmRepository implements AlarmRepository {
  DriftAlarmRepository(
    this._database, {
    this._clock = const SystemAppClock(),
    StableIdGenerator? idGenerator,
  }) : _idGenerator = idGenerator ?? UuidV4Generator();

  final database.AppDatabase _database;
  final AppClock _clock;
  final StableIdGenerator _idGenerator;

  int get _now => _clock.nowUtc().millisecondsSinceEpoch;

  @override
  Future<List<AlarmTemplate>> loadTemplates({bool enabledOnly = false}) async {
    final query = _database.select(_database.alarmTemplates)
      ..where(
        (table) =>
            table.deletedAt.isNull() &
            (enabledOnly ? table.enabled.equals(1) : const Constant(true)),
      )
      ..orderBy(<OrderingTerm Function(database.$AlarmTemplatesTable)>[
        (table) => OrderingTerm.asc(table.name),
      ]);
    final rows = await query.get();
    final links = await (_database.select(
      _database.shiftAlarmTemplates,
    )..where((table) => table.deletedAt.isNull())).get();
    return List<AlarmTemplate>.unmodifiable(
      rows.map(
        (row) => AlarmTemplate(
          id: row.id,
          name: row.name,
          mode: _decodeMode(row.mode),
          fixedMinute: row.fixedMinute,
          offsetMinutes: row.offsetMinutes,
          soundId: row.soundId,
          vibrate: row.vibrate == 1,
          volumeRamp: row.volumeRamp == 1,
          snoozeMinutes: row.snoozeMinutes,
          maxSnoozeCount: row.maxSnoozeCount,
          enabled: row.enabled == 1,
          shiftIds: links
              .where((link) => link.alarmTemplateId == row.id)
              .map((link) => ShiftId(link.shiftTemplateId))
              .toSet(),
        ),
      ),
    );
  }

  @override
  Future<void> saveTemplate(AlarmTemplate template) async {
    final now = _now;
    await _database.transaction(() async {
      final query = _database.select(_database.alarmTemplates)
        ..where((table) => table.id.equals(template.id));
      final existing = await query.getSingleOrNull();
      await _database
          .into(_database.alarmTemplates)
          .insertOnConflictUpdate(
            database.AlarmTemplatesCompanion.insert(
              id: template.id,
              name: template.name,
              mode: _encodeMode(template.mode),
              fixedMinute: Value<int?>(template.fixedMinute),
              offsetMinutes: Value<int?>(template.offsetMinutes),
              soundId: Value<String?>(template.soundId),
              vibrate: template.vibrate ? 1 : 0,
              volumeRamp: Value<int>(template.volumeRamp ? 1 : 0),
              snoozeMinutes: template.snoozeMinutes,
              maxSnoozeCount: template.maxSnoozeCount,
              enabled: template.enabled ? 1 : 0,
              createdAt: existing?.createdAt ?? now,
              updatedAt: now,
              deletedAt: const Value<int?>(null),
            ),
          );
      await (_database.update(_database.shiftAlarmTemplates)..where(
            (table) =>
                table.alarmTemplateId.equals(template.id) &
                table.deletedAt.isNull(),
          ))
          .write(
            database.ShiftAlarmTemplatesCompanion(
              deletedAt: Value<int?>(now),
              updatedAt: Value<int>(now),
            ),
          );
      for (final shiftId in template.shiftIds) {
        await _database
            .into(_database.shiftAlarmTemplates)
            .insert(
              database.ShiftAlarmTemplatesCompanion.insert(
                id: _idGenerator.generate(),
                shiftTemplateId: shiftId.value,
                alarmTemplateId: template.id,
                createdAt: now,
                updatedAt: now,
              ),
            );
      }
    });
  }

  @override
  Future<void> setTemplateEnabled(String id, {required bool enabled}) async {
    final changed =
        await (_database.update(
              _database.alarmTemplates,
            )..where((table) => table.id.equals(id) & table.deletedAt.isNull()))
            .write(
              database.AlarmTemplatesCompanion(
                enabled: Value<int>(enabled ? 1 : 0),
                updatedAt: Value<int>(_now),
              ),
            );
    if (changed != 1) {
      throw StateError('Alarm template $id does not exist.');
    }
  }

  @override
  Future<List<AlarmInstance>> loadInstances(DateRange range) async {
    final rows =
        await (_database.select(_database.alarmInstances)..where(
              (table) =>
                  table.scheduleDate.isBiggerOrEqualValue(
                    range.start.toString(),
                  ) &
                  table.scheduleDate.isSmallerOrEqualValue(
                    range.end.toString(),
                  ) &
                  table.status.isNotValue(
                    _encodeStatus(AlarmInstanceStatus.canceled),
                  ),
            ))
            .get();
    return List<AlarmInstance>.unmodifiable(rows.map(_mapInstance));
  }

  @override
  Future<List<AlarmInstance>> loadUpcomingInstances(DateTime nowUtc) async {
    final rows =
        await (_database.select(_database.alarmInstances)..where(
              (table) =>
                  table.triggerAt.isBiggerOrEqualValue(
                    nowUtc.millisecondsSinceEpoch,
                  ) &
                  table.status.isNotValue(
                    _encodeStatus(AlarmInstanceStatus.canceled),
                  ),
            ))
            .get();
    return List<AlarmInstance>.unmodifiable(rows.map(_mapInstance));
  }

  @override
  Future<void> saveSyncChanges({
    required List<AlarmInstance> upserted,
    required Set<String> canceledPlatformIds,
  }) async {
    final now = _now;
    await _database.transaction(() async {
      if (canceledPlatformIds.isNotEmpty) {
        await (_database.update(_database.alarmInstances)..where(
              (table) => table.platformAlarmId.isIn(canceledPlatformIds),
            ))
            .write(
              database.AlarmInstancesCompanion(
                status: Value<String>(
                  _encodeStatus(AlarmInstanceStatus.canceled),
                ),
                updatedAt: Value<int>(now),
              ),
            );
      }
      for (final instance in upserted) {
        final existing = await (_database.select(
          _database.alarmInstances,
        )..where((table) => table.id.equals(instance.id))).getSingleOrNull();
        await _database
            .into(_database.alarmInstances)
            .insertOnConflictUpdate(
              database.AlarmInstancesCompanion.insert(
                id: instance.id,
                templateId: instance.templateId,
                scheduleDate: instance.scheduleDate.toString(),
                triggerAt: instance.triggerAtUtc.millisecondsSinceEpoch,
                shiftId: Value<String?>(instance.shiftId?.value),
                locked: instance.locked ? 1 : 0,
                platformAlarmId: instance.platformAlarmId,
                status: _encodeStatus(instance.status),
                payloadHash: instance.payloadHash,
                errorCode: Value<String?>(instance.errorCode),
                retryCount: Value<int>(instance.retryCount),
                nextRetryAt: Value<int?>(
                  instance.nextRetryAtUtc?.millisecondsSinceEpoch,
                ),
                lastSyncedAt: Value<int?>(
                  instance.lastSyncedAtUtc?.millisecondsSinceEpoch,
                ),
                createdAt: existing?.createdAt ?? now,
                updatedAt: now,
              ),
            );
      }
    });
  }

  AlarmInstance _mapInstance(database.AlarmInstance row) => AlarmInstance(
    id: row.id,
    templateId: row.templateId,
    scheduleDate: LocalDate.parse(row.scheduleDate),
    triggerAtUtc: DateTime.fromMillisecondsSinceEpoch(
      row.triggerAt,
      isUtc: true,
    ),
    shiftId: row.shiftId == null ? null : ShiftId(row.shiftId!),
    locked: row.locked == 1,
    platformAlarmId: row.platformAlarmId,
    status: _decodeStatus(row.status),
    payloadHash: row.payloadHash,
    errorCode: row.errorCode,
    retryCount: row.retryCount,
    nextRetryAtUtc: row.nextRetryAt == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(row.nextRetryAt!, isUtc: true),
    lastSyncedAtUtc: row.lastSyncedAt == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(row.lastSyncedAt!, isUtc: true),
  );

  String _encodeMode(AlarmTemplateMode mode) => switch (mode) {
    AlarmTemplateMode.fixedTime => 'fixed',
    AlarmTemplateMode.relativeToShiftStart => 'relative_shift_start',
  };

  AlarmTemplateMode _decodeMode(String value) => switch (value) {
    'fixed' => AlarmTemplateMode.fixedTime,
    'relative_shift_start' => AlarmTemplateMode.relativeToShiftStart,
    _ => throw FormatException('Unsupported alarm template mode: $value'),
  };

  String _encodeStatus(AlarmInstanceStatus status) => status.name;

  AlarmInstanceStatus _decodeStatus(String value) =>
      AlarmInstanceStatus.values.firstWhere(
        (status) => status.name == value,
        orElse: () => throw FormatException('Unsupported alarm status: $value'),
      );
}
