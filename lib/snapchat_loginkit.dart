
import 'snapchat_loginkit_platform_interface.dart';

class SnapchatLoginkit {
  Future<String?> getPlatformVersion() {
    return SnapchatLoginkitPlatform.instance.getPlatformVersion();
  }
}
