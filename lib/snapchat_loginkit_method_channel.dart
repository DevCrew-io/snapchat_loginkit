import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'snapchat_loginkit_platform_interface.dart';

/// An implementation of [SnapchatLoginkitPlatform] that uses method channels.
class MethodChannelSnapchatLoginkit extends SnapchatLoginkitPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('snapchat_loginkit');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  void login() {
    methodChannel.invokeMethod<String>('login');
  }

  @override
  void logout() {
    methodChannel.invokeMethod<String>('logout');
  }

  @override
  Future<bool> isUserLoggedIn() async {
    final isUserLoggedIn = await methodChannel.invokeMethod<bool>('isUserLoggedIn');
    return isUserLoggedIn ?? false;
  }

  @override
  void addLoginStateCallback() {
    methodChannel.invokeMethod<String>('addLoginStateCallback');
  }

  @override
  void removeLoginStateCallback() {
    methodChannel.invokeMethod<String>('removeLoginStateCallback');
  }

  @override
  MethodChannel getMethodChannel() {
    return methodChannel;
  }
}
