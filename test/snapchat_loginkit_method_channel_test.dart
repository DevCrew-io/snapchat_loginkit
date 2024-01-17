import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapchat_loginkit/snapchat_loginkit_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelSnapchatLoginkit platform = MethodChannelSnapchatLoginkit();
  const MethodChannel channel = MethodChannel('snapchat_loginkit');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
