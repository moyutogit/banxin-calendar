import 'package:banxin_calendar/app/localization/generated/app_localizations.dart';
import 'package:banxin_calendar/features/alarm/application/alarm_application_service.dart';
import 'package:banxin_calendar/features/alarm/application/alarm_providers.dart';
import 'package:banxin_calendar/features/alarm/domain/alarm_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlarmSettingsPage extends ConsumerStatefulWidget {
  const AlarmSettingsPage({super.key});

  @override
  ConsumerState<AlarmSettingsPage> createState() => _AlarmSettingsPageState();
}

class _AlarmSettingsPageState extends ConsumerState<AlarmSettingsPage> {
  late Future<AlarmSettingsView> _view;
  var _busy = false;

  AlarmApplicationService get _service =>
      ref.read(alarmApplicationServiceProvider);

  @override
  void initState() {
    super.initState();
    _view = _service.loadSettings();
  }

  void _reload() {
    setState(() => _view = _service.loadSettings());
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.alarmSettingsTitle),
        actions: <Widget>[
          IconButton(
            tooltip: strings.alarmSyncAction,
            onPressed: _busy ? null : _sync,
            icon: const Icon(Icons.sync),
          ),
        ],
      ),
      floatingActionButton: FutureBuilder<AlarmSettingsView>(
        future: _view,
        builder: (context, snapshot) => FloatingActionButton.extended(
          onPressed: snapshot.hasData && !_busy
              ? () => _edit(snapshot.data!)
              : null,
          icon: const Icon(Icons.add_alarm),
          label: Text(strings.alarmTemplateNew),
        ),
      ),
      body: FutureBuilder<AlarmSettingsView>(
        future: _view,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          final view = snapshot.requireData;
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
            children: <Widget>[
              _CapabilityCard(
                capability: view.capability,
                onRequest: _busy ? null : _requestCapability,
              ),
              const SizedBox(height: 12),
              Text(
                strings.alarmPlatformDisclaimer,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 20),
              if (view.templates.isEmpty)
                ListTile(
                  leading: const Icon(Icons.alarm_off),
                  title: Text(strings.alarmNoTemplates),
                )
              else
                ...view.templates.map(
                  (template) => Card(
                    child: ListTile(
                      leading: const Icon(Icons.alarm),
                      title: Text(template.name),
                      subtitle: Text(_templateSummary(strings, template)),
                      onTap: _busy ? null : () => _edit(view, template),
                      trailing: Switch(
                        value: template.enabled,
                        onChanged: _busy
                            ? null
                            : (enabled) => _setEnabled(template, enabled),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              Text(
                strings.alarmUpcoming,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              if (view.upcoming.isEmpty)
                ListTile(title: Text(strings.alarmNoUpcoming))
              else
                ...view.upcoming
                    .take(20)
                    .map(
                      (instance) => ListTile(
                        leading: Icon(
                          instance.status == AlarmInstanceStatus.failed
                              ? Icons.error_outline
                              : Icons.notifications_active_outlined,
                        ),
                        title: Text(
                          MaterialLocalizations.of(
                            context,
                          ).formatFullDate(instance.triggerAtUtc.toLocal()),
                        ),
                        subtitle: Text(
                          TimeOfDay.fromDateTime(
                            instance.triggerAtUtc.toLocal(),
                          ).format(context),
                        ),
                        trailing: Text(instance.status.name),
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }

  String _templateSummary(AppLocalizations strings, AlarmTemplate template) {
    if (template.mode == AlarmTemplateMode.fixedTime) {
      final time = TimeOfDay(
        hour: template.fixedMinute! ~/ 60,
        minute: template.fixedMinute! % 60,
      );
      return '${strings.alarmModeFixed} · ${time.format(context)}';
    }
    return '${strings.alarmModeRelative} · ${-template.offsetMinutes!} ${strings.minuteUnit}';
  }

  Future<void> _requestCapability() async {
    setState(() => _busy = true);
    await _service.requestCapability();
    if (mounted) {
      setState(() => _busy = false);
      _reload();
    }
  }

  Future<void> _sync() async {
    await _runSync(_service.syncRollingWindow());
  }

  Future<void> _setEnabled(AlarmTemplate template, bool enabled) async {
    await _runSync(_service.setTemplateEnabled(template.id, enabled: enabled));
  }

  Future<void> _runSync(Future<AlarmSyncResult> operation) async {
    final strings = AppLocalizations.of(context);
    setState(() => _busy = true);
    try {
      final result = await operation;
      if (!mounted) return;
      final text = result.succeeded
          ? strings.alarmSyncSuccess
          : strings.alarmSyncFailure;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
      if (result.adjustedWithin24Hours) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(strings.alarmAdjustedSoon)));
      }
    } finally {
      if (mounted) {
        setState(() => _busy = false);
        _reload();
      }
    }
  }

  Future<void> _edit(AlarmSettingsView view, [AlarmTemplate? template]) async {
    final draft = await showDialog<AlarmTemplateDraft>(
      context: context,
      builder: (context) => _AlarmTemplateDialog(
        shifts: view.shifts,
        initial: template == null ? null : _service.draftFor(template),
      ),
    );
    if (draft == null || !mounted) return;
    await _runSync(_service.saveTemplateAndSync(draft));
  }
}

class _CapabilityCard extends StatelessWidget {
  const _CapabilityCard({required this.capability, required this.onRequest});

  final AlarmCapability capability;
  final VoidCallback? onRequest;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final (icon, color, label) = switch (capability) {
      AlarmCapability.available => (
        Icons.check_circle_outline,
        Colors.green,
        strings.alarmCapabilityAvailable,
      ),
      AlarmCapability.permissionRequired => (
        Icons.warning_amber,
        Colors.orange,
        strings.alarmCapabilityPermissionRequired,
      ),
      AlarmCapability.unavailable => (
        Icons.error_outline,
        Colors.red,
        strings.alarmCapabilityUnavailable,
      ),
    };
    return Card(
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(label),
        trailing: capability == AlarmCapability.available
            ? null
            : TextButton(
                onPressed: onRequest,
                child: Text(strings.alarmPermissionAction),
              ),
      ),
    );
  }
}

class _AlarmTemplateDialog extends StatefulWidget {
  const _AlarmTemplateDialog({required this.shifts, this.initial});

  final List<StoredShiftTemplate> shifts;
  final AlarmTemplateDraft? initial;

  @override
  State<_AlarmTemplateDialog> createState() => _AlarmTemplateDialogState();
}

class _AlarmTemplateDialogState extends State<_AlarmTemplateDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _offset;
  late final TextEditingController _snooze;
  late final TextEditingController _maxSnooze;
  late AlarmTemplateMode _mode;
  late TimeOfDay _time;
  late bool _vibrate;
  late bool _volumeRamp;
  late Set<ShiftId> _shiftIds;

  @override
  void initState() {
    super.initState();
    final initial = widget.initial;
    _name = TextEditingController(text: initial?.name ?? '上班提醒');
    _mode = initial?.mode ?? AlarmTemplateMode.relativeToShiftStart;
    final minute = initial?.minute ?? -90;
    _time = TimeOfDay(
      hour: minute.clamp(0, 1439) ~/ 60,
      minute: minute.clamp(0, 1439) % 60,
    );
    _offset = TextEditingController(text: (-minute).clamp(0, 1440).toString());
    _snooze = TextEditingController(text: '${initial?.snoozeMinutes ?? 10}');
    _maxSnooze = TextEditingController(text: '${initial?.maxSnoozeCount ?? 3}');
    _vibrate = initial?.vibrate ?? true;
    _volumeRamp = initial?.volumeRamp ?? false;
    _shiftIds = Set<ShiftId>.of(
      initial?.shiftIds ??
          widget.shifts
              .where((shift) => shift.enabled)
              .map((shift) => shift.shift.id),
    );
  }

  @override
  void dispose() {
    _name.dispose();
    _offset.dispose();
    _snooze.dispose();
    _maxSnooze.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(
        widget.initial == null
            ? strings.alarmTemplateNew
            : strings.alarmTemplateEdit,
      ),
      content: SizedBox(
        width: 440,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: _name,
                  decoration: InputDecoration(
                    labelText: strings.alarmTemplateName,
                  ),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? strings.invalidFormMessage
                      : null,
                ),
                SegmentedButton<AlarmTemplateMode>(
                  segments: <ButtonSegment<AlarmTemplateMode>>[
                    ButtonSegment(
                      value: AlarmTemplateMode.relativeToShiftStart,
                      label: Text(strings.alarmModeRelative),
                    ),
                    ButtonSegment(
                      value: AlarmTemplateMode.fixedTime,
                      label: Text(strings.alarmModeFixed),
                    ),
                  ],
                  selected: <AlarmTemplateMode>{_mode},
                  onSelectionChanged: (value) =>
                      setState(() => _mode = value.single),
                ),
                if (_mode == AlarmTemplateMode.fixedTime)
                  ListTile(
                    title: Text(strings.alarmTime),
                    trailing: Text(_time.format(context)),
                    onTap: () async {
                      final selected = await showTimePicker(
                        context: context,
                        initialTime: _time,
                      );
                      if (selected != null) setState(() => _time = selected);
                    },
                  )
                else
                  TextFormField(
                    controller: _offset,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: strings.alarmOffsetMinutes,
                    ),
                    validator: _integerValidator,
                  ),
                const SizedBox(height: 8),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(strings.alarmLinkedShifts),
                ),
                ...widget.shifts.map(
                  (stored) => CheckboxListTile(
                    dense: true,
                    value: _shiftIds.contains(stored.shift.id),
                    title: Text(stored.shift.name),
                    onChanged: stored.enabled
                        ? (selected) => setState(() {
                            if (selected == true && _shiftIds.length < 5) {
                              _shiftIds.add(stored.shift.id);
                            } else if (selected == false) {
                              _shiftIds.remove(stored.shift.id);
                            }
                          })
                        : null,
                  ),
                ),
                SwitchListTile(
                  value: _vibrate,
                  title: Text(strings.alarmVibrate),
                  onChanged: (value) => setState(() => _vibrate = value),
                ),
                SwitchListTile(
                  value: _volumeRamp,
                  title: Text(strings.alarmVolumeRamp),
                  onChanged: (value) => setState(() => _volumeRamp = value),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: _snooze,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: strings.alarmSnoozeMinutes,
                        ),
                        validator: _integerValidator,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _maxSnooze,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: strings.alarmMaxSnooze,
                        ),
                        validator: _integerValidator,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        FilledButton(
          onPressed: _save,
          child: Text(MaterialLocalizations.of(context).saveButtonLabel),
        ),
      ],
    );
  }

  String? _integerValidator(String? value) => int.tryParse(value ?? '') == null
      ? AppLocalizations.of(context).invalidFormMessage
      : null;

  void _save() {
    if (!_formKey.currentState!.validate() || _shiftIds.isEmpty) return;
    final offset = int.parse(_offset.text);
    final snooze = int.parse(_snooze.text);
    final maxSnooze = int.parse(_maxSnooze.text);
    if (offset < 0 ||
        offset > 1440 ||
        snooze < 1 ||
        snooze > 60 ||
        maxSnooze < 0 ||
        maxSnooze > 10) {
      return;
    }
    Navigator.pop(
      context,
      AlarmTemplateDraft(
        id: widget.initial?.id,
        name: _name.text,
        mode: _mode,
        minute: _mode == AlarmTemplateMode.fixedTime
            ? _time.hour * 60 + _time.minute
            : -offset,
        vibrate: _vibrate,
        volumeRamp: _volumeRamp,
        snoozeMinutes: snooze,
        maxSnoozeCount: maxSnooze,
        enabled: widget.initial?.enabled ?? true,
        shiftIds: _shiftIds,
      ),
    );
  }
}
