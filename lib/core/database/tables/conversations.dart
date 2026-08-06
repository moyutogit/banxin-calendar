import 'package:drift/drift.dart';

class Conversations extends Table {
  @override
  String get tableName => 'conversations';

  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get modelSnapshotJson => text()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  IntColumn get archivedAt => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}
