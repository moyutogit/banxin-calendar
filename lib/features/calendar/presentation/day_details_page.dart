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

class DayDetailsPage extends ConsumerStatefulWidget {
  const DayDetailsPage({required this.date, super.key});

  final LocalDate date;

  @override
  ConsumerState<DayDetailsPage> createState() => _DayDetailsPageState();
}

class _DayDetailsPageState extends ConsumerState<DayDetailsPage> {
  late Future<ScheduleCalendarView> _future;
  var _changed = false;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return PopScope<bool>(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) context.pop(_changed);
      },
      child: Scaffold(
        appBar: AppBar(title: Text(strings.dayDetailsTitle)),
        body: SafeArea(
          child: FutureBuilder<ScheduleCalendarView>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError || !snapshot.requireData.configured) {
                return Center(
                  child: FilledButton(
                    onPressed: () => setState(_reload),
                    child: Text(strings.actionRetry),
                  ),
                );
              }
              final view = snapshot.requireData;
              return _buildDay(view.days.single, view.shifts);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDay(ResolvedCalendarDay day, List<ShiftSnapshot> shifts) {
    final strings = AppLocalizations.of(context);
    final shift = day.shift;
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: <Widget>[
        Text('${day.date}', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: AppSpacing.md),
        Card(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.event_available_outlined),
                title: Text(strings.dayStatusLabel(day.status)),
                subtitle: Text(strings.daySourceLabel(day.source)),
              ),
              ListTile(
                leading: const Icon(Icons.badge_outlined),
                title: Text(shift?.name ?? strings.noShiftLabel),
                subtitle: shift == null
                    ? null
                    : Text(
                        '${strings.shiftTimeLabel}: '
                        '${_formatMinute(shift.startMinute)}–'
                        '${_formatMinute(shift.endMinute)}'
                        '${shift.crossDay ? ' · ${strings.endsNextDay}' : ''}',
                      ),
              ),
              ListTile(
                leading: const Icon(Icons.schedule_outlined),
                title: Text(
                  '${strings.plannedMinutesLabel}: '
                  '${day.plannedPaidMinutes} ${strings.minuteUnit}',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: <Widget>[
            FilledButton.icon(
              onPressed: shifts.isEmpty
                  ? null
                  : () => _applyStatus(DayStatus.work, shifts.first),
              icon: const Icon(Icons.work_outline),
              label: Text(strings.setAsWork),
            ),
            OutlinedButton.icon(
              onPressed: () => _applyStatus(DayStatus.rest, null),
              icon: const Icon(Icons.weekend_outlined),
              label: Text(strings.setAsRest),
            ),
            if (day.source == DaySource.userOverride)
              TextButton.icon(
                onPressed: _restore,
                icon: const Icon(Icons.restore),
                label: Text(strings.restoreRuleResult),
              ),
          ],
        ),
      ],
    );
  }

  Future<void> _applyStatus(DayStatus status, ShiftSnapshot? shift) async {
    final service = ref.read(scheduleApplicationServiceProvider);
    final preview = await service.previewOverride(
      dates: <LocalDate>[widget.date],
      status: status,
      shift: shift,
    );
    if (!mounted) return;
    final strings = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(strings.previewChanges),
        content: Text(strings.dayStatusLabel(status)),
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
        _changed = true;
        _reload();
      });
    }
  }

  Future<void> _restore() async {
    await ref
        .read(scheduleApplicationServiceProvider)
        .restoreRuleResult(DateRange(start: widget.date, end: widget.date));
    if (mounted) {
      setState(() {
        _changed = true;
        _reload();
      });
    }
  }

  void _reload() {
    _future = ref
        .read(scheduleApplicationServiceProvider)
        .loadCalendar(DateRange(start: widget.date, end: widget.date));
  }

  String _formatMinute(int minute) {
    final hour = (minute ~/ 60).toString().padLeft(2, '0');
    final minuteText = (minute % 60).toString().padLeft(2, '0');
    return '$hour:$minuteText';
  }
}
