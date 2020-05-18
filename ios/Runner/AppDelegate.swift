import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let myChannel = FlutterMethodChannel(name: "test",
                                                binaryMessenger: controller.binaryMessenger)

    myChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          switch(call.method){
             case "getPlatformVersion":
                self.getPlatformVersion(call, result: result)
                break

             case "getCalculation":
                self.getCalculation(call: call, result: result)
                break

             default:
                result(FlutterMethodNotImplemented)
                break
          }
        })

    // keep this at the end
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  public func getPlatformVersion(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }

    public func getCalculation(call: FlutterMethodCall, result: @escaping FlutterResult) {
      let args = call.arguments as! Dictionary<String, Any>
      let n1 = args["first"] as? Int
      let n2 = args["second"] as? Int

      if(n1 == nil || n2 == nil) {
         result(FlutterError(code: "ERROR",message: "can only sum integers", details: nil))
      }

      result(n1! + n2!)
    }
}
