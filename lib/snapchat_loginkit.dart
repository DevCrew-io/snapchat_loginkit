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
    SnapchatLoginkitPlatform.instance
        .getMethodChannel()
        .setMethodCallHandler((call) async {
      switch (call.method) {
        case LoginCallbackMethod.onStart:
          loginStateCallback?.onStart();
          break;
        case LoginCallbackMethod.onSuccess:
          loginStateCallback?.onSuccess(call.arguments);
          break;
        case LoginCallbackMethod.onFailure:
          loginStateCallback?.onFailure(call.arguments);
          break;
        case LoginCallbackMethod.onLogout:
          loginStateCallback?.onLogout();
          break;
        default:
          throw UnsupportedError("${call.method} is not supported");
      }
    });
  }

  Future<String?> getPlatformVersion() =>
      SnapchatLoginkitPlatform.instance.getPlatformVersion();

  void login() => SnapchatLoginkitPlatform.instance.login();

  void addLoginStateCallback() =>
      SnapchatLoginkitPlatform.instance.addLoginStateCallback();

  void removeLoginStateCallback() =>
      SnapchatLoginkitPlatform.instance.removeLoginStateCallback();

  void logout() => SnapchatLoginkitPlatform.instance.logout();

  Future<bool> isUserLoggedIn() =>
      SnapchatLoginkitPlatform.instance.isUserLoggedIn();

  Future<UserResponse> fetchUserData(UserDataQuery query) async =>
      await SnapchatLoginkitPlatform.instance.fetchUserData(query);

  Future<TokenResponse> fetchAccessToken() async =>
      await SnapchatLoginkitPlatform.instance.fetchAccessToken();

  Future<bool> hasAccessToScope(String scope) async =>
      await SnapchatLoginkitPlatform.instance.hasAccessToScope(scope);

  Future<TokenResponse> loginWithFirebase() async =>
      await SnapchatLoginkitPlatform.instance.loginWithFirebase();
}
