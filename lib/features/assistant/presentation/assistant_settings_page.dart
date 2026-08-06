import 'dart:async';
import 'dart:convert';

import 'package:banxin_calendar/app/localization/generated/app_localizations.dart';
import 'package:banxin_calendar/core/presentation/app_message.dart';
import 'package:banxin_calendar/features/assistant/application/assistant_providers.dart';
import 'package:banxin_calendar/features/assistant/application/assistant_settings_service.dart';
import 'package:banxin_calendar/features/assistant/domain/assistant_entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AssistantSettingsPage extends ConsumerStatefulWidget {
  const AssistantSettingsPage({super.key});

  @override
  ConsumerState<AssistantSettingsPage> createState() =>
      _AssistantSettingsPageState();
}

class _AssistantSettingsPageState extends ConsumerState<AssistantSettingsPage> {
  final _formKey = GlobalKey<FormState>();
  final _baseUrl = TextEditingController(text: 'https://api.example.com/');
  final _endpoint = TextEditingController(text: 'v1/chat/completions');
  final _model = TextEditingController();
  final _apiKey = TextEditingController();
  final _headers = TextEditingController(text: '{}');
  final _timeout = TextEditingController(text: '30');
  final _maxTokens = TextEditingController(text: '1024');
  final _assistantName = TextEditingController(text: '小班');
  AiProviderType _providerType = AiProviderType.openAiCompatible;
  bool _stream = true;
  bool _obscureKey = true;
  AssistantPersonaPreset _preset = AssistantPersonaPreset.gentle;
  AssistantReplyLength _replyLength = AssistantReplyLength.medium;
  AssistantDataScopes _scopes = const AssistantDataScopes();
  AiProviderConfig? _existing;
  AssistantPersona? _persona;
  var _busy = false;
  AiConnectionStatus _connection = AiConnectionStatus.notTested;

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  @override
  void dispose() {
    _baseUrl.dispose();
    _endpoint.dispose();
    _model.dispose();
    _apiKey.dispose();
    _headers.dispose();
    _timeout.dispose();
    _maxTokens.dispose();
    _assistantName.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final view = await ref.read(assistantSettingsServiceProvider).load();
    if (!mounted) return;
    setState(() {
      _existing = view.config;
      _persona = view.persona;
      if (view.config case final config?) {
        _providerType = config.providerType;
        _baseUrl.text = config.baseUrl.toString();
        _endpoint.text = config.endpointPath;
        _model.text = config.modelName;
        _timeout.text = '${config.timeoutSeconds}';
        _maxTokens.text = '${config.maxOutputTokens}';
        _stream = config.streamEnabled;
        _connection = config.connectionStatus;
      }
      _assistantName.text = view.persona.displayName;
      _preset = view.persona.preset;
      _replyLength = view.persona.replyLength;
      _scopes = view.persona.scopes;
    });
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(strings.assistantConfigureTitle)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            SegmentedButton<AiProviderType>(
              segments: const <ButtonSegment<AiProviderType>>[
                ButtonSegment(
                  value: AiProviderType.openAiCompatible,
                  label: Text('OpenAI Compatible'),
                ),
                ButtonSegment(
                  value: AiProviderType.customRest,
                  label: Text('Custom REST'),
                ),
              ],
              selected: <AiProviderType>{_providerType},
              onSelectionChanged: (value) =>
                  setState(() => _providerType = value.single),
            ),
            TextFormField(
              controller: _baseUrl,
              decoration: InputDecoration(labelText: strings.assistantBaseUrl),
              keyboardType: TextInputType.url,
              validator: _required,
            ),
            TextFormField(
              controller: _endpoint,
              decoration: InputDecoration(
                labelText: strings.assistantEndpointPath,
              ),
              validator: _required,
            ),
            TextFormField(
              controller: _model,
              decoration: InputDecoration(
                labelText: strings.assistantModelName,
              ),
              validator: _required,
            ),
            TextFormField(
              controller: _apiKey,
              obscureText: _obscureKey,
              decoration: InputDecoration(
                labelText: strings.assistantApiKey,
                hintText: _existing == null ? null : '••••••••',
                suffixIcon: IconButton(
                  onPressed: () => setState(() => _obscureKey = !_obscureKey),
                  icon: Icon(
                    _obscureKey
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                ),
              ),
              validator: (value) =>
                  _existing == null && (value == null || value.isEmpty)
                  ? strings.invalidFormMessage
                  : null,
            ),
            TextFormField(
              controller: _headers,
              decoration: InputDecoration(
                labelText: strings.assistantCustomHeaders,
              ),
              maxLines: 3,
              validator: (value) {
                try {
                  final decoded = jsonDecode(value ?? '{}');
                  return decoded is Map<String, Object?>
                      ? null
                      : strings.invalidFormMessage;
                } catch (_) {
                  return strings.invalidFormMessage;
                }
              },
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    controller: _timeout,
                    decoration: InputDecoration(
                      labelText: strings.assistantTimeout,
                    ),
                    keyboardType: TextInputType.number,
                    validator: _integer,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _maxTokens,
                    decoration: InputDecoration(
                      labelText: strings.assistantMaxTokens,
                    ),
                    keyboardType: TextInputType.number,
                    validator: _integer,
                  ),
                ),
              ],
            ),
            SwitchListTile(
              value: _stream,
              title: Text(strings.assistantStream),
              onChanged: (value) => setState(() => _stream = value),
            ),
            ListTile(
              leading: const Icon(Icons.cloud_done_outlined),
              title: Text(_connectionLabel(strings, _connection)),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlinedButton(
                    onPressed: _busy || _existing == null
                        ? null
                        : _testConnection,
                    child: Text(strings.assistantTestConnection),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: _busy ? null : _saveProvider,
                    child: Text(
                      MaterialLocalizations.of(context).saveButtonLabel,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            Text(
              strings.assistantPersonaTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextFormField(
              controller: _assistantName,
              decoration: InputDecoration(labelText: strings.assistantName),
              validator: _required,
            ),
            DropdownButtonFormField<AssistantPersonaPreset>(
              initialValue: _preset,
              items: AssistantPersonaPreset.values
                  .map(
                    (preset) => DropdownMenuItem(
                      value: preset,
                      child: Text(_presetLabel(strings, preset)),
                    ),
                  )
                  .toList(),
              onChanged: (value) => setState(() => _preset = value ?? _preset),
            ),
            DropdownButtonFormField<AssistantReplyLength>(
              initialValue: _replyLength,
              decoration: InputDecoration(
                labelText: strings.assistantReplyLength,
              ),
              items: AssistantReplyLength.values
                  .map(
                    (length) => DropdownMenuItem(
                      value: length,
                      child: Text(length.name),
                    ),
                  )
                  .toList(),
              onChanged: (value) =>
                  setState(() => _replyLength = value ?? _replyLength),
            ),
            _scopeTile(
              strings.assistantScopeSchedule,
              _scopes.scheduleRead,
              (value) => _updateScopes(schedule: value),
            ),
            _scopeTile(
              strings.assistantScopeAttendance,
              _scopes.attendanceRead,
              (value) => _updateScopes(attendance: value),
            ),
            _scopeTile(
              strings.assistantScopeWage,
              _scopes.wageRead,
              (value) => _updateScopes(wage: value),
            ),
            _scopeTile(
              strings.assistantScopeAlarm,
              _scopes.alarmRead,
              (value) => _updateScopes(alarm: value),
            ),
            _scopeTile(
              strings.assistantScopeNotes,
              _scopes.notesRead,
              (value) => _updateScopes(notes: value),
            ),
            FilledButton.icon(
              onPressed: _busy ? null : _savePersona,
              icon: const Icon(Icons.face_outlined),
              label: Text(MaterialLocalizations.of(context).saveButtonLabel),
            ),
          ],
        ),
      ),
    );
  }

  Widget _scopeTile(String title, bool value, ValueChanged<bool> changed) =>
      SwitchListTile(value: value, title: Text(title), onChanged: changed);

  void _updateScopes({
    bool? schedule,
    bool? attendance,
    bool? wage,
    bool? alarm,
    bool? notes,
  }) {
    setState(() {
      _scopes = AssistantDataScopes(
        scheduleRead: schedule ?? _scopes.scheduleRead,
        attendanceRead: attendance ?? _scopes.attendanceRead,
        wageRead: wage ?? _scopes.wageRead,
        alarmRead: alarm ?? _scopes.alarmRead,
        notesRead: notes ?? _scopes.notesRead,
      );
    });
  }

  String? _required(String? value) => value == null || value.trim().isEmpty
      ? AppLocalizations.of(context).invalidFormMessage
      : null;

  String? _integer(String? value) => int.tryParse(value ?? '') == null
      ? AppLocalizations.of(context).invalidFormMessage
      : null;

  Future<void> _saveProvider() async {
    if (!_formKey.currentState!.validate()) return;
    var confirmHostChange = false;
    final newHost = Uri.tryParse(_baseUrl.text)?.host;
    if (_existing != null && newHost != _existing!.baseUrl.host) {
      confirmHostChange =
          await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                AppLocalizations.of(context).assistantHostChangeWarning,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(
                    MaterialLocalizations.of(context).cancelButtonLabel,
                  ),
                ),
                FilledButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text(MaterialLocalizations.of(context).okButtonLabel),
                ),
              ],
            ),
          ) ??
          false;
      if (!confirmHostChange) return;
    }
    setState(() => _busy = true);
    try {
      final rawHeaders = jsonDecode(_headers.text) as Map<String, Object?>;
      _existing = await ref
          .read(assistantSettingsServiceProvider)
          .saveProvider(
            AiProviderConfigDraft(
              providerType: _providerType,
              baseUrl: _baseUrl.text,
              endpointPath: _endpoint.text,
              modelName: _model.text,
              apiKey: _apiKey.text.isEmpty ? null : _apiKey.text,
              customHeaders: rawHeaders.map(
                (key, value) => MapEntry(key, value.toString()),
              ),
              timeoutSeconds: int.parse(_timeout.text),
              maxOutputTokens: int.parse(_maxTokens.text),
              streamEnabled: _stream,
            ),
            confirmHostChange: confirmHostChange,
          );
      _apiKey.clear();
      if (mounted) {
        AppMessage.show(
          context,
          AppLocalizations.of(context).assistantSettingsSaved,
          type: AppMessageType.success,
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _testConnection() async {
    setState(() => _busy = true);
    final result = await ref
        .read(assistantSettingsServiceProvider)
        .testConnection();
    if (mounted) {
      setState(() {
        _busy = false;
        _connection = result.status;
      });
    }
  }

  Future<void> _savePersona() async {
    setState(() => _busy = true);
    final current = _persona;
    await ref
        .read(assistantSettingsServiceProvider)
        .savePersona(
          AssistantPersona(
            id: current?.id ?? 'local-persona',
            displayName: _assistantName.text.trim(),
            preset: _preset,
            customInstruction: current?.customInstruction,
            replyLength: _replyLength,
            initiativeLevel: current?.initiativeLevel ?? 1,
            emojiLevel: current?.emojiLevel ?? 1,
            avatarAssetId: current?.avatarAssetId ?? 'default_gentle',
            scopes: _scopes,
          ),
        );
    if (mounted) setState(() => _busy = false);
  }

  String _presetLabel(
    AppLocalizations strings,
    AssistantPersonaPreset preset,
  ) => switch (preset) {
    AssistantPersonaPreset.gentle => strings.assistantPersonaGentle,
    AssistantPersonaPreset.professional => strings.assistantPersonaProfessional,
    AssistantPersonaPreset.lively => strings.assistantPersonaLively,
  };

  String _connectionLabel(
    AppLocalizations strings,
    AiConnectionStatus status,
  ) => switch (status) {
    AiConnectionStatus.connected => strings.assistantConnectionConnected,
    AiConnectionStatus.authenticationFailure => strings.assistantConnectionAuth,
    AiConnectionStatus.modelNotFound => strings.assistantConnectionModel,
    AiConnectionStatus.rateLimited => strings.assistantConnectionRate,
    AiConnectionStatus.insufficientBalance =>
      strings.assistantConnectionBalance,
    AiConnectionStatus.tlsFailure => strings.assistantConnectionTls,
    AiConnectionStatus.timeout => strings.assistantConnectionTimeout,
    AiConnectionStatus.incompatibleResponse =>
      strings.assistantConnectionResponse,
    AiConnectionStatus.networkFailure ||
    AiConnectionStatus.invalidUrl => strings.assistantConnectionNetwork,
    AiConnectionStatus.notTested => strings.assistantConnectionNotTested,
  };
}
