import 'package:snapchat_loginkit/src/snapchat_response.dart';

class User {
  final String? displayName;
  final String? avatarUrl;
  final String? externalId;
  final String? tokenId;
  final String? avatarId;
  final String? profileLink;

  User(
      {this.displayName,
      this.avatarUrl,
      this.externalId,
      this.tokenId,
      this.avatarId,
      this.profileLink});

  factory User.fromMap(Map<Object?, Object?> map) => User(
      displayName:
          map['displayName'] != null ? map['displayName'] as String : null,
      avatarUrl: map["avatarUrl"] != null ? map["avatarUrl"] as String : null,
      externalId:
          map['externalId'] != null ? map['externalId'] as String : null,
      avatarId: map['avatarId'] != null ? map['avatarId'] as String : null,
      profileLink:
          map['profileLink'] != null ? map['profileLink'] as String : null,
      tokenId: map['tokenId'] != null ? map['tokenId'] as String : null);
}

class UserResponse extends SnapchatResponse {
  User? user;

  UserResponse({super.code, super.message, this.user});

  factory UserResponse.fromMap(Map<Object?, Object?> map) => UserResponse(
      code: map['code'] as int? ?? 0,
      message: map['message'] as String? ?? "",
      user: map['user'] != null
          ? User.fromMap(map['user'] as Map<Object?, Object?>)
          : null);
}
