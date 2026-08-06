import 'package:banxin_calendar/app/localization/generated/app_localizations.dart';
import 'package:banxin_calendar/app/theme/app_theme.dart';
import 'package:banxin_calendar/features/schedule/application/schedule_application_service.dart';
import 'package:banxin_calendar/features/schedule/application/schedule_providers.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';
import 'package:banxin_calendar/features/schedule/presentation/schedule_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key});

  @override
  ConsumerState<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  late DateTime _month;
  late LocalDate _selectedDate;
  late Future<ScheduleCalendarView> _future;
  final Set<LocalDate> _multiSelection = <LocalDate>{};
  DayStatus? _filter;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _month = DateTime(now.year, now.month);
    _selectedDate = LocalDate(now.year, now.month, now.day);
    _reload();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar.large(
          title: Text(strings.tabCalendar),
          actions: <Widget>[
            IconButton(
              tooltip: strings.calendarToday,
              onPressed: _goToday,
              icon: const Icon(Icons.today_outlined),
            ),
            PopupMenuButton<DayStatus?>(
              tooltip: strings.calendarFilter,
              initialValue: _filter,
              onSelected: (value) => setState(() => _filter = value),
              itemBuilder: (_) => <PopupMenuEntry<DayStatus?>>[
                PopupMenuItem<DayStatus?>(
                  value: null,
                  child: Text(strings.calendarFilter),
                ),
                for (final status in DayStatus.values)
                  PopupMenuItem<DayStatus?>(
                    value: status,
                    child: Text(strings.dayStatusLabel(status)),
                  ),
              ],
              icon: const Icon(Icons.filter_alt_outlined),
            ),
            IconButton(
              tooltip: strings.calendarAddSchedule,
              onPressed: () => context.push('/schedule/rules'),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.all(AppSpacing.md),
          sliver: SliverToBoxAdapter(
            child: FutureBuilder<ScheduleCalendarView>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return _LoadingCalendar(label: strings.calendarLoading);
                }
                if (snapshot.hasError) {
                  return _CalendarError(onRetry: () => setState(_reload));
                }
                final view = snapshot.requireData;
                if (!view.configured) {
                  return _EmptyCalendar(onConfigured: _openSetup);
                }
                return _buildCalendar(view);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendar(ScheduleCalendarView view) {
    final strings = AppLocalizations.of(context);
    final byDate = <LocalDate, ResolvedCalendarDay>{
      for (final day in view.days) day.date: day,
    };
    final range = _gridRange;
    final dates = range.dates.toList(growable: false);
    final selectedDay = byDate[_selectedDate];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            IconButton(
              tooltip: strings.calendarPreviousMonth,
              onPressed: () => _changeMonth(-1),
              icon: const Icon(Icons.chevron_left),
            ),
            Expanded(
              child: Text(
                MaterialLocalizations.of(context).formatMonthYear(_month),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            IconButton(
              tooltip: strings.calendarNextMonth,
              onPressed: () => _changeMonth(1),
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: <Widget>[
            for (final label in <String>[
              strings.weekdayMonday,
              strings.weekdayTuesday,
              strings.weekdayWednesday,
              strings.weekdayThursday,
              strings.weekdayFriday,
              strings.weekdaySaturday,
              strings.weekdaySunday,
            ])
              Expanded(
                child: Semantics(
                  header: true,
                  child: Text(label, textAlign: TextAlign.center),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: DateTime.daysPerWeek,
            mainAxisExtent: 34 + MediaQuery.textScalerOf(context).scale(48),
            crossAxisSpacing: AppSpacing.xs,
            mainAxisSpacing: AppSpacing.xs,
          ),
          itemCount: dates.length,
          itemBuilder: (context, index) {
            final date = dates[index];
            final day = byDate[date];
            return _CalendarDayCell(
              date: date,
              day: day,
              inCurrentMonth: date.month == _month.month,
              selected: date == _selectedDate,
              multiSelected: _multiSelection.contains(date),
              today: date == _today,
              filteredOut: _filter != null && day?.status != _filter,
              onTap: () => _selectDate(date),
              onLongPress: () => _startMultiSelection(date),
            );
          },
        ),
        const SizedBox(height: AppSpacing.md),
        if (_multiSelection.isNotEmpty)
          _BatchActions(
            count: _multiSelection.length,
            onModify: () => _showOverrideDialog(view),
            onClear: () => setState(_multiSelection.clear),
          )
        else if (selectedDay != null)
          _SelectedDayCard(
            day: selectedDay,
            onDetails: () => _openDetails(selectedDay.date),
            onModify: () => _showOverrideDialog(view),
            onRestore: selectedDay.source == DaySource.userOverride
                ? () => _restore(selectedDay.date)
                : null,
          ),
      ],
    );
  }

  void _reload() {
    _future = ref
        .read(scheduleApplicationServiceProvider)
        .loadCalendar(_gridRange);
  }

  Future<void> _openSetup() async {
    final changed = await context.push<bool>('/schedule/setup');
    if (changed == true && mounted) {
      setState(_reload);
    }
  }

  Future<void> _openDetails(LocalDate date) async {
    final changed = await context.push<bool>('/day/$date');
    if (changed == true && mounted) {
      setState(_reload);
    }
  }

  void _selectDate(LocalDate date) {
    setState(() {
      if (_multiSelection.isNotEmpty) {
        if (!_multiSelection.add(date)) {
          _multiSelection.remove(date);
        }
      } else {
        _selectedDate = date;
      }
    });
  }

  void _startMultiSelection(LocalDate date) {
    setState(() {
      _multiSelection.add(date);
      _selectedDate = date;
    });
  }

  void _changeMonth(int offset) {
    setState(() {
      _month = DateTime(_month.year, _month.month + offset);
      _selectedDate = LocalDate(_month.year, _month.month, 1);
      _multiSelection.clear();
      _reload();
    });
  }

  void _goToday() {
    final now = DateTime.now();
    setState(() {
      _month = DateTime(now.year, now.month);
      _selectedDate = LocalDate(now.year, now.month, now.day);
      _multiSelection.clear();
      _reload();
    });
  }

  Future<void> _showOverrideDialog(ScheduleCalendarView view) async {
    final dates = _multiSelection.isEmpty
        ? <LocalDate>[_selectedDate]
        : (_multiSelection.toList()..sort());
    var status = DayStatus.rest;
    ShiftSnapshot? shift = view.shifts.firstOrNull;
    final strings = AppLocalizations.of(context);
    final requested = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(strings.modifySchedule),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DropdownButtonFormField<DayStatus>(
                initialValue: status,
                decoration: InputDecoration(
                  labelText: strings.selectStatusLabel,
                ),
                items:
                    <DayStatus>[DayStatus.work, DayStatus.rest, DayStatus.leave]
                        .map(
                          (value) => DropdownMenuItem<DayStatus>(
                            value: value,
                            child: Text(strings.dayStatusLabel(value)),
                          ),
                        )
                        .toList(growable: false),
                onChanged: (value) => setDialogState(() {
                  status = value ?? status;
                }),
              ),
              if (status == DayStatus.work) ...<Widget>[
                const SizedBox(height: AppSpacing.md),
                DropdownButtonFormField<ShiftSnapshot>(
                  initialValue: shift,
                  decoration: InputDecoration(
                    labelText: strings.selectShiftLabel,
                  ),
                  items: view.shifts
                      .map(
                        (item) => DropdownMenuItem<ShiftSnapshot>(
                          value: item,
                          child: Text(item.name),
                        ),
                      )
                      .toList(growable: false),
                  onChanged: (value) => setDialogState(() => shift = value),
                ),
              ],
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(strings.actionCancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(strings.previewChanges),
            ),
          ],
        ),
      ),
    );
    if (requested != true || !mounted) return;

    final service = ref.read(scheduleApplicationServiceProvider);
    final preview = await service.previewOverride(
      dates: dates,
      status: status,
      shift: status == DayStatus.work ? shift : null,
    );
    if (!mounted) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(strings.previewChanges),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('${strings.batchSelection}: ${preview.dates.length}'),
            const SizedBox(height: AppSpacing.sm),
            for (final entry in preview.originalStatusCounts.entries)
              Text('${strings.dayStatusLabel(entry.key)}: ${entry.value}'),
            const Divider(),
            Text(
              '${strings.selectStatusLabel}: '
              '${strings.dayStatusLabel(preview.newStatus)}',
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(strings.actionCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(strings.confirmChanges),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await service.applyOverride(preview);
    if (mounted) {
      setState(() {
        _multiSelection.clear();
        _reload();
      });
    }
  }

  Future<void> _restore(LocalDate date) async {
    await ref
        .read(scheduleApplicationServiceProvider)
        .restoreRuleResult(DateRange(start: date, end: date));
    if (mounted) {
      setState(_reload);
    }
  }

  DateRange get _gridRange {
    final first = LocalDate(_month.year, _month.month, 1);
    final lastDateTime = DateTime(_month.year, _month.month + 1, 0);
    final last = LocalDate(
      lastDateTime.year,
      lastDateTime.month,
      lastDateTime.day,
    );
    return DateRange(
      start: first.addDays(DateTime.monday - first.weekday),
      end: last.addDays(DateTime.sunday - last.weekday),
    );
  }

  LocalDate get _today {
    final now = DateTime.now();
    return LocalDate(now.year, now.month, now.day);
  }
}

final class _CalendarDayCell extends StatelessWidget {
  const _CalendarDayCell({
    required this.date,
    required this.day,
    required this.inCurrentMonth,
    required this.selected,
    required this.multiSelected,
    required this.today,
    required this.filteredOut,
    required this.onTap,
    required this.onLongPress,
  });

  final LocalDate date;
  final ResolvedCalendarDay? day;
  final bool inCurrentMonth;
  final bool selected;
  final bool multiSelected;
  final bool today;
  final bool filteredOut;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final status = day?.status;
    final background = switch (status) {
      DayStatus.publicHoliday => colorScheme.errorContainer,
      DayStatus.leave => const Color(0xFFFDE68A),
      DayStatus.rest => colorScheme.surfaceContainerHighest,
      _ when day?.shift != null => Color(day!.shift!.colorArgb),
      _ => colorScheme.surfaceContainer,
    };
    final foreground =
        ThemeData.estimateBrightnessForColor(background) == Brightness.dark
        ? Colors.white
        : Colors.black87;
    final borderColor = selected
        ? colorScheme.primary
        : multiSelected
        ? colorScheme.tertiary
        : today
        ? colorScheme.secondary
        : status == DayStatus.adjustedWorkday
        ? Colors.orange
        : Colors.transparent;

    return Semantics(
      button: true,
      selected: selected || multiSelected,
      label: day == null
          ? '$date'
          : '$date, ${strings.dayStatusLabel(day!.status)}, '
                '${day!.shift?.name ?? strings.noShiftLabel}, '
                '${strings.daySourceLabel(day!.source)}',
      child: Opacity(
        opacity: !inCurrentMonth || filteredOut ? 0.38 : 1,
        child: Material(
          color: background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: borderColor,
              width: selected || multiSelected ? 3 : 2,
            ),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onTap,
            onLongPress: onLongPress,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '$date'.split('-').last,
                    style: TextStyle(color: foreground),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _shortLabel(strings),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: foreground,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (status == DayStatus.adjustedWorkday)
                    Text(
                      strings.adjustedWorkBadge,
                      style: TextStyle(color: foreground, fontSize: 10),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _shortLabel(AppLocalizations strings) {
    final value = day;
    if (value == null) return '';
    return value.shift?.shortName ??
        switch (value.status) {
          DayStatus.rest => strings.dayStatusRest,
          DayStatus.publicHoliday => strings.holidayBadge,
          DayStatus.leave => strings.leaveBadge,
          _ => strings.dayStatusLabel(value.status),
        };
  }
}

final class _SelectedDayCard extends StatelessWidget {
  const _SelectedDayCard({
    required this.day,
    required this.onDetails,
    required this.onModify,
    this.onRestore,
  });

  final ResolvedCalendarDay day;
  final VoidCallback onDetails;
  final VoidCallback onModify;
  final VoidCallback? onRestore;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('${day.date}', style: Theme.of(context).textTheme.titleMedium),
            Text(strings.dayStatusLabel(day.status)),
            Text(strings.daySourceLabel(day.source)),
            Text(day.shift?.name ?? strings.noShiftLabel),
            Text(
              '${strings.plannedMinutesLabel}: ${day.plannedPaidMinutes} '
              '${strings.minuteUnit}',
            ),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              children: <Widget>[
                OutlinedButton(
                  onPressed: onDetails,
                  child: Text(strings.actionDetails),
                ),
                FilledButton(
                  onPressed: onModify,
                  child: Text(strings.modifySchedule),
                ),
                if (onRestore != null)
                  TextButton(
                    onPressed: onRestore,
                    child: Text(strings.restoreRuleResult),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

final class _BatchActions extends StatelessWidget {
  const _BatchActions({
    required this.count,
    required this.onModify,
    required this.onClear,
  });

  final int count;
  final VoidCallback onModify;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: <Widget>[
            Expanded(child: Text('${strings.batchSelection}: $count')),
            TextButton(onPressed: onClear, child: Text(strings.clearSelection)),
            FilledButton(
              onPressed: onModify,
              child: Text(strings.modifySchedule),
            ),
          ],
        ),
      ),
    );
  }
}

final class _LoadingCalendar extends StatelessWidget {
  const _LoadingCalendar({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Column(
        children: <Widget>[
          const CircularProgressIndicator(),
          const SizedBox(height: AppSpacing.md),
          Text(label),
        ],
      ),
    );
  }
}

final class _CalendarError extends StatelessWidget {
  const _CalendarError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Center(
      child: Column(
        children: <Widget>[
          Text(strings.calendarLoadError),
          FilledButton(onPressed: onRetry, child: Text(strings.actionRetry)),
        ],
      ),
    );
  }
}

final class _EmptyCalendar extends StatelessWidget {
  const _EmptyCalendar({required this.onConfigured});

  final VoidCallback onConfigured;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Icon(Icons.calendar_month_outlined, size: 40),
            const SizedBox(height: AppSpacing.md),
            Text(
              strings.scheduleNotConfiguredTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(strings.scheduleNotConfiguredDescription),
            const SizedBox(height: AppSpacing.lg),
            FilledButton.icon(
              onPressed: onConfigured,
              icon: const Icon(Icons.event_repeat_outlined),
              label: Text(strings.configureScheduleRules),
            ),
          ],
        ),
      ),
    );
  }
}
