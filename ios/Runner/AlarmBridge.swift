import Flutter
import UserNotifications

final class AlarmBridge: NSObject, FlutterPlugin {
  private static let channelName = "banxin_calendar/alarm"
  private static let identifierPrefix = "banxin_"

  static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: channelName,
      binaryMessenger: registrar.messenger()
    )
    let instance = AlarmBridge()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "capability":
      capability(result: result)
    case "requestCapability":
      requestCapability(result: result)
    case "schedule":
      schedule(call: call, result: result)
    case "cancel":
      guard
        let arguments = call.arguments as? [String: Any],
        let identifier = arguments["platformAlarmId"] as? String,
        identifier.hasPrefix(Self.identifierPrefix)
      else {
        result(FlutterError(code: "invalid_alarm", message: nil, details: nil))
        return
      }
      UNUserNotificationCenter.current().removePendingNotificationRequests(
        withIdentifiers: [identifier]
      )
      result(nil)
    case "listManagedAlarmIds":
      UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
        let identifiers = requests
          .map(\.identifier)
          .filter { $0.hasPrefix(Self.identifierPrefix) }
        DispatchQueue.main.async { result(identifiers) }
      }
    case "consumeTriggeredAlarmIds":
      // UNUserNotificationCenter does not expose delivery receipts for notifications
      // while the app is terminated. Keep the cross-platform bridge total and let the
      // pending-request reconciliation handle iOS delivery state.
      result([String]())
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func capability(result: @escaping FlutterResult) {
    UNUserNotificationCenter.current().getNotificationSettings { settings in
      let capability: String
      switch settings.authorizationStatus {
      case .authorized, .provisional, .ephemeral:
        capability = "available"
      case .notDetermined, .denied:
        capability = "permissionRequired"
      @unknown default:
        capability = "unavailable"
      }
      DispatchQueue.main.async { result(capability) }
    }
  }

  private func requestCapability(result: @escaping FlutterResult) {
    UNUserNotificationCenter.current().requestAuthorization(
      options: [.alert, .badge, .sound]
    ) { granted, error in
      DispatchQueue.main.async {
        if let error {
          result(
            FlutterError(
              code: "notification_permission_failed",
              message: String(describing: type(of: error)),
              details: nil
            )
          )
        } else {
          result(granted ? "available" : "permissionRequired")
        }
      }
    }
  }

  private func schedule(call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard
      let arguments = call.arguments as? [String: Any],
      let identifier = arguments["platformAlarmId"] as? String,
      identifier.hasPrefix(Self.identifierPrefix),
      let triggerAtNumber = arguments["triggerAtEpochMillis"] as? NSNumber
    else {
      result(FlutterError(code: "invalid_alarm", message: nil, details: nil))
      return
    }
    let triggerDate = Date(timeIntervalSince1970: triggerAtNumber.doubleValue / 1000)
    let interval = triggerDate.timeIntervalSinceNow
    guard interval > 0 else {
      result(FlutterError(code: "alarm_in_past", message: nil, details: nil))
      return
    }
    let content = UNMutableNotificationContent()
    content.title = arguments["title"] as? String ?? "班薪日历"
    content.body = arguments["body"] as? String ?? ""
    content.categoryIdentifier = "banxin_schedule_alarm"
    if let soundId = arguments["soundId"] as? String, !soundId.isEmpty {
      content.sound = UNNotificationSound(named: UNNotificationSoundName(soundId))
    } else {
      content.sound = .default
    }
    content.userInfo = [
      "platformAlarmId": identifier,
      "payloadHash": arguments["payloadHash"] as? String ?? "",
    ]
    let trigger = UNTimeIntervalNotificationTrigger(
      timeInterval: max(1, interval),
      repeats: false
    )
    let request = UNNotificationRequest(
      identifier: identifier,
      content: content,
      trigger: trigger
    )
    UNUserNotificationCenter.current().add(request) { error in
      DispatchQueue.main.async {
        if let error {
          result(
            FlutterError(
              code: "alarm_schedule_failed",
              message: String(describing: type(of: error)),
              details: nil
            )
          )
        } else {
          result(nil)
        }
      }
    }
  }
}
