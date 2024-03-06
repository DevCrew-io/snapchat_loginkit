import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:snapchat_loginkit/snapchat_loginkit.dart';
import 'snapchat_loginkit_platform_interface.dart';

/// An implementation of [SnapchatLoginkitPlatform] that uses method channels.
class MethodChannelSnapchatLoginkit extends SnapchatLoginkitPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('snapchat_loginkit');

  /// Method to get current running platform version
  @override
  Future<String?> getPlatformVersion() async =>
      await methodChannel.invokeMethod<String>('getPlatformVersion');

  /// Invoke the method on the platform side for Start token grant
  @override
  void login() => methodChannel.invokeMethod<String>('login');

  /// Invoke the method on the platform side for Clear the access and refresh token locally
  @override
  void logout() => methodChannel.invokeMethod<String>('logout');

  /// Invoke the method on the platform side for Query user’s logged-in state
  @override
  Future<bool> isUserLoggedIn() async =>
      await methodChannel.invokeMethod('isUserLoggedIn');

  /// Invoke the method on the platform side for Subscribe for login updates
  @override
  void addLoginStateCallback() =>
      methodChannel.invokeMethod<String>('addLoginStateCallback');

  /// Invoke the method on the platform side for Unsubscribe from login updates
  @override
  void removeLoginStateCallback() =>
      methodChannel.invokeMethod<String>('removeLoginStateCallback');

  ///  Get singleton instance of method channel
  @override
  MethodChannel getMethodChannel() => methodChannel;

  /// Invoke the method on the platform side for Asynchronously Call the fetch API and get the User data
  @override
  Future<UserResponse> fetchUserData(UserDataQuery query) async =>
      UserResponse.fromMap(
          await methodChannel.invokeMethod('fetchUserData', query.toMap()));

  /// Invoke the method on the platform side for Fetch access token after successfully logged in
  @override
  Future<TokenResponse> fetchAccessToken() async => TokenResponse.fromMap(
      await methodChannel.invokeMethod('fetchAccessToken'));

  /// Invoke the method on the platform side for To check whether a specific scope has access or not
  @override
  Future<bool> hasAccessToScope(String scope) async =>
      await methodChannel.invokeMethod('hasAccessToScope', scope);

  /// Invoke the method on the platform side for Asynchronously, get access token via login with firebase
  @override
  Future<TokenResponse> loginWithFirebase() async => TokenResponse.fromMap(
      await methodChannel.invokeMethod('loginWithFirebase'));
}
