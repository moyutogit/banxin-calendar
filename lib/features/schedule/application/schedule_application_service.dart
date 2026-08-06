import 'package:banxin_calendar/core/ids/stable_id_generator.dart';
import 'package:banxin_calendar/features/schedule/application/resolve_calendar_range.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_repository.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_resolver.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_rules.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';

enum SchedulePresetMode { fiveDay, sixDay, alternatingWeek, customCycle }

final class ScheduleSetupDraft {
  ScheduleSetupDraft({
    required this.mode,
    required this.ruleName,
    required this.shiftName,
    required this.shiftShortName,
    required this.startMinute,
    required this.endMinute,
    required this.crossDay,
    required this.unpaidBreakMinutes,
    required this.anchorDate,
    List<bool> customCycleWorkPattern = const <bool>[true, false],
    this.shiftId,
    this.ruleId,
  }) : customCycleWorkPattern = List<bool>.unmodifiable(
         customCycleWorkPattern,
       ) {
    if (customCycleWorkPattern.isEmpty || customCycleWorkPattern.length > 31) {
      throw ArgumentError('A custom schedule cycle must contain 1-31 days.');
    }
  }

  final SchedulePresetMode mode;
  final String ruleName;
  final String shiftName;
  final String shiftShortName;
  final int startMinute;
  final int endMinute;
  final bool crossDay;
  final int unpaidBreakMinutes;
  final LocalDate anchorDate;
  final List<bool> customCycleWorkPattern;
  final ShiftId? shiftId;
  final RuleId? ruleId;
}

final class ScheduleSetupPreview {
  const ScheduleSetupPreview({
    required this.shift,
    required this.rule,
    required this.days,
  });

  final ShiftSnapshot shift;
  final ScheduleRule rule;
  final List<ResolvedCalendarDay> days;
}

final class ShiftTemplateDraft {
  const ShiftTemplateDraft({
    required this.name,
    required this.shortName,
    required this.startMinute,
    required this.endMinute,
    required this.crossDay,
    required this.unpaidBreakMinutes,
    this.id,
    this.colorArgb = 0xFF3B82F6,
  });

  final ShiftId? id;
  final String name;
  final String shortName;
  final int startMinute;
  final int endMinute;
  final bool crossDay;
  final int unpaidBreakMinutes;
  final int colorArgb;
}

final class ScheduleCalendarView {
  const ScheduleCalendarView({
    required this.configured,
    required this.days,
    required this.shifts,
  });

  final bool configured;
  final List<ResolvedCalendarDay> days;
  final List<ShiftSnapshot> shifts;
}

final class ScheduleOverridePreview {
  const ScheduleOverridePreview({
    required this.dates,
    required this.originalStatusCounts,
    required this.newStatus,
    required this.shift,
  });

  final List<LocalDate> dates;
  final Map<DayStatus, int> originalStatusCounts;
  final DayStatus newStatus;
  final ShiftSnapshot? shift;
}

final class ScheduleRulesView {
  const ScheduleRulesView({required this.rules, required this.shifts});

  final List<StoredScheduleRule> rules;
  final List<StoredShiftTemplate> shifts;
}

final class ScheduleApplicationService {
  ScheduleApplicationService(
    this._repository,
    this._resolveCalendarRange, {
    StableIdGenerator? idGenerator,
  }) : _idGenerator = idGenerator ?? UuidV4Generator();

  final ScheduleRepository _repository;
  final ResolveCalendarRange _resolveCalendarRange;
  final StableIdGenerator _idGenerator;

  Future<ScheduleSetupPreview> previewSetup(
    ScheduleSetupDraft draft, {
    required LocalDate previewStart,
  }) async {
    final setup = _buildSetup(draft);
    final range = DateRange(start: previewStart, end: previewStart.addDays(13));
    final resolver = ScheduleResolver();
    final days = resolver.resolveRange(
      range,
      ScheduleResolverInput(
        defaultWeek: _fiveDayWeek(setup.shift),
        rules: <ScheduleRule>[setup.rule],
      ),
    );
    return ScheduleSetupPreview(
      shift: setup.shift,
      rule: setup.rule,
      days: days,
    );
  }

  Future<void> saveSetup(ScheduleSetupDraft draft) async {
    final setup = _buildSetup(draft);
    await _repository.saveScheduleSetup(shift: setup.shift, rule: setup.rule);
  }

  Future<ScheduleCalendarView> loadCalendar(DateRange range) async {
    await ensureSystemShifts();
    final shifts = await _repository.loadEnabledShifts();
    final storedRules = await _repository.loadStoredRules();
    if (shifts.isEmpty || !storedRules.any((rule) => rule.enabled)) {
      return const ScheduleCalendarView(
        configured: false,
        days: <ResolvedCalendarDay>[],
        shifts: <ShiftSnapshot>[],
      );
    }
    final days = await _resolveCalendarRange(
      range: range,
      defaultWeek: _fiveDayWeek(shifts.first),
    );
    return ScheduleCalendarView(configured: true, days: days, shifts: shifts);
  }

  Future<ScheduleRulesView> loadRulesView() async {
    await ensureSystemShifts();
    final rulesFuture = _repository.loadStoredRules();
    final shiftsFuture = _repository.loadStoredShifts();
    return ScheduleRulesView(
      rules: await rulesFuture,
      shifts: await shiftsFuture,
    );
  }

  Future<void> ensureSystemShifts() async {
    final stored = await _repository.loadStoredShifts();
    final existingIds = stored.map((item) => item.shift.id.value).toSet();
    for (final shift in _systemShifts) {
      if (!existingIds.contains(shift.id.value)) {
        await _repository.saveShift(shift);
      }
    }
  }

  Future<void> saveShift(ShiftSnapshot shift) => _repository.saveShift(shift);

  Future<ShiftSnapshot> saveShiftDraft(ShiftTemplateDraft draft) async {
    final duration = draft.crossDay
        ? (24 * 60 - draft.startMinute) + draft.endMinute
        : draft.endMinute - draft.startMinute;
    final planned = duration - draft.unpaidBreakMinutes;
    if (duration <= 0 || planned < 0) {
      throw ArgumentError('Shift duration and break settings are invalid.');
    }
    final shift = ShiftSnapshot(
      id: draft.id ?? ShiftId(_idGenerator.generate()),
      name: draft.name,
      shortName: draft.shortName,
      startMinute: draft.startMinute,
      endMinute: draft.endMinute,
      crossDay: draft.crossDay,
      unpaidBreakMinutes: draft.unpaidBreakMinutes,
      plannedPaidMinutes: planned,
      colorArgb: draft.colorArgb,
      isWorkday: true,
    );
    await _repository.saveShift(shift);
    return shift;
  }

  ShiftTemplateDraft draftForShift(ShiftSnapshot shift) {
    return ShiftTemplateDraft(
      id: shift.id,
      name: shift.name,
      shortName: shift.shortName,
      startMinute: shift.startMinute,
      endMinute: shift.endMinute,
      crossDay: shift.crossDay,
      unpaidBreakMinutes: shift.unpaidBreakMinutes,
      colorArgb: shift.colorArgb,
    );
  }

  Future<void> setShiftEnabled(ShiftId id, {required bool enabled}) {
    return _repository.setShiftEnabled(id, enabled: enabled);
  }

  Future<void> setRuleEnabled(RuleId id, {required bool enabled}) {
    return _repository.setRuleEnabled(id, enabled: enabled);
  }

  ScheduleSetupDraft draftForRule(ScheduleRule rule) {
    final shift = _firstShift(rule);
    if (shift == null) {
      throw StateError('A schedule rule must reference a work shift.');
    }
    final mode = switch (rule) {
      AlternatingWeekScheduleRule() => SchedulePresetMode.alternatingWeek,
      CycleScheduleRule() => SchedulePresetMode.customCycle,
      WeeklyScheduleRule() =>
        _isSixDayWeek(rule.week)
            ? SchedulePresetMode.sixDay
            : SchedulePresetMode.fiveDay,
      _ => throw ArgumentError.value(rule, 'rule'),
    };
    return ScheduleSetupDraft(
      mode: mode,
      ruleName: rule.name,
      shiftName: shift.name,
      shiftShortName: shift.shortName,
      startMinute: shift.startMinute,
      endMinute: shift.endMinute,
      crossDay: shift.crossDay,
      unpaidBreakMinutes: shift.unpaidBreakMinutes,
      anchorDate: switch (rule) {
        CycleScheduleRule() => rule.anchorDate,
        AlternatingWeekScheduleRule() => rule.anchorWeekStart,
        _ => rule.effectiveRange.start,
      },
      customCycleWorkPattern: rule is CycleScheduleRule
          ? rule.cycle.map((day) => day.shift != null).toList(growable: false)
          : const <bool>[true, false],
      shiftId: shift.id,
      ruleId: rule.id,
    );
  }

  Future<ScheduleRule> duplicateRule(ScheduleRule source) async {
    final copy = _copyRule(
      source,
      id: RuleId(_idGenerator.generate()),
      name: '${source.name} 副本',
    );
    await _repository.saveRule(copy, enabled: true);
    return copy;
  }

  Future<ScheduleOverridePreview> previewOverride({
    required List<LocalDate> dates,
    required DayStatus status,
    ShiftSnapshot? shift,
  }) async {
    if (dates.isEmpty) {
      throw ArgumentError('At least one override date is required.');
    }
    final orderedDates = dates.toSet().toList()..sort();
    final calendar = await loadCalendar(
      DateRange(start: orderedDates.first, end: orderedDates.last),
    );
    final selected = orderedDates.toSet();
    final counts = <DayStatus, int>{};
    for (final day in calendar.days.where(
      (day) => selected.contains(day.date),
    )) {
      counts.update(day.status, (value) => value + 1, ifAbsent: () => 1);
    }
    return ScheduleOverridePreview(
      dates: List<LocalDate>.unmodifiable(orderedDates),
      originalStatusCounts: Map<DayStatus, int>.unmodifiable(counts),
      newStatus: status,
      shift: shift,
    );
  }

  Future<void> applyOverride(ScheduleOverridePreview preview) {
    return _repository.saveOverrides(
      preview.dates
          .map(
            (date) => CalendarOverride(
              id: _idGenerator.generate(),
              date: date,
              status: preview.newStatus,
              shift: preview.shift,
            ),
          )
          .toList(growable: false),
      source: DaySource.userOverride,
    );
  }

  Future<void> restoreRuleResult(DateRange range) {
    return _repository.restoreOverrides(range, source: DaySource.userOverride);
  }

  ({ShiftSnapshot shift, ScheduleRule rule}) _buildSetup(
    ScheduleSetupDraft draft,
  ) {
    final shift = ShiftSnapshot(
      id: draft.shiftId ?? ShiftId(_idGenerator.generate()),
      name: draft.shiftName,
      shortName: draft.shiftShortName,
      startMinute: draft.startMinute,
      endMinute: draft.endMinute,
      crossDay: draft.crossDay,
      unpaidBreakMinutes: draft.unpaidBreakMinutes,
      plannedPaidMinutes: _plannedMinutes(draft),
      colorArgb: 0xFF3B82F6,
      isWorkday: true,
    );
    final effectiveRange = DateRange(
      start: draft.anchorDate,
      end: LocalDate(9999, 12, 31),
    );
    final ruleId = draft.ruleId ?? RuleId(_idGenerator.generate());
    final rule = switch (draft.mode) {
      SchedulePresetMode.fiveDay => WeeklyScheduleRule(
        id: ruleId,
        name: draft.ruleName,
        effectiveRange: effectiveRange,
        priority: 10,
        week: _fiveDayWeek(shift),
      ),
      SchedulePresetMode.sixDay => WeeklyScheduleRule(
        id: ruleId,
        name: draft.ruleName,
        effectiveRange: effectiveRange,
        priority: 10,
        week: _sixDayWeek(shift),
      ),
      SchedulePresetMode.alternatingWeek => AlternatingWeekScheduleRule(
        id: ruleId,
        name: draft.ruleName,
        effectiveRange: effectiveRange,
        priority: 10,
        anchorWeekStart: _mondayOf(draft.anchorDate),
        anchorWeek: _sixDayWeek(shift),
        alternateWeek: _fiveDayWeek(shift),
      ),
      SchedulePresetMode.customCycle => CycleScheduleRule(
        id: ruleId,
        name: draft.ruleName,
        effectiveRange: effectiveRange,
        priority: 10,
        anchorDate: draft.anchorDate,
        cycle: draft.customCycleWorkPattern
            .map(
              (isWorkday) => isWorkday
                  ? ScheduleDayTemplate(status: DayStatus.work, shift: shift)
                  : ScheduleDayTemplate(status: DayStatus.rest),
            )
            .toList(growable: false),
      ),
    };
    return (shift: shift, rule: rule);
  }

  int _plannedMinutes(ScheduleSetupDraft draft) {
    final duration = draft.crossDay
        ? (24 * 60 - draft.startMinute) + draft.endMinute
        : draft.endMinute - draft.startMinute;
    final planned = duration - draft.unpaidBreakMinutes;
    if (duration <= 0 || planned < 0) {
      throw ArgumentError('Shift duration and break settings are invalid.');
    }
    return planned;
  }

  WeekTemplate _fiveDayWeek(ShiftSnapshot shift) {
    return _weekTemplate(shift, workThrough: DateTime.friday);
  }

  WeekTemplate _sixDayWeek(ShiftSnapshot shift) {
    return _weekTemplate(shift, workThrough: DateTime.saturday);
  }

  WeekTemplate _weekTemplate(ShiftSnapshot shift, {required int workThrough}) {
    return WeekTemplate(<int, ScheduleDayTemplate>{
      for (var weekday = DateTime.monday; weekday <= DateTime.sunday; weekday++)
        weekday: weekday <= workThrough
            ? ScheduleDayTemplate(status: DayStatus.work, shift: shift)
            : ScheduleDayTemplate(status: DayStatus.rest),
    });
  }

  LocalDate _mondayOf(LocalDate date) {
    return date.addDays(DateTime.monday - date.weekday);
  }

  ScheduleRule _copyRule(
    ScheduleRule source, {
    required RuleId id,
    required String name,
  }) {
    if (source is WeeklyScheduleRule) {
      return WeeklyScheduleRule(
        id: id,
        name: name,
        effectiveRange: source.effectiveRange,
        priority: source.priority,
        week: source.week,
      );
    }
    if (source is CycleScheduleRule) {
      return CycleScheduleRule(
        id: id,
        name: name,
        effectiveRange: source.effectiveRange,
        priority: source.priority,
        anchorDate: source.anchorDate,
        cycle: source.cycle,
      );
    }
    if (source is AlternatingWeekScheduleRule) {
      return AlternatingWeekScheduleRule(
        id: id,
        name: name,
        effectiveRange: source.effectiveRange,
        priority: source.priority,
        anchorWeekStart: source.anchorWeekStart,
        anchorWeek: source.anchorWeek,
        alternateWeek: source.alternateWeek,
      );
    }
    throw ArgumentError.value(source, 'source');
  }

  ShiftSnapshot? _firstShift(ScheduleRule rule) {
    if (rule is WeeklyScheduleRule) {
      for (
        var weekday = DateTime.monday;
        weekday <= DateTime.sunday;
        weekday++
      ) {
        final shift = rule.week.forWeekday(weekday).shift;
        if (shift != null) {
          return shift;
        }
      }
    }
    if (rule is CycleScheduleRule) {
      for (final day in rule.cycle) {
        if (day.shift != null) {
          return day.shift;
        }
      }
    }
    if (rule is AlternatingWeekScheduleRule) {
      for (
        var weekday = DateTime.monday;
        weekday <= DateTime.sunday;
        weekday++
      ) {
        final shift = rule.anchorWeek.forWeekday(weekday).shift;
        if (shift != null) {
          return shift;
        }
      }
    }
    return null;
  }

  bool _isSixDayWeek(WeekTemplate week) {
    return week.forWeekday(DateTime.saturday).shift != null &&
        week.forWeekday(DateTime.sunday).shift == null;
  }

  List<ShiftSnapshot> get _systemShifts => <ShiftSnapshot>[
    ShiftSnapshot(
      id: ShiftId('system-early'),
      name: '早班',
      shortName: '早',
      startMinute: 7 * 60,
      endMinute: 16 * 60,
      crossDay: false,
      unpaidBreakMinutes: 60,
      plannedPaidMinutes: 8 * 60,
      colorArgb: 0xFF10B981,
      isWorkday: true,
    ),
    ShiftSnapshot(
      id: ShiftId('system-day'),
      name: '白班',
      shortName: '白',
      startMinute: 9 * 60,
      endMinute: 18 * 60,
      crossDay: false,
      unpaidBreakMinutes: 60,
      plannedPaidMinutes: 8 * 60,
      colorArgb: 0xFF3B82F6,
      isWorkday: true,
    ),
    ShiftSnapshot(
      id: ShiftId('system-evening'),
      name: '晚班',
      shortName: '晚',
      startMinute: 14 * 60,
      endMinute: 23 * 60,
      crossDay: false,
      unpaidBreakMinutes: 60,
      plannedPaidMinutes: 8 * 60,
      colorArgb: 0xFFF59E0B,
      isWorkday: true,
    ),
    ShiftSnapshot(
      id: ShiftId('system-night'),
      name: '夜班',
      shortName: '夜',
      startMinute: 20 * 60,
      endMinute: 8 * 60,
      crossDay: true,
      unpaidBreakMinutes: 60,
      plannedPaidMinutes: 11 * 60,
      colorArgb: 0xFF7C3AED,
      isWorkday: true,
    ),
  ];
}
