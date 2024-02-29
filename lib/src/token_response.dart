import 'package:snapchat_loginkit/src/snapchat_response.dart';

class TokenResponse extends SnapchatResponse {
  String? token;

  TokenResponse({super.code, super.message, this.token});

  factory TokenResponse.fromMap(Map<Object?, Object?> map) => TokenResponse(
      code: map['code'] as int? ?? 0,
      message: map['message'] as String? ?? "",
      token: map['token'] as String?);
}
