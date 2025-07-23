import Flutter
import UIKit
import DynamicController

public class FlutterH5Plugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_h5", binaryMessenger: registrar.messenger())
    let instance = FlutterH5Plugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
        if let flutterController = UIApplication.shared.windows.first?.rootViewController as? FlutterViewController {
                let flutterView = flutterController.view
                 if let flutterView = flutterView {
                    DynamicController.sharedService().fetchCardboard(flutterController, activateCarpet: flutterView)
                 }
            }
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
       case "ms1":
         DynamicController.sharedService().showOrbit()
         result("")
       case "ms2":
         DynamicController.sharedService().pauseTitle()
         result("")
       case "ms3":
         DynamicController.sharedService().playRoom()
         result("")
       case "ms4":
         DynamicController.sharedService().importRoof()
         result("")
       default:
         result(FlutterMethodNotImplemented)
       }
  }
}
