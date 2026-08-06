import 'package:banxin_calendar/core/ids/stable_id_generator.dart';
import 'package:banxin_calendar/features/attendance/domain/attendance_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';
import 'package:banxin_calendar/features/wage/domain/wage_entities.dart';
import 'package:banxin_calendar/features/wage/domain/wage_repository.dart';

final class WageRuleDraft {
  const WageRuleDraft({
    required this.mode,
    required this.currency,
    required this.baseRateMinor,
    required this.workdayOvertimeBasisPoints,
    required this.restDayOvertimeBasisPoints,
    required this.holidayOvertimeBasisPoints,
    required this.periodStartDay,
    required this.roundingMode,
    required this.roundingIncrementMinutes,
    required this.confirmedOnly,
    required this.effectiveStart,
  });

  final WageMode mode;
  final String currency;
  final int baseRateMinor;
  final int workdayOvertimeBasisPoints;
  final int restDayOvertimeBasisPoints;
  final int holidayOvertimeBasisPoints;
  final int periodStartDay;
  final MinuteRoundingMode roundingMode;
  final int roundingIncrementMinutes;
  final bool confirmedOnly;
  final LocalDate effectiveStart;
}

final class WageApplicationService {
  WageApplicationService(this._repository, {StableIdGenerator? idGenerator})
    : _idGenerator = idGenerator ?? UuidV4Generator();

  final WageRepository _repository;
  final StableIdGenerator _idGenerator;

  Future<WageRule?> loadFor(LocalDate date) async {
    final rules = await _repository.loadRules(
      DateRange(start: date, end: date),
    );
    return rules.firstOrNull;
  }

  Future<void> save(WageRuleDraft draft) => _repository.saveRule(
    WageRule(
      id: _idGenerator.generate(),
      mode: draft.mode,
      currency: draft.currency.toUpperCase(),
      baseRateMinor: draft.baseRateMinor,
      overtimeRateBasisPoints: <OvertimeType, int>{
        OvertimeType.workday: draft.workdayOvertimeBasisPoints,
        OvertimeType.restDay: draft.restDayOvertimeBasisPoints,
        OvertimeType.publicHoliday: draft.holidayOvertimeBasisPoints,
      },
      periodStartDay: draft.periodStartDay,
      roundingMode: draft.roundingMode,
      roundingIncrementMinutes: draft.roundingIncrementMinutes,
      confirmedOnly: draft.confirmedOnly,
      effectiveRange: DateRange(
        start: draft.effectiveStart,
        end: LocalDate(9999, 12, 31),
      ),
    ),
  );
}
