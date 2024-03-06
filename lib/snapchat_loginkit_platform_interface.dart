import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:snapchat_loginkit/src/token_response.dart';
import 'package:snapchat_loginkit/src/user_data_query_builder.dart';
import 'package:snapchat_loginkit/src/user_response.dart';
import 'snapchat_loginkit_method_channel.dart';

abstract class SnapchatLoginkitPlatform extends PlatformInterface {
  /// Constructs a SnapchatLoginkitPlatform.
  SnapchatLoginkitPlatform() : super(token: _token);

  static final Object _token = Object();

  static SnapchatLoginkitPlatform _instance = MethodChannelSnapchatLoginkit();

  /// The default instance of [SnapchatLoginkitPlatform] to use.
  ///
  /// Defaults to [MethodChannelSnapchatLoginkit].
  static SnapchatLoginkitPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SnapchatLoginkitPlatform] when
  /// they register themselves.
  static set instance(SnapchatLoginkitPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Get instance of method channel class
  MethodChannel getMethodChannel() =>
      throw UnimplementedError('getMethodChannel() has not been implemented.');

  /// Method to get current running platform version
  Future<String?> getPlatformVersion() =>
      throw UnimplementedError('platformVersion() has not been implemented.');

  /// Start login
  void login() => throw UnimplementedError('login() has not been implemented.');

  /// Query user’s logged-in state
  Future<bool> isUserLoggedIn() =>
      throw UnimplementedError('isUserLoggedIn() has not been implemented.');

  /// Subscribe for login updates
  void addLoginStateCallback() => throw UnimplementedError(
      'addLoginStateCallback() has not been implemented.');

  /// Unsubscribe from login updates
  void removeLoginStateCallback() => throw UnimplementedError(
      'removeLoginStateCallback() has not been implemented.');

  /// Clear the access and refresh token locally
  void logout() =>
      throw UnimplementedError('logout() has not been implemented.');

  /// Asynchronously Call the fetch API and get the User data
  Future<UserResponse> fetchUserData(UserDataQuery query) =>
      throw UnimplementedError('fetchUserData() has not been implemented.');

  /// Fetch access token after successfully logged in
  Future<TokenResponse> fetchAccessToken() =>
      throw UnimplementedError('fetchAccessToken() has not been implemented.');

  /// To check whether a specific scope has access or not
  Future<bool> hasAccessToScope(String scope) =>
      throw UnimplementedError('hasAccessToScope() has not been implemented.');

  /// Asynchronously, get access token via login with firebase
  Future<TokenResponse> loginWithFirebase() =>
      throw UnimplementedError('loginWithFirebase() has not been implemented.');
}
