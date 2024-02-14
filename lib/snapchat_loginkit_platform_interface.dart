

import 'dart:ffi';

import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

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

  MethodChannel getMethodChannel() {
    throw UnimplementedError('getMethodChannel() has not been implemented.');
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  void login() {
    throw UnimplementedError('login() has not been implemented.');
  }

  Future<bool> isUserLoggedIn() async {
    throw UnimplementedError('isUserLoggedIn() has not been implemented.');
  }

  void logout() {
    throw UnimplementedError('logout() has not been implemented.');
  }
}
