import 'package:banxin_calendar/features/alarm/domain/alarm_entities.dart';
import 'package:banxin_calendar/features/alarm/domain/platform_alarm_service.dart';
import 'package:flutter/services.dart';

final class MethodChannelAlarmBridge implements PlatformAlarmService {
  MethodChannelAlarmBridge({MethodChannel? channel})
    : _channel = channel ?? const MethodChannel('banxin_calendar/alarm');

  final MethodChannel _channel;

  @override
  Future<AlarmCapability> capability() async {
    final value = await _channel.invokeMethod<String>('capability');
    return _decodeCapability(value);
  }

  @override
  Future<AlarmCapability> requestCapability() async {
    final value = await _channel.invokeMethod<String>('requestCapability');
    return _decodeCapability(value);
  }

  @override
  Future<void> schedule(PlatformAlarmRequest request) {
    return _channel.invokeMethod<void>('schedule', <String, Object?>{
      'platformAlarmId': request.platformAlarmId,
      'triggerAtEpochMillis': request.triggerAtUtc.millisecondsSinceEpoch,
      'payloadHash': request.payloadHash,
      'title': request.title,
      'body': request.body,
      'vibrate': request.vibrate,
      'soundId': request.soundId,
    });
  }

  @override
  Future<void> cancel(String platformAlarmId) {
    return _channel.invokeMethod<void>('cancel', <String, Object?>{
      'platformAlarmId': platformAlarmId,
    });
  }

  @override
  Future<Set<String>> listManagedAlarmIds() async {
    final values = await _channel.invokeListMethod<String>(
      'listManagedAlarmIds',
    );
    return (values ?? const <String>[]).toSet();
  }

  AlarmCapability _decodeCapability(String? value) => switch (value) {
    'available' => AlarmCapability.available,
    'permissionRequired' => AlarmCapability.permissionRequired,
    _ => AlarmCapability.unavailable,
  };
}
