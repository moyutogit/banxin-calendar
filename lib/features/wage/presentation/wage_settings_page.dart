import 'dart:async';

import 'package:banxin_calendar/app/localization/generated/app_localizations.dart';
import 'package:banxin_calendar/core/presentation/app_message.dart';
import 'package:banxin_calendar/features/attendance/domain/attendance_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';
import 'package:banxin_calendar/features/statistics/application/workforce_providers.dart';
import 'package:banxin_calendar/features/wage/application/wage_application_service.dart';
import 'package:banxin_calendar/features/wage/domain/wage_entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WageSettingsPage extends ConsumerStatefulWidget {
  const WageSettingsPage({super.key});

  @override
  ConsumerState<WageSettingsPage> createState() => _WageSettingsPageState();
}

class _WageSettingsPageState extends ConsumerState<WageSettingsPage> {
  final _formKey = GlobalKey<FormState>();
  final _baseRate = TextEditingController(text: '0.00');
  final _currency = TextEditingController(text: 'CNY');
  final _workdayRate = TextEditingController(text: '1.5');
  final _restRate = TextEditingController(text: '2.0');
  final _holidayRate = TextEditingController(text: '3.0');
  final _periodStart = TextEditingController(text: '1');
  final _allowance = TextEditingController(text: '0.00');
  final _deduction = TextEditingController(text: '0.00');
  WageMode _mode = WageMode.hourly;
  int _roundingIncrement = 1;
  bool _confirmedOnly = false;
  String? _ruleId;
  var _saving = false;

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  @override
  void dispose() {
    _baseRate.dispose();
    _currency.dispose();
    _workdayRate.dispose();
    _restRate.dispose();
    _holidayRate.dispose();
    _periodStart.dispose();
    _allowance.dispose();
    _deduction.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final now = DateTime.now();
    final rule = await ref
        .read(wageApplicationServiceProvider)
        .loadFor(LocalDate(now.year, now.month, now.day));
    if (rule == null || !mounted) return;
    setState(() {
      _ruleId = rule.id;
      _mode = rule.mode;
      _baseRate.text = (rule.baseRateMinor / 100).toStringAsFixed(2);
      _currency.text = rule.currency;
      _workdayRate.text =
          ((rule.overtimeRateBasisPoints[OvertimeType.workday] ?? 10000) /
                  10000)
              .toString();
      _restRate.text =
          ((rule.overtimeRateBasisPoints[OvertimeType.restDay] ?? 10000) /
                  10000)
              .toString();
      _holidayRate.text =
          ((rule.overtimeRateBasisPoints[OvertimeType.publicHoliday] ?? 10000) /
                  10000)
              .toString();
      _periodStart.text = '${rule.periodStartDay}';
      _roundingIncrement = rule.roundingIncrementMinutes;
      _confirmedOnly = rule.confirmedOnly;
      _allowance.text =
          (rule.allowances.fold<int>(0, (sum, line) => sum + line.amountMinor) /
                  100)
              .toStringAsFixed(2);
      _deduction.text =
          (rule.deductions.fold<int>(0, (sum, line) => sum + line.amountMinor) /
                  100)
              .toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(strings.wageSettingsTitle)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            SegmentedButton<WageMode>(
              segments: <ButtonSegment<WageMode>>[
                ButtonSegment(
                  value: WageMode.hourly,
                  label: Text(strings.wageModeHourly),
                ),
                ButtonSegment(
                  value: WageMode.daily,
                  label: Text(strings.wageModeDaily),
                ),
                ButtonSegment(
                  value: WageMode.monthly,
                  label: Text(strings.wageModeMonthly),
                ),
              ],
              selected: <WageMode>{_mode},
              onSelectionChanged: (value) =>
                  setState(() => _mode = value.single),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _baseRate,
              decoration: InputDecoration(labelText: strings.baseRate),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: _positiveNumber,
            ),
            TextFormField(
              controller: _currency,
              decoration: InputDecoration(labelText: strings.currencyCode),
              textCapitalization: TextCapitalization.characters,
              validator: (value) =>
                  value?.trim().length == 3 ? null : strings.invalidFormMessage,
            ),
            TextFormField(
              controller: _workdayRate,
              decoration: InputDecoration(
                labelText: strings.workdayOvertimeRate,
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: _positiveNumber,
            ),
            TextFormField(
              controller: _restRate,
              decoration: InputDecoration(
                labelText: strings.restDayOvertimeRate,
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: _positiveNumber,
            ),
            TextFormField(
              controller: _holidayRate,
              decoration: InputDecoration(
                labelText: strings.holidayOvertimeRate,
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: _positiveNumber,
            ),
            TextFormField(
              controller: _periodStart,
              decoration: InputDecoration(labelText: strings.payPeriodStartDay),
              keyboardType: TextInputType.number,
              validator: (value) {
                final number = int.tryParse(value ?? '');
                return number != null && number >= 1 && number <= 28
                    ? null
                    : strings.invalidFormMessage;
              },
            ),
            TextFormField(
              controller: _allowance,
              decoration: InputDecoration(labelText: strings.fixedAllowance),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: _positiveNumber,
            ),
            TextFormField(
              controller: _deduction,
              decoration: InputDecoration(labelText: strings.fixedDeduction),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: _positiveNumber,
            ),
            DropdownButtonFormField<int>(
              initialValue: _roundingIncrement,
              decoration: InputDecoration(labelText: strings.roundingIncrement),
              items: const <int>[1, 5, 15, 30]
                  .map(
                    (value) => DropdownMenuItem<int>(
                      value: value,
                      child: Text('$value'),
                    ),
                  )
                  .toList(),
              onChanged: (value) => _roundingIncrement = value ?? 1,
            ),
            SwitchListTile(
              value: _confirmedOnly,
              title: Text(strings.confirmedOnly),
              onChanged: (value) => setState(() => _confirmedOnly = value),
            ),
            const SizedBox(height: 12),
            Text(
              strings.wageDisclaimer,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: _saving ? null : _save,
              icon: const Icon(Icons.save_outlined),
              label: Text(MaterialLocalizations.of(context).saveButtonLabel),
            ),
          ],
        ),
      ),
    );
  }

  String? _positiveNumber(String? value) {
    final number = double.tryParse(value ?? '');
    return number != null && number >= 0
        ? null
        : AppLocalizations.of(context).invalidFormMessage;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final now = DateTime.now();
    await ref
        .read(wageApplicationServiceProvider)
        .save(
          WageRuleDraft(
            id: _ruleId,
            mode: _mode,
            currency: _currency.text.trim(),
            baseRateMinor: (double.parse(_baseRate.text) * 100).round(),
            workdayOvertimeBasisPoints:
                (double.parse(_workdayRate.text) * 10000).round(),
            restDayOvertimeBasisPoints: (double.parse(_restRate.text) * 10000)
                .round(),
            holidayOvertimeBasisPoints:
                (double.parse(_holidayRate.text) * 10000).round(),
            periodStartDay: int.parse(_periodStart.text),
            roundingMode: _roundingIncrement == 1
                ? MinuteRoundingMode.none
                : MinuteRoundingMode.nearest,
            roundingIncrementMinutes: _roundingIncrement,
            confirmedOnly: _confirmedOnly,
            effectiveStart: LocalDate(now.year, now.month, now.day),
            allowances: <MoneyLine>[
              if (double.parse(_allowance.text) > 0)
                MoneyLine(
                  label: AppLocalizations.of(context).fixedAllowance,
                  amountMinor: (double.parse(_allowance.text) * 100).round(),
                ),
            ],
            deductions: <MoneyLine>[
              if (double.parse(_deduction.text) > 0)
                MoneyLine(
                  label: AppLocalizations.of(context).fixedDeduction,
                  amountMinor: (double.parse(_deduction.text) * 100).round(),
                ),
            ],
          ),
        );
    if (mounted) {
      setState(() => _saving = false);
      AppMessage.show(
        context,
        AppLocalizations.of(context).wageRuleSaved,
        type: AppMessageType.success,
      );
    }
  }
}
