import 'package:banxin_calendar/app/localization/generated/app_localizations.dart';
import 'package:banxin_calendar/app/theme/app_theme.dart';
import 'package:banxin_calendar/core/presentation/app_message.dart';
import 'package:banxin_calendar/features/schedule/application/schedule_application_service.dart';
import 'package:banxin_calendar/features/schedule/application/schedule_providers.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShiftTemplatesPage extends ConsumerStatefulWidget {
  const ShiftTemplatesPage({super.key});

  @override
  ConsumerState<ShiftTemplatesPage> createState() => _ShiftTemplatesPageState();
}

class _ShiftTemplatesPageState extends ConsumerState<ShiftTemplatesPage> {
  late Future<ScheduleRulesView> _future;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(strings.shiftTemplatesTitle)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _edit(null),
        icon: const Icon(Icons.add),
        label: Text(strings.newShiftTemplate),
      ),
      body: SafeArea(
        child: FutureBuilder<ScheduleRulesView>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: FilledButton(
                  onPressed: () => setState(_reload),
                  child: Text(strings.actionRetry),
                ),
              );
            }
            final shifts = snapshot.requireData.shifts;
            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.md,
                96,
              ),
              itemCount: shifts.length,
              separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, index) {
                final stored = shifts[index];
                return Card(
                  child: ListTile(
                    onTap: () => _edit(stored.shift),
                    leading: CircleAvatar(
                      backgroundColor: Color(stored.shift.colorArgb),
                      foregroundColor: Colors.white,
                      child: Text(stored.shift.shortName),
                    ),
                    title: Text(stored.shift.name),
                    subtitle: Text(
                      '${_formatMinute(stored.shift.startMinute)}–'
                      '${_formatMinute(stored.shift.endMinute)} · '
                      '${stored.shift.plannedPaidMinutes} '
                      '${strings.minuteUnit}',
                    ),
                    trailing: Switch(
                      value: stored.enabled,
                      onChanged: (enabled) => _setEnabled(stored, enabled),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _reload() {
    _future = ref.read(scheduleApplicationServiceProvider).loadRulesView();
  }

  Future<void> _edit(ShiftSnapshot? shift) async {
    final service = ref.read(scheduleApplicationServiceProvider);
    final initial = shift == null ? null : service.draftForShift(shift);
    final draft = await showDialog<ShiftTemplateDraft>(
      context: context,
      builder: (_) => _ShiftEditorDialog(initial: initial),
    );
    if (draft == null) return;
    await service.saveShiftDraft(draft);
    if (mounted) setState(_reload);
  }

  Future<void> _setEnabled(StoredShiftTemplate stored, bool enabled) async {
    final strings = AppLocalizations.of(context);
    try {
      await ref
          .read(scheduleApplicationServiceProvider)
          .setShiftEnabled(stored.shift.id, enabled: enabled);
      if (mounted) setState(_reload);
    } on StateError {
      if (!mounted) return;
      AppMessage.show(
        context,
        strings.shiftDisableBlocked,
        type: AppMessageType.warning,
      );
    }
  }

  String _formatMinute(int minute) {
    return '${(minute ~/ 60).toString().padLeft(2, '0')}:'
        '${(minute % 60).toString().padLeft(2, '0')}';
  }
}

final class _ShiftEditorDialog extends StatefulWidget {
  const _ShiftEditorDialog({this.initial});

  final ShiftTemplateDraft? initial;

  @override
  State<_ShiftEditorDialog> createState() => _ShiftEditorDialogState();
}

class _ShiftEditorDialogState extends State<_ShiftEditorDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _shortNameController;
  late final TextEditingController _breakController;
  late TimeOfDay _start;
  late TimeOfDay _end;
  late bool _crossDay;

  @override
  void initState() {
    super.initState();
    final initial = widget.initial;
    _nameController = TextEditingController(text: initial?.name ?? '');
    _shortNameController = TextEditingController(
      text: initial?.shortName ?? '',
    );
    _breakController = TextEditingController(
      text: '${initial?.unpaidBreakMinutes ?? 60}',
    );
    _start = _time(initial?.startMinute ?? 9 * 60);
    _end = _time(initial?.endMinute ?? 18 * 60);
    _crossDay = initial?.crossDay ?? false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _shortNameController.dispose();
    _breakController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(
        widget.initial == null ? strings.newShiftTemplate : strings.actionEdit,
      ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                maxLength: 12,
                decoration: InputDecoration(labelText: strings.shiftNameLabel),
                validator: _required,
              ),
              TextFormField(
                controller: _shortNameController,
                maxLength: 3,
                decoration: InputDecoration(
                  labelText: strings.shiftShortNameLabel,
                ),
                validator: _required,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextButton(
                      onPressed: () => _pickTime(true),
                      child: Text(
                        '${strings.shiftStartLabel}\n${_start.format(context)}',
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () => _pickTime(false),
                      child: Text(
                        '${strings.shiftEndLabel}\n${_end.format(context)}',
                      ),
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _breakController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: strings.unpaidBreakLabel,
                ),
                validator: (value) {
                  final parsed = int.tryParse(value ?? '');
                  return parsed == null || parsed < 0 || parsed > 480
                      ? strings.invalidFormMessage
                      : null;
                },
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(strings.crossDayLabel),
                value: _crossDay,
                onChanged: (value) => setState(() => _crossDay = value),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(strings.actionCancel),
        ),
        FilledButton(onPressed: _save, child: Text(strings.actionSave)),
      ],
    );
  }

  Future<void> _pickTime(bool start) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: start ? _start : _end,
    );
    if (selected == null || !mounted) return;
    setState(() {
      if (start) {
        _start = selected;
      } else {
        _end = selected;
      }
    });
  }

  void _save() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    Navigator.pop(
      context,
      ShiftTemplateDraft(
        id: widget.initial?.id,
        name: _nameController.text.trim(),
        shortName: _shortNameController.text.trim(),
        startMinute: _start.hour * 60 + _start.minute,
        endMinute: _end.hour * 60 + _end.minute,
        crossDay: _crossDay,
        unpaidBreakMinutes: int.parse(_breakController.text),
        colorArgb: widget.initial?.colorArgb ?? 0xFF3B82F6,
      ),
    );
  }

  String? _required(String? value) {
    return value == null || value.trim().isEmpty
        ? AppLocalizations.of(context).invalidFormMessage
        : null;
  }

  TimeOfDay _time(int minute) {
    return TimeOfDay(hour: minute ~/ 60, minute: minute % 60);
  }
}
