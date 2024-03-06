import 'package:snapchat_loginkit/src/token_response.dart';
import 'package:snapchat_loginkit/src/user_response.dart';
import 'snapchat_loginkit_platform_interface.dart';
import 'src/snap_callbacks.dart';
export 'src/snap_callbacks.dart';
import 'src/user_data_query_builder.dart';
export 'src/user_data_query_builder.dart';
export 'src/user_response.dart';
export 'src/token_response.dart';

class SnapchatLoginkit {
  final LoginStateCallback? loginStateCallback;

  SnapchatLoginkit({this.loginStateCallback}) {
    /// Implement the callback interface
    SnapchatLoginkitPlatform.instance
        .getMethodChannel()
        .setMethodCallHandler((call) async {
      switch (call.method) {
        /// Trigger when login start
        case LoginCallbackMethod.onStart:
          loginStateCallback?.onStart();
          break;

        /// Trigger when login success
        case LoginCallbackMethod.onSuccess:
          loginStateCallback?.onSuccess(call.arguments);
          break;

        /// Trigger when login failed
        case LoginCallbackMethod.onFailure:
          loginStateCallback?.onFailure(call.arguments);
          break;

        /// Trigger call back on logout
        case LoginCallbackMethod.onLogout:
          loginStateCallback?.onLogout();
          break;

        /// default implementation to throw exception
        default:
          throw UnsupportedError("${call.method} is not supported");
      }
    });
  }

  /// Method to get current running platform version
  Future<String?> getPlatformVersion() =>
      SnapchatLoginkitPlatform.instance.getPlatformVersion();

  /// Start token grant
  void login() => SnapchatLoginkitPlatform.instance.login();

  /// Subscribe for login updates
  void addLoginStateCallback() =>
      SnapchatLoginkitPlatform.instance.addLoginStateCallback();

  /// Unsubscribe from login updates
  void removeLoginStateCallback() =>
      SnapchatLoginkitPlatform.instance.removeLoginStateCallback();

  /// Clear the access and refresh token locally
  void logout() => SnapchatLoginkitPlatform.instance.logout();

  /// Query user’s logged-in state
  Future<bool> isUserLoggedIn() =>
      SnapchatLoginkitPlatform.instance.isUserLoggedIn();

  /// Asynchronously Call the fetch API and get the User data
  Future<UserResponse> fetchUserData(UserDataQuery query) async =>
      await SnapchatLoginkitPlatform.instance.fetchUserData(query);

  /// Fetch access token after successfully logged in
  Future<TokenResponse> fetchAccessToken() async =>
      await SnapchatLoginkitPlatform.instance.fetchAccessToken();

  /// To check whether a specific scope has access
  Future<bool> hasAccessToScope(String scope) async =>
      await SnapchatLoginkitPlatform.instance.hasAccessToScope(scope);

  /// Asynchronously, get access token via login with firebase
  Future<TokenResponse> loginWithFirebase() async =>
      await SnapchatLoginkitPlatform.instance.loginWithFirebase();
}
