import 'package:banxin_calendar/app/localization/generated/app_localizations.dart';
import 'package:banxin_calendar/core/presentation/app_message.dart';
import 'package:banxin_calendar/features/attendance/application/attendance_application_service.dart';
import 'package:banxin_calendar/features/attendance/domain/attendance_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';
import 'package:banxin_calendar/features/statistics/application/workforce_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AttendanceSection extends ConsumerStatefulWidget {
  const AttendanceSection({required this.date, super.key});

  final LocalDate date;

  @override
  ConsumerState<AttendanceSection> createState() => _AttendanceSectionState();
}

class _AttendanceSectionState extends ConsumerState<AttendanceSection> {
  late Future<AttendanceDayView> _view;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _view = ref.read(attendanceApplicationServiceProvider).loadDay(widget.date);
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return FutureBuilder<AttendanceDayView>(
      future: _view,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        final view = snapshot.requireData;
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        strings.attendanceTitle,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    IconButton(
                      tooltip: strings.addAttendance,
                      onPressed: () => _edit(),
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                if (view.segments.isEmpty)
                  Text(strings.noAttendanceRecords)
                else
                  ...view.segments.map(
                    (segment) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        segment.isComplete
                            ? Icons.check_circle_outline
                            : Icons.warning_amber,
                      ),
                      title: Text(
                        '${_time(segment.clockInUtc)} — ${_time(segment.clockOutUtc)}',
                      ),
                      subtitle: Text(
                        '${segment.rawPaidMinutes} ${strings.minuteUnit}'
                        '${segment.confirmed ? ' · ✓' : ''}',
                      ),
                      onTap: () => _edit(segment),
                      trailing: IconButton(
                        tooltip: strings.deleteRecord,
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => _delete(segment),
                      ),
                    ),
                  ),
                const Divider(),
                Text(
                  '${strings.rawWorkMinutes}: ${view.hours.rawActualMinutes}',
                ),
                Text(
                  '${strings.payableWorkMinutes}: ${view.hours.payableMinutes}',
                ),
                Text(
                  '${strings.normalWorkMinutes}: ${view.hours.normalMinutes}',
                ),
                Text(
                  '${strings.overtimeWorkMinutes}: ${view.hours.overtimeMinutes}',
                ),
                if (view.hours.missingPunch)
                  Text(
                    strings.missingPunch,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _time(DateTime? utc) => utc == null
      ? '--:--'
      : TimeOfDay.fromDateTime(utc.toLocal()).format(context);

  Future<void> _edit([AttendanceSegment? segment]) async {
    final draft = await showDialog<_AttendanceDraft>(
      context: context,
      builder: (context) =>
          _AttendanceDialog(date: widget.date, segment: segment),
    );
    if (draft == null) return;
    try {
      final result = await ref
          .read(attendanceApplicationServiceProvider)
          .saveManual(
            id: segment?.id,
            workDate: widget.date,
            clockInUtc: draft.clockInUtc,
            clockOutUtc: draft.clockOutUtc,
            unpaidBreakMinutes: draft.breakMinutes,
            editReason: draft.reason,
            note: draft.note,
            confirmed: draft.confirmed,
          );
      if (!mounted) return;
      if (result.requiresPayrollRecalculation) _showPayrollWarning();
      setState(_reload);
    } catch (error) {
      if (mounted) {
        AppMessage.show(context, error.toString(), type: AppMessageType.error);
      }
    }
  }

  Future<void> _delete(AttendanceSegment segment) async {
    final requiresRecalculation = await ref
        .read(attendanceApplicationServiceProvider)
        .delete(segment.id, widget.date);
    if (!mounted) return;
    if (requiresRecalculation) _showPayrollWarning();
    setState(_reload);
  }

  void _showPayrollWarning() {
    AppMessage.show(
      context,
      AppLocalizations.of(context).payrollRecalculationWarning,
      type: AppMessageType.warning,
    );
  }
}

final class _AttendanceDraft {
  const _AttendanceDraft({
    required this.clockInUtc,
    required this.clockOutUtc,
    required this.breakMinutes,
    required this.reason,
    required this.note,
    required this.confirmed,
  });

  final DateTime? clockInUtc;
  final DateTime? clockOutUtc;
  final int breakMinutes;
  final AttendanceEditReason reason;
  final String? note;
  final bool confirmed;
}

class _AttendanceDialog extends StatefulWidget {
  const _AttendanceDialog({required this.date, this.segment});

  final LocalDate date;
  final AttendanceSegment? segment;

  @override
  State<_AttendanceDialog> createState() => _AttendanceDialogState();
}

class _AttendanceDialogState extends State<_AttendanceDialog> {
  final _formKey = GlobalKey<FormState>();
  late TimeOfDay _clockIn;
  late TimeOfDay _clockOut;
  late bool _hasClockOut;
  late final TextEditingController _break;
  late final TextEditingController _note;
  late AttendanceEditReason _reason;
  late bool _confirmed;

  @override
  void initState() {
    super.initState();
    final now = TimeOfDay.now();
    _clockIn = widget.segment?.clockInUtc == null
        ? now
        : TimeOfDay.fromDateTime(widget.segment!.clockInUtc!.toLocal());
    _clockOut = widget.segment?.clockOutUtc == null
        ? now
        : TimeOfDay.fromDateTime(widget.segment!.clockOutUtc!.toLocal());
    _hasClockOut = widget.segment?.clockOutUtc != null;
    _break = TextEditingController(
      text: '${widget.segment?.unpaidBreakMinutes ?? 0}',
    );
    _note = TextEditingController(text: widget.segment?.note ?? '');
    _reason = widget.segment?.editReason ?? AttendanceEditReason.correction;
    _confirmed = widget.segment?.confirmed ?? false;
  }

  @override
  void dispose() {
    _break.dispose();
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(strings.addAttendance),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(strings.clockInTime),
                trailing: Text(_clockIn.format(context)),
                onTap: () => _pickTime(true),
              ),
              SwitchListTile(
                value: _hasClockOut,
                title: Text(strings.clockOutTime),
                onChanged: (value) => setState(() => _hasClockOut = value),
              ),
              if (_hasClockOut)
                ListTile(
                  title: Text(strings.clockOutTime),
                  trailing: Text(_clockOut.format(context)),
                  onTap: () => _pickTime(false),
                ),
              TextFormField(
                controller: _break,
                decoration: InputDecoration(labelText: strings.unpaidBreak),
                keyboardType: TextInputType.number,
                validator: (value) {
                  final number = int.tryParse(value ?? '');
                  return number != null && number >= 0
                      ? null
                      : strings.invalidFormMessage;
                },
              ),
              DropdownButtonFormField<AttendanceEditReason>(
                initialValue: _reason,
                decoration: InputDecoration(
                  labelText: strings.attendanceReason,
                ),
                items: AttendanceEditReason.values
                    .map(
                      (reason) => DropdownMenuItem(
                        value: reason,
                        child: Text(reason.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) => _reason = value ?? _reason,
              ),
              TextFormField(
                controller: _note,
                maxLength: 500,
                decoration: InputDecoration(labelText: strings.attendanceNote),
              ),
              CheckboxListTile(
                value: _confirmed,
                title: Text(strings.attendanceConfirmed),
                onChanged: (value) =>
                    setState(() => _confirmed = value ?? false),
              ),
            ],
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

  Future<void> _pickTime(bool clockIn) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: clockIn ? _clockIn : _clockOut,
    );
    if (selected != null) {
      setState(() {
        if (clockIn) {
          _clockIn = selected;
        } else {
          _clockOut = selected;
        }
      });
    }
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final startLocal = DateTime(
      widget.date.year,
      widget.date.month,
      widget.date.day,
      _clockIn.hour,
      _clockIn.minute,
    );
    DateTime? endLocal;
    if (_hasClockOut) {
      endLocal = DateTime(
        widget.date.year,
        widget.date.month,
        widget.date.day,
        _clockOut.hour,
        _clockOut.minute,
      );
      if (!endLocal.isAfter(startLocal)) {
        endLocal = endLocal.add(const Duration(days: 1));
      }
    }
    Navigator.pop(
      context,
      _AttendanceDraft(
        clockInUtc: startLocal.toUtc(),
        clockOutUtc: endLocal?.toUtc(),
        breakMinutes: int.parse(_break.text),
        reason: _reason,
        note: _note.text.trim().isEmpty ? null : _note.text.trim(),
        confirmed: _confirmed,
      ),
    );
  }
}
