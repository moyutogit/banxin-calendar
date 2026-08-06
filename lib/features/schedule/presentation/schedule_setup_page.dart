import 'package:banxin_calendar/app/localization/generated/app_localizations.dart';
import 'package:banxin_calendar/core/presentation/app_message.dart';
import 'package:banxin_calendar/features/schedule/application/schedule_application_service.dart';
import 'package:banxin_calendar/features/schedule/application/schedule_providers.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';
import 'package:banxin_calendar/features/schedule/presentation/schedule_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ScheduleSetupPage extends ConsumerStatefulWidget {
  const ScheduleSetupPage({this.initialDraft, super.key});

  final ScheduleSetupDraft? initialDraft;

  @override
  ConsumerState<ScheduleSetupPage> createState() => _ScheduleSetupPageState();
}

class _ScheduleSetupPageState extends ConsumerState<ScheduleSetupPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _ruleNameController;
  late final TextEditingController _shiftNameController;
  late final TextEditingController _shiftShortNameController;
  late final TextEditingController _breakController;
  late final TextEditingController _cycleController;
  late SchedulePresetMode _mode;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  late LocalDate _anchorDate;
  late bool _crossDay;
  var _currentStep = 0;
  var _saving = false;
  var _defaultsSeeded = false;
  ScheduleSetupPreview? _preview;

  @override
  void initState() {
    super.initState();
    final initial = widget.initialDraft;
    _mode = initial?.mode ?? SchedulePresetMode.fiveDay;
    _ruleNameController = TextEditingController(text: initial?.ruleName ?? '');
    _shiftNameController = TextEditingController(
      text: initial?.shiftName ?? '',
    );
    _shiftShortNameController = TextEditingController(
      text: initial?.shiftShortName ?? '',
    );
    _breakController = TextEditingController(
      text: '${initial?.unpaidBreakMinutes ?? 60}',
    );
    _cycleController = TextEditingController(
      text: initial == null
          ? ''
          : initial.customCycleWorkPattern
                .map((isWorkday) => isWorkday ? '工' : '休')
                .join(','),
    );
    _startTime = _fromMinute(initial?.startMinute ?? 9 * 60);
    _endTime = _fromMinute(initial?.endMinute ?? 18 * 60);
    _crossDay = initial?.crossDay ?? false;
    _anchorDate = initial?.anchorDate ?? _today();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.initialDraft == null && !_defaultsSeeded) {
      final strings = AppLocalizations.of(context);
      _ruleNameController.text = strings.defaultScheduleName;
      _shiftNameController.text = strings.defaultShiftName;
      _shiftShortNameController.text = strings.defaultShiftShortName;
      _cycleController.text = strings.defaultCyclePattern;
      _defaultsSeeded = true;
    }
  }

  @override
  void dispose() {
    _ruleNameController.dispose();
    _shiftNameController.dispose();
    _shiftShortNameController.dispose();
    _breakController.dispose();
    _cycleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.initialDraft == null
              ? strings.scheduleSetupTitle
              : strings.editScheduleRuleTitle,
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Stepper(
            currentStep: _currentStep,
            onStepTapped: _saving
                ? null
                : (step) => setState(() => _currentStep = step),
            controlsBuilder: _buildControls,
            steps: <Step>[
              Step(
                title: Text(strings.setupStepMode),
                isActive: _currentStep >= 0,
                content: DropdownButtonFormField<SchedulePresetMode>(
                  initialValue: _mode,
                  decoration: InputDecoration(labelText: strings.setupStepMode),
                  items: SchedulePresetMode.values
                      .map(
                        (mode) => DropdownMenuItem<SchedulePresetMode>(
                          value: mode,
                          child: Text(strings.scheduleModeLabel(mode)),
                        ),
                      )
                      .toList(growable: false),
                  onChanged: _saving
                      ? null
                      : (value) => setState(() => _mode = value ?? _mode),
                ),
              ),
              Step(
                title: Text(strings.setupStepShift),
                isActive: _currentStep >= 1,
                content: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _ruleNameController,
                      decoration: InputDecoration(
                        labelText: strings.ruleNameLabel,
                      ),
                      validator: _requiredValidator,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _shiftNameController,
                      decoration: InputDecoration(
                        labelText: strings.shiftNameLabel,
                      ),
                      maxLength: 12,
                      validator: _requiredValidator,
                    ),
                    TextFormField(
                      controller: _shiftShortNameController,
                      decoration: InputDecoration(
                        labelText: strings.shiftShortNameLabel,
                      ),
                      maxLength: 3,
                      validator: _requiredValidator,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: _TimeButton(
                            label: strings.shiftStartLabel,
                            value: _startTime,
                            onPressed: () => _pickTime(isStart: true),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _TimeButton(
                            label: strings.shiftEndLabel,
                            value: _endTime,
                            onPressed: () => _pickTime(isStart: false),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _breakController,
                      decoration: InputDecoration(
                        labelText: strings.unpaidBreakLabel,
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        final minutes = int.tryParse(value ?? '');
                        return minutes == null || minutes < 0 || minutes > 480
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
              Step(
                title: Text(strings.setupStepCycle),
                isActive: _currentStep >= 2,
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    OutlinedButton.icon(
                      onPressed: _pickAnchorDate,
                      icon: const Icon(Icons.event_outlined),
                      label: Text('${strings.anchorDateLabel}: $_anchorDate'),
                    ),
                    if (_mode == SchedulePresetMode.customCycle) ...<Widget>[
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _cycleController,
                        decoration: InputDecoration(
                          labelText: strings.customCycleLabel,
                          helperText: strings.customCycleHint,
                        ),
                        validator: (value) {
                          try {
                            _parseCycle(value ?? '');
                            return null;
                          } on FormatException {
                            return strings.invalidFormMessage;
                          }
                        },
                      ),
                    ],
                  ],
                ),
              ),
              Step(
                title: Text(strings.setupStepPreview),
                isActive: _currentStep >= 3,
                content: _buildPreview(strings),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControls(BuildContext context, ControlsDetails details) {
    final strings = AppLocalizations.of(context);
    final isLast = _currentStep == 3;
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        children: <Widget>[
          FilledButton(
            onPressed: _saving ? null : _continue,
            child: _saving
                ? const SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(isLast ? strings.actionSave : strings.actionContinue),
          ),
          if (_currentStep > 0) ...<Widget>[
            const SizedBox(width: 8),
            TextButton(
              onPressed: _saving ? null : () => setState(() => _currentStep--),
              child: Text(strings.actionBack),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPreview(AppLocalizations strings) {
    final preview = _preview;
    if (preview == null) {
      return Text(strings.setupPreviewTitle);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          strings.setupPreviewTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        for (final day in preview.days)
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(child: Text('${day.date.day}')),
            title: Text(strings.dayStatusLabel(day.status)),
            subtitle: Text(day.shift?.name ?? strings.noShiftLabel),
            trailing: Text('${day.plannedPaidMinutes} ${strings.minuteUnit}'),
          ),
      ],
    );
  }

  Future<void> _continue() async {
    final strings = AppLocalizations.of(context);
    if (!(_formKey.currentState?.validate() ?? false)) {
      AppMessage.show(
        context,
        strings.invalidFormMessage,
        type: AppMessageType.error,
      );
      return;
    }
    if (_currentStep < 2) {
      setState(() => _currentStep++);
      return;
    }
    try {
      final service = ref.read(scheduleApplicationServiceProvider);
      if (_currentStep == 2) {
        final preview = await service.previewSetup(
          _draft(),
          previewStart: _today(),
        );
        if (!mounted) return;
        setState(() {
          _preview = preview;
          _currentStep = 3;
        });
        return;
      }
      setState(() => _saving = true);
      await service.saveSetup(_draft());
      if (!mounted) return;
      AppMessage.show(
        context,
        strings.setupSavedMessage,
        type: AppMessageType.success,
      );
      context.pop(true);
    } on Object {
      if (!mounted) return;
      setState(() => _saving = false);
      AppMessage.show(
        context,
        strings.invalidFormMessage,
        type: AppMessageType.error,
      );
    }
  }

  ScheduleSetupDraft _draft() {
    return ScheduleSetupDraft(
      mode: _mode,
      ruleName: _ruleNameController.text.trim(),
      shiftName: _shiftNameController.text.trim(),
      shiftShortName: _shiftShortNameController.text.trim(),
      startMinute: _toMinute(_startTime),
      endMinute: _toMinute(_endTime),
      crossDay: _crossDay,
      unpaidBreakMinutes: int.parse(_breakController.text),
      anchorDate: _anchorDate,
      customCycleWorkPattern: _parseCycle(_cycleController.text),
      shiftId: widget.initialDraft?.shiftId,
      ruleId: widget.initialDraft?.ruleId,
    );
  }

  List<bool> _parseCycle(String source) {
    final tokens = source
        .split(RegExp(r'[,，\s]+'))
        .where((token) => token.isNotEmpty)
        .toList(growable: false);
    if (tokens.isEmpty || tokens.length > 31) {
      throw const FormatException('Expected 1-31 cycle items.');
    }
    return tokens
        .map((token) {
          final normalized = token.toLowerCase();
          if (<String>{'工', '工作', '夜', 'work', 'w', '1'}.contains(normalized)) {
            return true;
          }
          if (<String>{'休', '休息', 'rest', 'r', '0'}.contains(normalized)) {
            return false;
          }
          throw FormatException('Unsupported cycle item: $token');
        })
        .toList(growable: false);
  }

  Future<void> _pickTime({required bool isStart}) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: isStart ? _startTime : _endTime,
    );
    if (selected == null || !mounted) return;
    setState(() {
      if (isStart) {
        _startTime = selected;
      } else {
        _endTime = selected;
      }
    });
  }

  Future<void> _pickAnchorDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: DateTime(
        _anchorDate.year,
        _anchorDate.month,
        _anchorDate.day,
      ),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selected == null || !mounted) return;
    setState(() {
      _anchorDate = LocalDate(selected.year, selected.month, selected.day);
    });
  }

  String? _requiredValidator(String? value) {
    return value == null || value.trim().isEmpty
        ? AppLocalizations.of(context).invalidFormMessage
        : null;
  }

  LocalDate _today() {
    final now = DateTime.now();
    return LocalDate(now.year, now.month, now.day);
  }

  TimeOfDay _fromMinute(int minute) {
    return TimeOfDay(hour: minute ~/ 60, minute: minute % 60);
  }

  int _toMinute(TimeOfDay time) => time.hour * 60 + time.minute;
}

final class _TimeButton extends StatelessWidget {
  const _TimeButton({
    required this.label,
    required this.value,
    required this.onPressed,
  });

  final String label;
  final TimeOfDay value;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Column(
        children: <Widget>[Text(label), Text(value.format(context))],
      ),
    );
  }
}
