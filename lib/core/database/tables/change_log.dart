import 'package:drift/drift.dart';

class ChangeLog extends Table {
  @override
  String get tableName => 'change_log';

  TextColumn get id => text()();
  TextColumn get entityType => text()();
  TextColumn get entityId => text()();
  TextColumn get changeType => text()();
  TextColumn get beforeSnapshotJson => text().nullable()();
  TextColumn get afterSnapshotJson => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}
