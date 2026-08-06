import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:banxin_calendar/core/ids/stable_id_generator.dart';
import 'package:banxin_calendar/core/secure_storage/secure_value_store.dart';
import 'package:banxin_calendar/core/time/app_clock.dart';
import 'package:banxin_calendar/features/assistant/domain/assistant_action_unit_of_work.dart';
import 'package:banxin_calendar/features/assistant/domain/assistant_entities.dart';
import 'package:banxin_calendar/features/assistant/domain/assistant_repository.dart';
import 'package:banxin_calendar/features/schedule/application/schedule_application_service.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_entities.dart';
import 'package:banxin_calendar/features/schedule/domain/schedule_repository.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';
import 'package:crypto/crypto.dart';

final class AssistantActionException implements Exception {
  const AssistantActionException(this.code);

  final String code;

  @override
  String toString() => 'AssistantActionException($code)';
}

final class AssistantActionGateway {
  AssistantActionGateway(
    this._assistantRepository,
    this._unitOfWork,
    this._scheduleRepository,
    this._scheduleService,
    this._secureStore, {
    this._clock = const SystemAppClock(),
    StableIdGenerator? idGenerator,
    Random? secureRandom,
  }) : _idGenerator = idGenerator ?? UuidV4Generator(),
       _secureRandom = secureRandom ?? Random.secure();

  static const String _deviceSecretReference = 'assistant_device_hmac_key_v1';

  final AssistantRepository _assistantRepository;
  final AssistantActionUnitOfWork _unitOfWork;
  final ScheduleRepository _scheduleRepository;
  final ScheduleApplicationService _scheduleService;
  final SecureValueStore _secureStore;
  final AppClock _clock;
  final StableIdGenerator _idGenerator;
  final Random _secureRandom;

  Future<AiActionProposal> proposeScheduleChange({
    required String conversationId,
    required Map<String, Object?> arguments,
  }) async {
    final payload = _validateSchedulePayload(arguments);
    final shifts = (await _scheduleService.loadRulesView()).shifts;
    final shift = payload.shiftId == null
        ? null
        : shifts
              .where((stored) => stored.shift.id == payload.shiftId)
              .map((stored) => stored.shift)
              .firstOrNull;
    if (payload.status == 'work' && shift == null) {
      throw const AssistantActionException('invalid_shift');
    }
    final dates = payload.range.dates.toList();
    final status = payload.status == 'rest' ? DayStatus.rest : DayStatus.work;
    final preview = await _scheduleService.previewOverride(
      dates: dates,
      status: status,
      shift: shift,
    );
    final calendar = await _scheduleService.loadCalendar(payload.range);
    final before = <String, Object?>{
      'days': <Object?>[
        for (final day in calendar.days)
          <String, Object?>{
            'date': day.date.toString(),
            'status': day.status.name,
            'shiftId': day.shift?.id.value,
            'source': day.source.name,
          },
      ],
    };
    final validated = _encodePayload(payload);
    final token = _randomToken();
    final now = _clock.nowUtc();
    final action = AiAction(
      id: _idGenerator.generate(),
      conversationId: conversationId,
      actionType: 'schedule_change',
      toolName: 'propose_schedule_change',
      proposedPayloadJson: jsonEncode(arguments),
      validatedPayloadJson: jsonEncode(validated),
      beforeSnapshotJson: jsonEncode(before),
      afterSnapshotJson: null,
      status: AiActionStatus.proposed,
      confirmationTokenHash: await _tokenHash(token),
      idempotencyKey: _idGenerator.generate(),
      inputVersion: await _scheduleRepository.loadInputVersion(),
      expiresAtUtc: now.add(const Duration(minutes: 10)),
      createdAtUtc: now,
    );
    await _assistantRepository.saveAction(action);
    return AiActionProposal(
      action: action,
      confirmationToken: token,
      summary:
          '${dates.length} date(s): ${preview.originalStatusCounts.map((key, value) => MapEntry(key.name, value))} → ${status.name}',
    );
  }

  Future<AiAction> confirmScheduleChange({
    required String actionId,
    required String confirmationToken,
  }) async {
    final action = await _requiredAction(actionId);
    if (action.status != AiActionStatus.proposed) {
      throw const AssistantActionException('confirmation_used_or_invalid');
    }
    final now = _clock.nowUtc();
    if (!now.isBefore(action.expiresAtUtc)) {
      await _assistantRepository.saveAction(
        _copy(action, status: AiActionStatus.expired, errorCode: 'expired'),
      );
      throw const AssistantActionException('confirmation_expired');
    }
    if (!_constantTimeEquals(
      action.confirmationTokenHash,
      await _tokenHash(confirmationToken),
    )) {
      throw const AssistantActionException('confirmation_invalid');
    }
    if (await _scheduleRepository.loadInputVersion() != action.inputVersion) {
      await _assistantRepository.saveAction(
        _copy(
          action,
          status: AiActionStatus.invalidated,
          errorCode: 'input_version_changed',
        ),
      );
      throw const AssistantActionException('input_version_changed');
    }
    final existing = await _assistantRepository.loadActionByIdempotencyKey(
      action.idempotencyKey,
    );
    if (existing?.status == AiActionStatus.succeeded) return existing!;
    final payload = _validateSchedulePayload(
      jsonDecode(action.validatedPayloadJson) as Map<String, Object?>,
    );
    final executing = _copy(
      action,
      status: AiActionStatus.executing,
      confirmedAtUtc: now,
    );
    try {
      late AiAction succeeded;
      await _unitOfWork.execute(
        executing: executing,
        operation: () async {
          final shifts = (await _scheduleService.loadRulesView()).shifts;
          final shift = payload.shiftId == null
              ? null
              : shifts
                    .where((stored) => stored.shift.id == payload.shiftId)
                    .map((stored) => stored.shift)
                    .firstOrNull;
          if (payload.status == 'work' && shift == null) {
            throw const AssistantActionException('invalid_shift');
          }
          final preview = await _scheduleService.previewOverride(
            dates: payload.range.dates.toList(),
            status: payload.status == 'rest' ? DayStatus.rest : DayStatus.work,
            shift: shift,
          );
          await _scheduleService.applyOverride(preview);
          final calendar = await _scheduleService.loadCalendar(payload.range);
          final after = <String, Object?>{
            'inputVersion': await _scheduleRepository.loadInputVersion(),
            'days': <Object?>[
              for (final day in calendar.days)
                <String, Object?>{
                  'date': day.date.toString(),
                  'status': day.status.name,
                  'shiftId': day.shift?.id.value,
                },
            ],
          };
          succeeded = _copy(
            executing,
            status: AiActionStatus.succeeded,
            afterSnapshotJson: jsonEncode(after),
            executedAtUtc: _clock.nowUtc(),
          );
          return succeeded;
        },
      );
      return succeeded;
    } catch (error) {
      await _assistantRepository.saveAction(
        _copy(
          action,
          status: AiActionStatus.failed,
          errorCode: error.runtimeType.toString(),
        ),
      );
      rethrow;
    }
  }

  Future<AiAction> undoScheduleChange(String actionId) async {
    final action = await _requiredAction(actionId);
    if (action.status != AiActionStatus.succeeded ||
        action.afterSnapshotJson == null) {
      throw const AssistantActionException('action_not_undoable');
    }
    final after = jsonDecode(action.afterSnapshotJson!) as Map<String, Object?>;
    if (await _scheduleRepository.loadInputVersion() != after['inputVersion']) {
      throw const AssistantActionException('undo_conflict');
    }
    final before =
        jsonDecode(action.beforeSnapshotJson) as Map<String, Object?>;
    final rawDays = before['days']! as List<Object?>;
    final dates = rawDays
        .map(
          (raw) => LocalDate.parse(
            (raw! as Map<String, Object?>)['date']! as String,
          ),
        )
        .toList();
    final range = DateRange(start: dates.first, end: dates.last);
    await _scheduleService.restoreRuleResult(range);
    final shifts = (await _scheduleService.loadRulesView()).shifts;
    for (final raw in rawDays) {
      final day = raw! as Map<String, Object?>;
      if (day['source'] != DaySource.userOverride.name) continue;
      final status = DayStatus.values.byName(day['status']! as String);
      final shiftId = day['shiftId'] as String?;
      final shift = shiftId == null
          ? null
          : shifts
                .where((stored) => stored.shift.id.value == shiftId)
                .map((stored) => stored.shift)
                .firstOrNull;
      final preview = await _scheduleService.previewOverride(
        dates: <LocalDate>[LocalDate.parse(day['date']! as String)],
        status: status,
        shift: shift,
      );
      await _scheduleService.applyOverride(preview);
    }
    final undone = _copy(
      action,
      status: AiActionStatus.undone,
      undoneAtUtc: _clock.nowUtc(),
    );
    await _assistantRepository.saveAction(undone);
    return undone;
  }

  ScheduleChangePayload _validateSchedulePayload(
    Map<String, Object?> arguments,
  ) {
    final rangeRaw = arguments['range'];
    if (rangeRaw is! Map<String, Object?>) {
      throw const AssistantActionException('invalid_range');
    }
    final startRaw = rangeRaw['start'];
    final endRaw = rangeRaw['end'];
    if (startRaw is! String || endRaw is! String) {
      throw const AssistantActionException('invalid_range');
    }
    final range = DateRange(
      start: LocalDate.parse(startRaw),
      end: LocalDate.parse(endRaw),
    );
    if (range.start.daysUntil(range.end) > 365) {
      throw const AssistantActionException('range_too_large');
    }
    final status = arguments['new_status'];
    if (status != 'work' && status != 'rest') {
      throw const AssistantActionException('invalid_status');
    }
    final shiftRaw = arguments['shift_id'];
    if (shiftRaw != null && shiftRaw is! String) {
      throw const AssistantActionException('invalid_shift');
    }
    return ScheduleChangePayload(
      range: range,
      status: status! as String,
      shiftId: shiftRaw == null ? null : ShiftId(shiftRaw as String),
      syncAlarms: arguments['sync_alarms'] as bool? ?? true,
    );
  }

  Map<String, Object?> _encodePayload(ScheduleChangePayload payload) =>
      <String, Object?>{
        'range': <String, String>{
          'start': payload.range.start.toString(),
          'end': payload.range.end.toString(),
        },
        'new_status': payload.status,
        'shift_id': payload.shiftId?.value,
        'sync_alarms': payload.syncAlarms,
      };

  Future<AiAction> _requiredAction(String id) async {
    final action = await _assistantRepository.loadAction(id);
    if (action == null) {
      throw const AssistantActionException('action_not_found');
    }
    return action;
  }

  Future<String> _tokenHash(String token) async {
    var encodedSecret = await _secureStore.read(
      reference: _deviceSecretReference,
    );
    if (encodedSecret == null) {
      encodedSecret = _randomToken();
      await _secureStore.write(
        reference: _deviceSecretReference,
        value: encodedSecret,
      );
    }
    final secret = base64Url.decode(base64Url.normalize(encodedSecret));
    return Hmac(sha256, secret).convert(utf8.encode(token)).toString();
  }

  String _randomToken() {
    final bytes = Uint8List.fromList(
      List<int>.generate(32, (_) => _secureRandom.nextInt(256)),
    );
    return base64UrlEncode(bytes).replaceAll('=', '');
  }

  bool _constantTimeEquals(String left, String right) {
    if (left.length != right.length) return false;
    var difference = 0;
    for (var index = 0; index < left.length; index++) {
      difference |= left.codeUnitAt(index) ^ right.codeUnitAt(index);
    }
    return difference == 0;
  }

  AiAction _copy(
    AiAction source, {
    required AiActionStatus status,
    String? afterSnapshotJson,
    DateTime? confirmedAtUtc,
    DateTime? executedAtUtc,
    DateTime? undoneAtUtc,
    String? errorCode,
  }) => AiAction(
    id: source.id,
    conversationId: source.conversationId,
    actionType: source.actionType,
    toolName: source.toolName,
    proposedPayloadJson: source.proposedPayloadJson,
    validatedPayloadJson: source.validatedPayloadJson,
    beforeSnapshotJson: source.beforeSnapshotJson,
    afterSnapshotJson: afterSnapshotJson ?? source.afterSnapshotJson,
    status: status,
    confirmationTokenHash: source.confirmationTokenHash,
    idempotencyKey: source.idempotencyKey,
    inputVersion: source.inputVersion,
    expiresAtUtc: source.expiresAtUtc,
    confirmedAtUtc: confirmedAtUtc ?? source.confirmedAtUtc,
    executedAtUtc: executedAtUtc ?? source.executedAtUtc,
    undoneAtUtc: undoneAtUtc ?? source.undoneAtUtc,
    errorCode: errorCode,
    createdAtUtc: source.createdAtUtc,
  );
}
