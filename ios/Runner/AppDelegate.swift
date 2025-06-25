import Flutter
import UIKit
import AVFoundation

// @main
// @objc class AppDelegate: FlutterAppDelegate {
//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
//     GeneratedPluginRegistrant.register(with: self)
//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }
// }

@main
@objc class AppDelegate: FlutterAppDelegate {
  private let channelName = "com.example.flashlight/torch"

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let flashlightChannel = FlutterMethodChannel(name: channelName, binaryMessenger: controller.binaryMessenger)

    flashlightChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      guard let device = AVCaptureDevice.default(for: AVMediaType.video),
            device.hasTorch else {
        result(FlutterError(code: "NO_TORCH", message: "Torch not available", details: nil))
        return
      }

      do {
        try device.lockForConfiguration()
        if call.method == "turnOn" {
          try device.setTorchModeOn(level: 1.0)
          result("Torch turned on")
        } else if call.method == "turnOff" {
          device.torchMode = .off
          result("Torch turned off")
        } else {
          result(FlutterMethodNotImplemented)
        }
        device.unlockForConfiguration()
      } catch {
        result(FlutterError(code: "TORCH_ERROR", message: "Torch error", details: nil))
      }
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
