import 'dart:async';

import 'package:banxin_calendar/app/localization/generated/app_localizations.dart';
import 'package:banxin_calendar/app/theme/app_theme.dart';
import 'package:banxin_calendar/core/presentation/app_message.dart';
import 'package:banxin_calendar/features/holiday/application/holiday_providers.dart';
import 'package:banxin_calendar/features/holiday/application/holiday_update_service.dart';
import 'package:banxin_calendar/features/holiday/domain/holiday_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HolidaySettingsPage extends ConsumerStatefulWidget {
  const HolidaySettingsPage({super.key});

  @override
  ConsumerState<HolidaySettingsPage> createState() =>
      _HolidaySettingsPageState();
}

class _HolidaySettingsPageState extends ConsumerState<HolidaySettingsPage> {
  late int _year;
  var _enabled = true;
  var _loading = true;
  HolidayUpdateResult? _result;

  @override
  void initState() {
    super.initState();
    _year = DateTime.now().year;
    unawaited(_loadEnabled());
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(strings.holidaySettingsTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: <Widget>[
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(strings.useOfficialHoliday),
              value: _enabled,
              onChanged: _loading ? null : _setEnabled,
            ),
            const SizedBox(height: AppSpacing.md),
            DropdownButtonFormField<int>(
              initialValue: _year,
              decoration: InputDecoration(labelText: strings.holidayYearLabel),
              items:
                  <int>[
                        DateTime.now().year - 1,
                        DateTime.now().year,
                        DateTime.now().year + 1,
                      ]
                      .map(
                        (year) => DropdownMenuItem<int>(
                          value: year,
                          child: Text('$year'),
                        ),
                      )
                      .toList(growable: false),
              onChanged: _loading
                  ? null
                  : (value) => setState(() => _year = value ?? _year),
            ),
            const SizedBox(height: AppSpacing.md),
            FilledButton.icon(
              onPressed: _loading ? null : _update,
              icon: _loading
                  ? const SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.cloud_download_outlined),
              label: Text(strings.updateHolidayData),
            ),
            if (_result != null) ...<Widget>[
              const SizedBox(height: AppSpacing.lg),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${strings.holidayDataVersion}: '
                        '${_result!.dataset.dataVersion}',
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        '${strings.holidayUpdateAdded}: '
                        '${_result!.summary.added}',
                      ),
                      Text(
                        '${strings.holidayUpdateRemoved}: '
                        '${_result!.summary.removed}',
                      ),
                      Text(
                        '${strings.holidayUpdateChanged}: '
                        '${_result!.summary.changed}',
                      ),
                      const Divider(),
                      Text(strings.holidaySourcePapers),
                      for (final paper in _result!.dataset.sourcePapers)
                        SelectableText(paper),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _loadEnabled() async {
    final enabled = await ref.read(holidayUpdateServiceProvider).isEnabled();
    if (mounted) {
      setState(() {
        _enabled = enabled;
        _loading = false;
      });
    }
  }

  Future<void> _setEnabled(bool enabled) async {
    setState(() => _loading = true);
    await ref.read(holidayUpdateServiceProvider).setEnabled(enabled: enabled);
    if (mounted) {
      setState(() {
        _enabled = enabled;
        _loading = false;
      });
    }
  }

  Future<void> _update() async {
    final strings = AppLocalizations.of(context);
    setState(() => _loading = true);
    try {
      final result = await ref
          .read(holidayUpdateServiceProvider)
          .updateYear(_year);
      if (mounted) {
        setState(() {
          _result = result;
          _loading = false;
        });
      }
    } on Object catch (error) {
      if (!mounted) return;
      setState(() => _loading = false);
      AppMessage.show(
        context,
        _errorMessage(strings, error),
        type: AppMessageType.error,
      );
    }
  }

  String _errorMessage(AppLocalizations strings, Object error) {
    if (error is HolidayFetchException) {
      return switch (error.kind) {
        HolidayFetchFailureKind.network => strings.holidayNetworkUnavailable,
        HolidayFetchFailureKind.notFound => strings.holidayYearUnavailable,
        HolidayFetchFailureKind.invalidData => strings.holidayDataInvalid,
        HolidayFetchFailureKind.unexpected => strings.holidayOfflineRetained,
      };
    }
    return strings.holidayOfflineRetained;
  }
}
