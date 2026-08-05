import 'package:drift/drift.dart';

class DatabaseMetadata extends Table {
  @override
  String get tableName => 'database_metadata';

  TextColumn get key => text()();
  TextColumn get value => text()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{key};
}
