import 'package:snapchat_loginkit/src/user_data.dart';
import 'snapchat_loginkit_platform_interface.dart';

import 'src/snap_callbacks.dart';
export 'src/snap_callbacks.dart';

import 'src/user_data_query_builder.dart';
export 'src/user_data_query_builder.dart';
export 'src/user_data.dart';

class SnapchatLoginkit {
  final LoginStateCallback? loginStateCallback;

  SnapchatLoginkit({this.loginStateCallback}) {
    SnapchatLoginkitPlatform.instance.getMethodChannel().setMethodCallHandler((call) async {
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

  Future<String?> getPlatformVersion() {
    return SnapchatLoginkitPlatform.instance.getPlatformVersion();
  }

  void login() {
    SnapchatLoginkitPlatform.instance.login();
  }

  void logout() {
    SnapchatLoginkitPlatform.instance.logout();
  }

  Future<bool> isUserLoggedIn() {
    return SnapchatLoginkitPlatform.instance.isUserLoggedIn();
  }

  Future<UserDataResponse> fetchUserData(UserDataQuery query) async {
    final userData = SnapchatLoginkitPlatform.instance.fetchUserData(query);
    return userData;
  }
}
