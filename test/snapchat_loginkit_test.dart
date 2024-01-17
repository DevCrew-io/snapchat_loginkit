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
