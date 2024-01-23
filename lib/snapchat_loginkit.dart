
import 'dart:ui';

import 'snapchat_loginkit_platform_interface.dart';
import 'src/snap_callbacks.dart';

class SnapchatLoginkit {

  final LoginStateCallback? loginStateCallback;

  VoidCallback? _onStart;
  OnSuccess? _onSuccess;
  OnFailure? _onFailure;

  SnapchatLoginkit({this.loginStateCallback}) {
    SnapchatLoginkitPlatform.instance.getMethodChannel().setMethodCallHandler((call) async {
      switch(call.method) {
        case LoginCallbackMethod.onStart:
          _onStart?.call();
          loginStateCallback?.onStart();
          break;
        case LoginCallbackMethod.onSuccess:
          _onSuccess?.call(call.arguments);
          loginStateCallback?.onSuccess(call.arguments);
          break;
        case LoginCallbackMethod.onFailure:
          _onFailure?.call(call.arguments);
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

  void startTokenGrant({VoidCallback? onStart, OnSuccess? onSuccess, OnFailure? onFailure}) {
    _onStart = onStart;
    _onSuccess = onSuccess;
    _onFailure = onFailure;
    SnapchatLoginkitPlatform.instance.startTokenGrant();
  }
}

