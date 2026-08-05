abstract interface class NotificationBridge {
  Future<bool> requestPermission();
  Future<bool> isPermissionGranted();
}
