/// [login] method callbacks
abstract class LoginResultCallback {
  void onStart();

  void onSuccess(String accessToken);

  void onFailure(String message);
}

/// subscribe to updates of login process
abstract class LoginStateCallback extends LoginResultCallback {
  void onLogout();
}

typedef OnSuccess = void Function(String accessToken);
typedef OnFailure = void Function(String message);

/// method channel calls received from native side
class LoginCallbackMethod {
  static const String onStart = "onStart";
  static const String onSuccess = "onSuccess";
  static const String onFailure = "onFailure";
  static const String onLogout = "onLogout";
}
