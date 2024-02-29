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

  MethodChannel getMethodChannel() =>
      throw UnimplementedError('getMethodChannel() has not been implemented.');

  Future<String?> getPlatformVersion() =>
      throw UnimplementedError('platformVersion() has not been implemented.');

  void login() => throw UnimplementedError('login() has not been implemented.');

  Future<bool> isUserLoggedIn() =>
      throw UnimplementedError('isUserLoggedIn() has not been implemented.');

  void addLoginStateCallback() => throw UnimplementedError(
      'addLoginStateCallback() has not been implemented.');

  void removeLoginStateCallback() => throw UnimplementedError(
      'removeLoginStateCallback() has not been implemented.');

  void logout() =>
      throw UnimplementedError('logout() has not been implemented.');

  Future<UserResponse> fetchUserData(UserDataQuery query) =>
      throw UnimplementedError('fetchUserData() has not been implemented.');

  Future<TokenResponse> fetchAccessToken() =>
      throw UnimplementedError('fetchAccessToken() has not been implemented.');

  Future<bool> hasAccessToScope(String scope) =>
      throw UnimplementedError('hasAccessToScope() has not been implemented.');

  Future<TokenResponse> loginWithFirebase() =>
      throw UnimplementedError('loginWithFirebase() has not been implemented.');
}
