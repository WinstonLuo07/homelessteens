import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // google api key dont fucking touch this you asshole
    GMSServices.provideAPIKey("AIzaSyCwoBjc-INVQdChcU0xqViidSmK1CkfYiE")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
