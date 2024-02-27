import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:snapchat_loginkit/snapchat_loginkit.dart';
import 'package:snapchat_loginkit/src/token_response.dart';
import 'package:snapchat_loginkit/src/user_response.dart';

import 'snapchat_loginkit_platform_interface.dart';

/// An implementation of [SnapchatLoginkitPlatform] that uses method channels.
class MethodChannelSnapchatLoginkit extends SnapchatLoginkitPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('snapchat_loginkit');

  @override
  Future<String?> getPlatformVersion() async =>
      await methodChannel.invokeMethod<String>('getPlatformVersion');

  @override
  void login() =>
      methodChannel.invokeMethod<String>('login');

  @override
  void logout() =>
      methodChannel.invokeMethod<String>('logout');

  @override
  Future<bool> isUserLoggedIn() async =>
      await methodChannel.invokeMethod('isUserLoggedIn');

  @override
  void addLoginStateCallback() =>
      methodChannel.invokeMethod<String>('addLoginStateCallback');

  @override
  void removeLoginStateCallback() =>
      methodChannel.invokeMethod<String>('removeLoginStateCallback');

  @override
  MethodChannel getMethodChannel() => methodChannel;

  @override
  Future<UserResponse> fetchUserData(UserDataQuery query) async =>
      UserResponse.fromMap(await methodChannel.invokeMethod('fetchUserData', query.toMap()));

  @override
  Future<TokenResponse> fetchAccessToken() async =>
      TokenResponse.fromMap(await methodChannel.invokeMethod('fetchAccessToken'));

  @override
  Future<bool> hasAccessToScope(String scope) async =>
      await methodChannel.invokeMethod('hasAccessToScope', scope);

  @override
  Future<TokenResponse> loginWithFirebase() async =>
      TokenResponse.fromMap(await methodChannel.invokeMethod('loginWithFirebase'));
}
