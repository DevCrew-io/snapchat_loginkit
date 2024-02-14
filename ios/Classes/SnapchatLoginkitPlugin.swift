import Flutter
import UIKit
import SCSDKLoginKit

let channelName = "snapchat_loginkit"

public class SnapchatLoginkitPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: channelName, binaryMessenger: registrar.messenger())
        let instance = SnapchatLoginkitPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    
    private let loginStateCallback = LoginStateCallback()
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
            
        case Method.login:
            login()
            
        case Method.addLoginStateCallback:
            addLoginStateCallback()
            
        case Method.removeLoginStateCallback:
            removeLoginStateCallback()
            
        case Method.logout:
            logout()
            
        case Method.isUserLoggedIn:
            isUserLoggedIn(result)
            
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
            
        default:
            result(FlutterMethodNotImplemented)
            
        }
    }
    
    private func login() {
        addLoginStateCallback()
        SCSDKLoginClient.login(from: nil) { status, error in
            guard let error = error else {
                return
            }
            self.loginStateCallback.snapchatLoginFailed(message: error.localizedDescription)
        }
    }
    
    private func addLoginStateCallback() {
        SCSDKLoginClient.addLoginStatusObserver(loginStateCallback)
    }
    
    private func removeLoginStateCallback() {
        SCSDKLoginClient.removeLoginStatusObserver(loginStateCallback)
    }
    
    private func logout() {
        addLoginStateCallback()
        SCSDKLoginClient.clearToken()
    }
    
    private func isUserLoggedIn(_ result: FlutterResult) {
        result(SCSDKLoginClient.isUserLoggedIn)
    }
}
