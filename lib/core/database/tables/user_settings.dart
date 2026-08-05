import 'package:drift/drift.dart';

class UserSettings extends Table {
  @override
  String get tableName => 'user_settings';

  TextColumn get id => text()();
  TextColumn get locale => text()();
  TextColumn get timezone => text()();
  TextColumn get currency => text()();
  IntColumn get weekStart => integer()();
  TextColumn get hourDisplayMode => text()();
  TextColumn get themeMode => text()();
  TextColumn get holidayRegion => text()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}
