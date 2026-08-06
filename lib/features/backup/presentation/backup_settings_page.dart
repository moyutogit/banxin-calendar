import 'dart:async';

import 'package:banxin_calendar/app/localization/generated/app_localizations.dart';
import 'package:banxin_calendar/core/diagnostics/app_error_reporter.dart';
import 'package:banxin_calendar/core/presentation/app_message.dart';
import 'package:banxin_calendar/features/backup/application/backup_application_service.dart';
import 'package:banxin_calendar/features/backup/application/backup_providers.dart';
import 'package:banxin_calendar/features/backup/domain/backup_entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;

class BackupSettingsPage extends ConsumerStatefulWidget {
  const BackupSettingsPage({super.key});

  @override
  ConsumerState<BackupSettingsPage> createState() => _BackupSettingsPageState();
}

class _BackupSettingsPageState extends ConsumerState<BackupSettingsPage> {
  List<LocalBackupEntry> _backups = const <LocalBackupEntry>[];
  bool _automaticEnabled = true;
  bool _loading = true;
  bool _busy = false;
  String? _error;

  BackupApplicationService get _service =>
      ref.read(backupApplicationServiceProvider);

  @override
  void initState() {
    super.initState();
    unawaited(_reload());
  }

  Future<void> _reload() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final results = await Future.wait<Object>(<Future<Object>>[
        _service.loadBackups(),
        _service.isAutomaticBackupEnabled(),
      ]);
      if (!mounted) return;
      setState(() {
        _backups = results[0] as List<LocalBackupEntry>;
        _automaticEnabled = results[1] as bool;
      });
    } on Object catch (error) {
      if (mounted) setState(() => _error = error.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _createBackup() async {
    await _run(() async {
      await _service.createManualBackup();
      await _reload();
      if (mounted) {
        _showMessage(AppLocalizations.of(context).backupCreated);
      }
    });
  }

  Future<void> _restore(LocalBackupEntry entry) async {
    final strings = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(strings.restoreBackupTitle),
        content: Text(
          strings.restoreBackupRisk(
            _formatTime(entry.manifest.createdAtUtc),
            _formatRange(entry.manifest),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(strings.actionCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(strings.restoreBackupAction),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await _run(() async {
      final result = await _service.restore(entry);
      await _reload();
      if (mounted) {
        _showMessage(
          result.alarmRebuildSucceeded
              ? strings.restoreBackupSucceeded
              : strings.restoreBackupAlarmWarning,
        );
      }
    });
  }

  Future<void> _clear(
    PrivacyClearTarget target,
    String title,
    String description,
  ) async {
    final strings = AppLocalizations.of(context);
    final first = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(strings.actionCancel),
          ),
          FilledButton.tonal(
            onPressed: () => Navigator.pop(context, true),
            child: Text(strings.clearDataContinue),
          ),
        ],
      ),
    );
    if (first != true || !mounted) return;
    final second = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(strings.clearDataSecondConfirm),
        content: Text(strings.clearDataSecondConfirmBody),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(strings.actionCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(strings.clearDataConfirm),
          ),
        ],
      ),
    );
    if (second != true) return;
    await _run(() async {
      await _service.clear(target);
      await _reload();
      if (mounted) _showMessage(strings.clearDataSucceeded);
    });
  }

  Future<void> _run(Future<void> Function() operation) async {
    if (_busy) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await operation();
    } on Object catch (error) {
      if (mounted) setState(() => _error = error.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(strings.backupSettingsTitle)),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                Text(
                  strings.localBackupTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(strings.localBackupDescription),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(strings.automaticBackup),
                  subtitle: Text(strings.automaticBackupDescription),
                  value: _automaticEnabled,
                  onChanged: _busy
                      ? null
                      : (value) async {
                          await _run(() async {
                            await _service.setAutomaticBackupEnabled(value);
                            if (mounted) {
                              setState(() => _automaticEnabled = value);
                            }
                          });
                        },
                ),
                FilledButton.icon(
                  onPressed: _busy ? null : _createBackup,
                  icon: const Icon(Icons.backup_outlined),
                  label: Text(strings.createBackupNow),
                ),
                if (_error != null) ...<Widget>[
                  const SizedBox(height: 12),
                  Text(
                    _error!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                Text(
                  strings.recentBackups,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (_backups.isEmpty)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(strings.noBackups),
                  )
                else
                  for (final backup in _backups) _backupTile(backup),
                const Divider(height: 40),
                Text(
                  strings.privacyDataTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(strings.privacyDataDescription),
                _clearTile(
                  strings.clearConversations,
                  strings.clearConversationsDescription,
                  PrivacyClearTarget.conversations,
                ),
                _clearTile(
                  strings.clearAssistantActions,
                  strings.clearAssistantActionsDescription,
                  PrivacyClearTarget.assistantActions,
                ),
                _clearTile(
                  strings.clearAssistantConfiguration,
                  strings.clearAssistantConfigurationDescription,
                  PrivacyClearTarget.assistantConfiguration,
                ),
                _clearTile(
                  strings.clearWorkforce,
                  strings.clearWorkforceDescription,
                  PrivacyClearTarget.workforce,
                ),
                _clearTile(
                  strings.clearAllData,
                  strings.clearAllDataDescription,
                  PrivacyClearTarget.all,
                  destructive: true,
                ),
                OutlinedButton.icon(
                  onPressed: _busy
                      ? null
                      : () => _run(() async {
                          final output = await AppErrorReporter.instance
                              .exportRedactedBundle();
                          if (mounted) {
                            _showMessage(
                              '${strings.diagnosticsExported}: $output',
                            );
                          }
                        }),
                  icon: const Icon(Icons.bug_report_outlined),
                  label: Text(strings.exportDiagnostics),
                ),
                const SizedBox(height: 16),
              ],
            ),
    );
  }

  Widget _backupTile(LocalBackupEntry entry) {
    final strings = AppLocalizations.of(context);
    return Card(
      child: ListTile(
        leading: const Icon(Icons.inventory_2_outlined),
        title: Text(_formatTime(entry.manifest.createdAtUtc)),
        subtitle: Text(
          '${_formatRange(entry.manifest)}\n'
          '${strings.backupSchema(entry.manifest.schemaVersion)} · '
          '${strings.backupCredentialsExcluded}\n'
          '${path.basename(entry.filePath)}',
        ),
        isThreeLine: true,
        trailing: TextButton(
          onPressed: _busy ? null : () => _restore(entry),
          child: Text(strings.restoreBackupAction),
        ),
      ),
    );
  }

  Widget _clearTile(
    String title,
    String description,
    PrivacyClearTarget target, {
    bool destructive = false,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        destructive ? Icons.delete_forever_outlined : Icons.delete_outline,
        color: destructive ? Theme.of(context).colorScheme.error : null,
      ),
      title: Text(title),
      subtitle: Text(description),
      enabled: !_busy,
      onTap: () => _clear(target, title, description),
    );
  }

  String _formatTime(DateTime value) {
    return DateFormat('yyyy-MM-dd HH:mm').format(value.toLocal());
  }

  String _formatRange(BackupManifest manifest) {
    final strings = AppLocalizations.of(context);
    if (manifest.dataRangeStart == null || manifest.dataRangeEnd == null) {
      return strings.backupEmptyRange;
    }
    return '${manifest.dataRangeStart} — ${manifest.dataRangeEnd}';
  }

  void _showMessage(String message) {
    AppMessage.show(context, message);
  }
}
