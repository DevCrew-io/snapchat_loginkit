import 'dart:ffi';

import 'package:flutter/src/services/platform_channel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapchat_loginkit/snapchat_loginkit.dart';
import 'package:snapchat_loginkit/snapchat_loginkit_platform_interface.dart';
import 'package:snapchat_loginkit/snapchat_loginkit_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSnapchatLoginkitPlatform
    with MockPlatformInterfaceMixin
    implements SnapchatLoginkitPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  MethodChannel getMethodChannel() {
    // TODO: implement getMethodChannel
    throw UnimplementedError();
  }

  @override
  void login() {
    // TODO: implement startTokenGrant
  }

  @override
  Future<bool> isUserLoggedIn() {
    return Future.value(false);
  }

  @override
  void addLoginStateCallback() {
    // TODO: implement addLoginStateCallback
  }

  @override
  void removeLoginStateCallback() {
    // TODO: implement addLoginStateCallback
  }

  @override
  void logout() {
    // TODO: implement logout
  }

  @override
  Future<UserDataResponse> fetchUserData(UserDataQuery query) {
    // TODO: implement fetchUserData
    throw UserDataResponse(code: 0, message: "");
  }

  @override
  Future<String> fetchAccessToken() {
    // TODO: implement fetchAccessToken
    throw UnimplementedError();
  }

  @override
  Future<bool> hasAccessToScope(String scope) {
    // TODO: implement hasAccessToScope
    throw UnimplementedError();
  }

}

void main() {
  final SnapchatLoginkitPlatform initialPlatform = SnapchatLoginkitPlatform.instance;

  test('$MethodChannelSnapchatLoginkit is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSnapchatLoginkit>());
  });

  test('getPlatformVersion', () async {
    SnapchatLoginkit snapchatLoginkitPlugin = SnapchatLoginkit();
    MockSnapchatLoginkitPlatform fakePlatform = MockSnapchatLoginkitPlatform();
    SnapchatLoginkitPlatform.instance = fakePlatform;

    expect(await snapchatLoginkitPlugin.getPlatformVersion(), '42');
  });
}
