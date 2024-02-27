import 'package:flutter/src/services/platform_channel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapchat_loginkit/snapchat_loginkit.dart';
import 'package:snapchat_loginkit/snapchat_loginkit_platform_interface.dart';
import 'package:snapchat_loginkit/snapchat_loginkit_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:snapchat_loginkit/src/token_response.dart';
import 'package:snapchat_loginkit/src/user_response.dart';

class MockSnapchatLoginkitPlatform with MockPlatformInterfaceMixin implements SnapchatLoginkitPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  MethodChannel getMethodChannel() => throw UnimplementedError();

  @override
  void login() {
    // TODO: implement startTokenGrant
  }

  @override
  Future<bool> isUserLoggedIn() => Future.value(false);

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
  Future<UserResponse> fetchUserData(UserDataQuery query) => throw UserResponse(code: 0, message: "");

  @override
  Future<TokenResponse> fetchAccessToken() => throw UnimplementedError();

  @override
  Future<bool> hasAccessToScope(String scope) => throw UnimplementedError();

  @override
  Future<TokenResponse> loginWithFirebase() => throw UnimplementedError();
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
