import 'dart:math';

import 'package:banxin_calendar/app/localization/generated/app_localizations.dart';
import 'package:banxin_calendar/core/presentation/app_message.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';
import 'package:banxin_calendar/features/statistics/application/workforce_providers.dart';
import 'package:banxin_calendar/features/statistics/domain/statistics_entities.dart';
import 'package:banxin_calendar/features/wage/domain/wage_entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class StatisticsPage extends ConsumerStatefulWidget {
  const StatisticsPage({super.key});

  @override
  ConsumerState<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends ConsumerState<StatisticsPage> {
  late DateRange _range;
  late Future<StatisticsReport> _report;
  var _attributionMode = StatisticsAttributionMode.workDate;

  @override
  void initState() {
    super.initState();
    _range = _thisMonth();
    _reload();
  }

  void _reload() {
    _report = ref
        .read(statisticsServiceProvider)
        .build(_range, attributionMode: _attributionMode);
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar.large(title: Text(strings.tabStatistics)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SegmentedButton<String>(
              segments: <ButtonSegment<String>>[
                ButtonSegment(
                  value: 'week',
                  label: Text(strings.statisticsThisWeek),
                ),
                ButtonSegment(
                  value: 'month',
                  label: Text(strings.statisticsThisMonth),
                ),
                ButtonSegment(
                  value: 'last',
                  label: Text(strings.statisticsLastMonth),
                ),
              ],
              selected: <String>{_rangeKey()},
              onSelectionChanged: (value) {
                setState(() {
                  _range = switch (value.single) {
                    'week' => _thisWeek(),
                    'last' => _lastMonth(),
                    _ => _thisMonth(),
                  };
                  _reload();
                });
              },
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: SegmentedButton<StatisticsAttributionMode>(
              segments: <ButtonSegment<StatisticsAttributionMode>>[
                ButtonSegment(
                  value: StatisticsAttributionMode.workDate,
                  label: Text(strings.statisticsByWorkDate),
                ),
                ButtonSegment(
                  value: StatisticsAttributionMode.naturalDay,
                  label: Text(strings.statisticsByNaturalDay),
                ),
              ],
              selected: <StatisticsAttributionMode>{_attributionMode},
              onSelectionChanged: (value) {
                setState(() {
                  _attributionMode = value.single;
                  _reload();
                });
              },
            ),
          ),
        ),
        FutureBuilder<StatisticsReport>(
          future: _report,
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
              child: _ReportBody(report: snapshot.requireData),
            );
          },
        ),
      ],
    );
  }

  String _rangeKey() {
    if (_sameRange(_range, _thisWeek())) return 'week';
    if (_sameRange(_range, _lastMonth())) return 'last';
    return 'month';
  }

  bool _sameRange(DateRange left, DateRange right) =>
      left.start == right.start && left.end == right.end;

  DateRange _thisWeek() {
    final now = DateTime.now();
    final today = LocalDate(now.year, now.month, now.day);
    final monday = today.addDays(1 - today.weekday);
    return DateRange(start: monday, end: monday.addDays(6));
  }

  DateRange _thisMonth() {
    final now = DateTime.now();
    final start = LocalDate(now.year, now.month, 1);
    final next = now.month == 12
        ? LocalDate(now.year + 1, 1, 1)
        : LocalDate(now.year, now.month + 1, 1);
    return DateRange(start: start, end: next.addDays(-1));
  }

  DateRange _lastMonth() {
    final now = DateTime.now();
    final thisStart = LocalDate(now.year, now.month, 1);
    final previousStart = now.month == 1
        ? LocalDate(now.year - 1, 12, 1)
        : LocalDate(now.year, now.month - 1, 1);
    return DateRange(start: previousStart, end: thisStart.addDays(-1));
  }
}

class _ReportBody extends ConsumerWidget {
  const _ReportBody({required this.report});

  final StatisticsReport report;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 96),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('${report.range.start} — ${report.range.end}'),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: MediaQuery.sizeOf(context).width >= 600 ? 4 : 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.45,
            children: <Widget>[
              _Metric(
                strings.expectedAttendance,
                '${report.expectedAttendanceDays}',
              ),
              _Metric(
                strings.actualAttendance,
                '${report.actualAttendanceDays}',
              ),
              _Metric(strings.actualHours, _hours(report.rawActualMinutes)),
              _Metric(strings.overtimeHours, _hours(report.overtimeMinutes)),
              _Metric(strings.lateCount, '${report.lateCount}'),
              _Metric(strings.earlyLeaveCount, '${report.earlyLeaveCount}'),
              _Metric(strings.missingPunch, '${report.missingPunchCount}'),
              _Metric(strings.plannedHours, _hours(report.plannedMinutes)),
            ],
          ),
          const SizedBox(height: 16),
          Semantics(
            label:
                '${strings.actualHours}: ${_hours(report.rawActualMinutes)}, ${strings.overtimeHours}: ${_hours(report.overtimeMinutes)}',
            child: SizedBox(
              height: 180,
              child: CustomPaint(
                painter: _HoursChartPainter(
                  report.days.map((day) => day.hours.payableMinutes).toList(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (report.payroll == null)
            OutlinedButton.icon(
              onPressed: () => context.push('/settings/wage'),
              icon: const Icon(Icons.payments_outlined),
              label: Text(strings.setupWageRule),
            )
          else
            _PayrollCard(report: report),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () async {
              final path = await ref
                  .read(statisticsExportServiceProvider)
                  .export(report.range);
              if (context.mounted) {
                AppMessage.show(
                  context,
                  '${strings.csvExported}: $path',
                  type: AppMessageType.success,
                );
              }
            },
            icon: const Icon(Icons.file_download_outlined),
            label: Text(strings.exportCsv),
          ),
          const SizedBox(height: 20),
          Text(
            strings.numericDetails,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          ...report.days.map(
            (day) => ListTile(
              dense: true,
              title: Text(
                '${day.date} · ${day.shiftName ?? day.scheduleStatus.name}',
              ),
              subtitle: Text(
                '${strings.rawWorkMinutes}: ${day.hours.rawActualMinutes} · '
                '${strings.normalWorkMinutes}: ${day.hours.normalMinutes} · '
                '${strings.overtimeWorkMinutes}: ${day.hours.overtimeMinutes}',
              ),
              trailing: day.hours.missingPunch
                  ? Tooltip(
                      message: strings.missingPunch,
                      child: const Icon(Icons.warning_amber),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  String _hours(int minutes) => (minutes / 60).toStringAsFixed(1);
}

class _Metric extends StatelessWidget {
  const _Metric(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(value, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 4),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
    ),
  );
}

class _PayrollCard extends ConsumerWidget {
  const _PayrollCard({required this.report});

  final StatisticsReport report;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context);
    final payroll = report.payroll!;
    final confirmed = report.savedPeriod?.confirmedMinor;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              strings.payrollBreakdown,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            _moneyLine(strings.basePay, payroll.basePayMinor, payroll.currency),
            _moneyLine(
              strings.normalHoursPay,
              payroll.normalHoursPayMinor,
              payroll.currency,
            ),
            _moneyLine(
              strings.workdayOvertimePay,
              payroll.overtimePayMinor[OvertimeType.workday] ?? 0,
              payroll.currency,
            ),
            _moneyLine(
              strings.restDayOvertimePay,
              payroll.overtimePayMinor[OvertimeType.restDay] ?? 0,
              payroll.currency,
            ),
            _moneyLine(
              strings.holidayOvertimePay,
              payroll.overtimePayMinor[OvertimeType.publicHoliday] ?? 0,
              payroll.currency,
            ),
            for (final line in payroll.allowances)
              _moneyLine(line.label, line.amountMinor, payroll.currency),
            for (final line in payroll.deductions)
              _moneyLine(line.label, -line.amountMinor, payroll.currency),
            const Divider(),
            _moneyLine(
              strings.estimatedTotal,
              payroll.estimatedTotalMinor,
              payroll.currency,
              emphasized: true,
            ),
            if (confirmed != null) ...<Widget>[
              _moneyLine(strings.actualPaidAmount, confirmed, payroll.currency),
              _moneyLine(
                strings.estimatedDifference,
                confirmed - payroll.estimatedTotalMinor,
                payroll.currency,
              ),
            ],
            Text(
              strings.wageDisclaimer,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: () => _settle(context, ref, payroll),
              child: Text(strings.settlePayroll),
            ),
          ],
        ),
      ),
    );
  }

  Widget _moneyLine(
    String label,
    int minor,
    String currency, {
    bool emphasized = false,
  }) => ListTile(
    dense: true,
    title: Text(label),
    trailing: Text(
      '$currency ${(minor / 100).toStringAsFixed(2)}',
      style: emphasized ? const TextStyle(fontWeight: FontWeight.bold) : null,
    ),
  );

  Future<void> _settle(
    BuildContext context,
    WidgetRef ref,
    PayrollResult payroll,
  ) async {
    final strings = AppLocalizations.of(context);
    final controller = TextEditingController(
      text: (payroll.estimatedTotalMinor / 100).toStringAsFixed(2),
    );
    final amount = await showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(strings.settlePayroll),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(labelText: strings.actualPaidAmount),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
          FilledButton(
            onPressed: () {
              final parsed = double.tryParse(controller.text);
              Navigator.pop(
                context,
                parsed == null ? null : (parsed * 100).round(),
              );
            },
            child: Text(strings.settlePayroll),
          ),
        ],
      ),
    );
    controller.dispose();
    if (amount == null) return;
    await ref
        .read(statisticsServiceProvider)
        .settle(report.range, confirmedMinor: amount);
  }
}

class _HoursChartPainter extends CustomPainter {
  const _HoursChartPainter(this.minutes);

  final List<int> minutes;

  @override
  void paint(Canvas canvas, Size size) {
    if (minutes.isEmpty) return;
    final maximum = max(480, minutes.reduce(max)).toDouble();
    final gap = 2.0;
    final width = max(1.0, size.width / minutes.length - gap);
    final paint = Paint()..color = const Color(0xFF3B82F6);
    for (var index = 0; index < minutes.length; index++) {
      final height = size.height * minutes[index] / maximum;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            index * (width + gap),
            size.height - height,
            width,
            height,
          ),
          const Radius.circular(2),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _HoursChartPainter oldDelegate) =>
      oldDelegate.minutes != minutes;
}
