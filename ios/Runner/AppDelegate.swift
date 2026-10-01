import Flutter
import UIKit
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  private var storageChannel: FlutterMethodChannel?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    UNUserNotificationCenter.current().delegate = self
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    storageChannel = FlutterMethodChannel(
      name: "kepli/storage",
      binaryMessenger: engineBridge.applicationRegistrar.messenger()
    )
    storageChannel?.setMethodCallHandler { call, result in
      guard call.method == "excludeFromBackup" else {
        result(FlutterMethodNotImplemented)
        return
      }
      guard let arguments = call.arguments as? [String: Any],
            let path = arguments["path"] as? String, !path.isEmpty else {
        result(FlutterError(code: "invalid_path", message: "A local directory is required.", details: nil))
        return
      }
      do {
        let home = URL(fileURLWithPath: NSHomeDirectory(), isDirectory: true)
          .resolvingSymlinksInPath().standardizedFileURL
        var directory = URL(fileURLWithPath: path, isDirectory: true)
          .resolvingSymlinksInPath().standardizedFileURL
        guard directory.path.hasPrefix(home.path + "/") else {
          result(FlutterError(code: "invalid_path", message: "Only app-owned storage may be protected.", details: nil))
          return
        }
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        var values = URLResourceValues()
        values.isExcludedFromBackup = true
        try directory.setResourceValues(values)
        let stored = try directory.resourceValues(forKeys: [.isExcludedFromBackupKey])
        guard stored.isExcludedFromBackup == true else {
          result(FlutterError(code: "backup_exclusion_failed", message: "Backup exclusion could not be verified.", details: nil))
          return
        }
        result(true)
      } catch {
        result(FlutterError(code: "backup_exclusion_failed", message: "Local storage could not be excluded from backups.", details: error.localizedDescription))
      }
    }
  }
}
