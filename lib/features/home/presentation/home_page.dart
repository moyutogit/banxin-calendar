import 'package:banxin_calendar/app/localization/generated/app_localizations.dart';
import 'package:banxin_calendar/core/presentation/app_message.dart';
import 'package:banxin_calendar/features/home/application/home_application_service.dart';
import 'package:banxin_calendar/features/home/application/home_providers.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';
import 'package:banxin_calendar/features/schedule/presentation/schedule_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late Future<HomeDashboard> _dashboard;
  var _punching = false;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _dashboard = ref.read(homeApplicationServiceProvider).load();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar.large(title: Text(strings.homeHeadline)),
        FutureBuilder<HomeDashboard>(
          future: _dashboard,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              );
            }
            if (snapshot.hasError) {
              return SliverFillRemaining(
                child: Center(
                  child: FilledButton(
                    onPressed: () => setState(_reload),
                    child: Text(strings.actionRetry),
                  ),
                ),
              );
            }
            return SliverToBoxAdapter(
              child: _DashboardBody(
                dashboard: snapshot.requireData,
                punching: _punching,
                onPunch: _punch,
              ),
            );
          },
        ),
      ],
    );
  }

  Future<void> _punch() async {
    setState(() => _punching = true);
    final result = await ref.read(homeApplicationServiceProvider).punchToday();
    if (!mounted) return;
    if (result.requiresPayrollRecalculation) {
      AppMessage.show(
        context,
        AppLocalizations.of(context).payrollRecalculationWarning,
        type: AppMessageType.warning,
      );
    }
    setState(() {
      _punching = false;
      _reload();
    });
  }
}

class _DashboardBody extends StatelessWidget {
  const _DashboardBody({
    required this.dashboard,
    required this.punching,
    required this.onPunch,
  });

  final HomeDashboard dashboard;
  final bool punching;
  final VoidCallback onPunch;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final today = dashboard.today;
    final workday =
        today?.status == DayStatus.work ||
        today?.status == DayStatus.adjustedWorkday;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (!dashboard.scheduleConfigured)
            FilledButton.icon(
              onPressed: () => context.push('/schedule/setup'),
              icon: const Icon(Icons.add),
              label: Text(strings.configureScheduleRules),
            )
          else
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(strings.homeTodayShift),
                    const SizedBox(height: 8),
                    Text(
                      workday
                          ? (today?.shift?.name ?? strings.dayStatusWork)
                          : strings.homeRestToday,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    if (today?.shift != null)
                      Text(
                        '${_minute(today!.shift!.startMinute)} — '
                        '${_minute(today.shift!.endMinute)} · '
                        '${today.plannedPaidMinutes} ${strings.minuteUnit}',
                      ),
                    if (workday) ...<Widget>[
                      const SizedBox(height: 16),
                      FilledButton.icon(
                        onPressed: punching ? null : onPunch,
                        icon: Icon(
                          dashboard.attendance.hasOpenPunch
                              ? Icons.logout
                              : Icons.login,
                        ),
                        label: Text(
                          dashboard.attendance.hasOpenPunch
                              ? strings.punchOut
                              : strings.punchIn,
                        ),
                      ),
                    ],
                    if (dashboard.attendance.hours.missingPunch)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.warning_amber),
                        title: Text(strings.missingPunch),
                        onTap: () => context.push('/day/${today?.date}'),
                      ),
                  ],
                ),
              ),
            ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.alarm_outlined),
              title: Text(strings.nextAlarm),
              subtitle: Text(
                dashboard.nextAlarm == null
                    ? strings.notConfigured
                    : '${dashboard.nextAlarm!.scheduleDate} · '
                          '${TimeOfDay.fromDateTime(dashboard.nextAlarm!.triggerAtUtc.toLocal()).format(context)}',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/settings/alarm'),
            ),
          ),
          _MonthSummary(dashboard: dashboard),
          const SizedBox(height: 16),
          Text(
            strings.futureSevenDays,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 84,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: dashboard.nextSevenDays.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final day = dashboard.nextSevenDays[index];
                return ActionChip(
                  avatar: CircleAvatar(
                    backgroundColor: Color(day.shift?.colorArgb ?? 0xFFE5E7EB),
                    child: Text('${day.date.day}'),
                  ),
                  label: Text(
                    day.shift?.shortName ?? strings.dayStatusLabel(day.status),
                  ),
                  onPressed: () => context.push('/day/${day.date}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _minute(int minute) =>
      '${(minute ~/ 60).toString().padLeft(2, '0')}:'
      '${(minute % 60).toString().padLeft(2, '0')}';
}

class _MonthSummary extends StatelessWidget {
  const _MonthSummary({required this.dashboard});

  final HomeDashboard dashboard;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final report = dashboard.month;
    final payroll = report.payroll;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          alignment: WrapAlignment.spaceAround,
          spacing: 16,
          runSpacing: 12,
          children: <Widget>[
            _summary(
              strings.monthlyEstimatedIncome,
              payroll == null
                  ? strings.setupWageRule
                  : '${payroll.currency} ${(payroll.estimatedTotalMinor / 100).toStringAsFixed(2)}',
            ),
            _summary(strings.attendanceDays, '${report.actualAttendanceDays}'),
            _summary(
              strings.actualHours,
              (report.rawActualMinutes / 60).toStringAsFixed(1),
            ),
            _summary(
              strings.overtimeHours,
              (report.overtimeMinutes / 60).toStringAsFixed(1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summary(String label, String value) => Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      Text(label),
    ],
  );
}
