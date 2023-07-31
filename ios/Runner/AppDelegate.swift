import Foundation
import UIKit
import Flutter
import GoogleMobileAds

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    if isRunningOnSimulator() {
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = ["9BE5747F-3912-48BE-956A-F87340E62DB0"]
    } else {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

func isRunningOnSimulator() -> Bool {
    #if targetEnvironment(simulator)
    return true
    #else
    return false
    #endif
}