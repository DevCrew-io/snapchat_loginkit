
/// exception to handle login failure result
class LoginException implements Exception {

}

/// [login] method callbacks
abstract class LoginResultCallback {
  void onStart();
  void onSuccess(String accessToken);
  void onFailure(LoginException e);
}

/// subscribe to updates of login process
abstract class LoginStateCallback extends LoginResultCallback {
  void onLogout();
}

typedef OnSuccess = void Function(String accessToken);
typedef OnFailure = void Function(LoginException exception);

/// method channel calls received from native side
class LoginCallbackMethod {
  static const String onStart = "onStart";
  static const String onSuccess = "onSuccess";
  static const String onFailure = "onFailure";
  static const String onLogout = "onLogout";
}