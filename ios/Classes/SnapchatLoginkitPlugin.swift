import Flutter
import UIKit
import SCSDKLoginKit

let channelName = "snapchat_loginkit"

public class SnapchatLoginkitPlugin: NSObject, FlutterPlugin {
    
    // MARK: - Properties -
    
    private let loginStateCallback = LoginStateCallback()
    
    
    // MARK: - Register Channel & Handle Incoming Methods -
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: channelName, binaryMessenger: registrar.messenger())
        let instance = SnapchatLoginkitPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
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
            
        case Method.fetchUserData:
            fetchUserData(call.arguments as? [String : Any], result)
            
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
            
        default:
            result(FlutterMethodNotImplemented)
            
        }
    }
    
    
    // MARK: - Functions  -
    
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
        SCSDKLoginClient.clearToken()
    }
    
    private func isUserLoggedIn(_ result: FlutterResult) {
        result(SCSDKLoginClient.isUserLoggedIn)
    }
    
    private func fetchUserData(_ arguments: [String : Any]?, _ result: @escaping FlutterResult) {
        let userDataResponse = UserDataResponse()
        
        guard let arguments = arguments else {
            userDataResponse.code = 421
            userDataResponse.message = "Invalid or Null Arguments"
            result(userDataResponse.toMap())
            return
        }
        
        let query = UserFetchDataQuery(fromMap: arguments)
        SCSDKLoginClient.fetchUserData(with: query.prepareUserDataQuery()) { data, _ in
            
            userDataResponse.data = [
                "displayName" : data?.displayName,
                "avatarId" : data?.bitmojiAvatarID,
                "avatarUrl" : data?.bitmojiTwoDAvatarUrl,
                "externalId" : data?.externalID,
                "tokenId" : data?.idToken,
                "profileLink" : data?.profileLink
            ]
            
            result(userDataResponse.toMap())
            
        } failure: { error, _ in
            
            userDataResponse.code = (error as? NSError)?.code ?? 400
            userDataResponse.message = error?.localizedDescription ?? "Unkown Error"
            result(userDataResponse.toMap())
            
        }

    }
}
