import 'dart:convert';

import 'package:banxin_calendar/core/database/app_database.dart' as database;
import 'package:banxin_calendar/core/time/app_clock.dart';
import 'package:banxin_calendar/features/attendance/domain/attendance_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';
import 'package:banxin_calendar/features/wage/domain/wage_entities.dart';
import 'package:banxin_calendar/features/wage/domain/wage_repository.dart';
import 'package:drift/drift.dart';

final class DriftWageRepository implements WageRepository {
  const DriftWageRepository(
    this._database, {
    this._clock = const SystemAppClock(),
  });

  final database.AppDatabase _database;
  final AppClock _clock;

  int get _now => _clock.nowUtc().millisecondsSinceEpoch;

  @override
  Future<List<WageRule>> loadRules(DateRange range) async {
    final rows =
        await (_database.select(_database.wageRules)
              ..where(
                (table) =>
                    table.effectiveStart.isSmallerOrEqualValue(
                      range.end.toString(),
                    ) &
                    (table.effectiveEnd.isNull() |
                        table.effectiveEnd.isBiggerOrEqualValue(
                          range.start.toString(),
                        )),
              )
              ..orderBy(<OrderingTerm Function(database.$WageRulesTable)>[
                (table) => OrderingTerm.desc(table.effectiveStart),
              ]))
            .get();
    return List<WageRule>.unmodifiable(rows.map(_mapRule));
  }

  @override
  Future<void> saveRule(WageRule rule) async {
    final now = _now;
    final existing = await (_database.select(
      _database.wageRules,
    )..where((table) => table.id.equals(rule.id))).getSingleOrNull();
    await _database
        .into(_database.wageRules)
        .insertOnConflictUpdate(
          database.WageRulesCompanion.insert(
            id: rule.id,
            mode: rule.mode.name,
            currency: rule.currency,
            baseRateMinor: rule.baseRateMinor,
            overtimeRatesJson: jsonEncode(<String, int>{
              for (final entry in rule.overtimeRateBasisPoints.entries)
                entry.key.name: entry.value,
            }),
            allowanceRulesJson: _encodeMoneyLines(rule.allowances),
            deductionRulesJson: _encodeMoneyLines(rule.deductions),
            periodStartDay: rule.periodStartDay,
            roundingRuleJson: jsonEncode(<String, Object>{
              'mode': rule.roundingMode.name,
              'incrementMinutes': rule.roundingIncrementMinutes,
              'normalMonthlyMinutes': rule.normalMonthlyMinutes,
            }),
            confirmedOnly: Value<int>(rule.confirmedOnly ? 1 : 0),
            effectiveStart: rule.effectiveRange.start.toString(),
            effectiveEnd: Value<String?>(
              rule.effectiveRange.end == LocalDate(9999, 12, 31)
                  ? null
                  : rule.effectiveRange.end.toString(),
            ),
            createdAt: existing?.createdAt ?? now,
            updatedAt: now,
          ),
        );
  }

  @override
  Future<PayrollPeriod?> loadPayrollPeriod(DateRange range) async {
    final row =
        await (_database.select(_database.payrollPeriods)..where(
              (table) =>
                  table.startDate.equals(range.start.toString()) &
                  table.endDate.equals(range.end.toString()),
            ))
            .getSingleOrNull();
    if (row == null) return null;
    return PayrollPeriod(
      id: row.id,
      range: range,
      status: PayrollPeriodStatus.values.byName(row.status),
      calculatedMinor: row.calculatedMinor,
      confirmedMinor: row.confirmedMinor,
      snapshotJson: row.calculationSnapshotJson,
      confirmedAtUtc: row.confirmedAt == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(row.confirmedAt!, isUtc: true),
    );
  }

  @override
  Future<void> savePayrollPeriod(PayrollPeriod period) async {
    final now = _now;
    final existing = await (_database.select(
      _database.payrollPeriods,
    )..where((table) => table.id.equals(period.id))).getSingleOrNull();
    if (existing?.status == PayrollPeriodStatus.settled.name &&
        period.status != PayrollPeriodStatus.settled) {
      throw StateError('A settled payroll period cannot be reopened silently.');
    }
    await _database
        .into(_database.payrollPeriods)
        .insertOnConflictUpdate(
          database.PayrollPeriodsCompanion.insert(
            id: period.id,
            startDate: period.range.start.toString(),
            endDate: period.range.end.toString(),
            status: period.status.name,
            calculatedMinor: period.calculatedMinor,
            confirmedMinor: Value<int?>(period.confirmedMinor),
            calculationSnapshotJson: period.snapshotJson,
            confirmedAt: Value<int?>(
              period.confirmedAtUtc?.millisecondsSinceEpoch,
            ),
            createdAt: existing?.createdAt ?? now,
            updatedAt: now,
          ),
        );
  }

  WageRule _mapRule(database.WageRule row) {
    final overtimeJson =
        jsonDecode(row.overtimeRatesJson) as Map<String, Object?>;
    final roundingJson =
        jsonDecode(row.roundingRuleJson) as Map<String, Object?>;
    return WageRule(
      id: row.id,
      mode: WageMode.values.byName(row.mode),
      currency: row.currency,
      baseRateMinor: row.baseRateMinor,
      overtimeRateBasisPoints: <OvertimeType, int>{
        for (final entry in overtimeJson.entries)
          OvertimeType.values.byName(entry.key): entry.value as int,
      },
      periodStartDay: row.periodStartDay,
      roundingMode: MinuteRoundingMode.values.byName(
        roundingJson['mode']! as String,
      ),
      roundingIncrementMinutes: roundingJson['incrementMinutes']! as int,
      confirmedOnly: row.confirmedOnly == 1,
      effectiveRange: DateRange(
        start: LocalDate.parse(row.effectiveStart),
        end: row.effectiveEnd == null
            ? LocalDate(9999, 12, 31)
            : LocalDate.parse(row.effectiveEnd!),
      ),
      normalMonthlyMinutes:
          roundingJson['normalMonthlyMinutes'] as int? ?? 10440,
      allowances: _decodeMoneyLines(row.allowanceRulesJson),
      deductions: _decodeMoneyLines(row.deductionRulesJson),
    );
  }

  String _encodeMoneyLines(List<MoneyLine> lines) => jsonEncode(<Object?>[
    for (final line in lines)
      <String, Object>{'label': line.label, 'amount_minor': line.amountMinor},
  ]);

  List<MoneyLine> _decodeMoneyLines(String source) {
    final decoded = jsonDecode(source);
    if (decoded is! List<Object?>) throw const FormatException();
    return List<MoneyLine>.unmodifiable(
      decoded.map((raw) {
        if (raw is! Map<String, Object?> ||
            raw['label'] is! String ||
            raw['amount_minor'] is! int) {
          throw const FormatException();
        }
        return MoneyLine(
          label: raw['label']! as String,
          amountMinor: raw['amount_minor']! as int,
        );
      }),
    );
  }
}
