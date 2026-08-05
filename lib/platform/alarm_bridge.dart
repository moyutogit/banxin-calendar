abstract interface class AlarmBridge {
  Future<AlarmCapability> capability();
  Future<void> schedule(PlatformAlarmRequest request);
  Future<void> cancel(String platformAlarmId);
  Future<Set<String>> listManagedAlarmIds();
}

enum AlarmCapability { available, permissionRequired, unavailable }

class PlatformAlarmRequest {
  const PlatformAlarmRequest({
    required this.platformAlarmId,
    required this.triggerAtUtc,
    required this.payloadHash,
  });

  final String platformAlarmId;
  final DateTime triggerAtUtc;
  final String payloadHash;
}
