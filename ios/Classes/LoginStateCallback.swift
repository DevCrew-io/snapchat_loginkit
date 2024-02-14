//
//  LoginStateCallback.swift
//  snapchat_loginkit
//
//  Created by Najam Us Saqib on 14/02/2024.
//

import Flutter
import SCSDKLoginKit

class LoginStateCallback: NSObject, SCSDKLoginStatusObserver {
    
    func scsdkLoginLinkDidStart() {
        debugPrint("SnapChatLoginKit", "onStart")
        getChannel()?.invokeMethod(Method.Callback.onStart, arguments: nil)
    }
    
    func scsdkLoginLinkDidSucceed() {
        let token = SCSDKLoginClient.getAccessToken()
        debugPrint("SnapChatLoginKit onSuccess")
        getChannel()?.invokeMethod(Method.Callback.onSuccess, arguments: token)
    }
    
    func scsdkLoginLinkDidFail() {
        debugPrint("SnapChatLoginKit", "onFailure")
        snapchatLoginFailed(message: "Snapchat login failed")
    }
    
    func scsdkLoginDidUnlink() {
        debugPrint("SnapChatLoginKit", "onLogout")
        getChannel()?.invokeMethod(Method.Callback.onLogout, arguments: nil)
    }
    
    func snapchatLoginFailed(message: String) {
        getChannel()?.invokeMethod(Method.Callback.onFailure, arguments: message)
    }
    
    private func getChannel() -> FlutterMethodChannel? {
        guard let contoller = UIApplication.shared.windows.first?.rootViewController as? FlutterViewController else {
            return nil
        }
        return FlutterMethodChannel(name: channelName, binaryMessenger: contoller.binaryMessenger)
    }
}

