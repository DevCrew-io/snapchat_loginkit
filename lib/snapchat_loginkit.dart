
import 'snapchat_loginkit_platform_interface.dart';
import 'src/snap_callbacks.dart';

class SnapchatLoginkit {

  final LoginStateCallback? loginStateCallback;

  SnapchatLoginkit({this.loginStateCallback}) {
    SnapchatLoginkitPlatform.instance.getMethodChannel().setMethodCallHandler((call) async {
      switch(call.method) {
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
}

