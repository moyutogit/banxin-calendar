import 'package:drift/drift.dart';

class PayrollPeriods extends Table {
  @override
  String get tableName => 'payroll_periods';

  TextColumn get id => text()();
  TextColumn get startDate => text()();
  TextColumn get endDate => text()();
  TextColumn get status => text()();
  IntColumn get calculatedMinor => integer()();
  IntColumn get confirmedMinor => integer().nullable()();
  TextColumn get calculationSnapshotJson => text()();
  IntColumn get confirmedAt => integer().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => <Set<Column<Object>>>[
    <Column<Object>>{startDate, endDate},
  ];
}
