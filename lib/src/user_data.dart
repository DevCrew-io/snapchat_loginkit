class _Data {
  final String? displayName;
  final String? avatarUrl;
  final String? externalId;
  final String? tokenId;
  final String? avatarId;
  final String? profileLink;

  _Data({this.displayName, this.avatarUrl, this.externalId, this.tokenId, this.avatarId, this.profileLink});

  factory _Data.fromMap(Map<Object?, Object?> map) => _Data(
      displayName: map['displayName'] != null ? map['displayName'] as String : null,
      avatarUrl: map["avatarUrl"] != null ? map["avatarUrl"] as String : null,
      externalId: map['externalId'] != null ? map['externalId'] as String : null,
      avatarId: map['avatarId'] != null ? map['avatarId'] as String : null,
      profileLink: map['profileLink'] != null ? map['profileLink'] as String : null,
      tokenId: map['tokenId'] != null ? map['tokenId'] as String : null);
}

class UserDataResponse {
  final int code;
  final String message;
  final _Data? data;

  UserDataResponse({this.code = 0, this.message = "", this.data});

  factory UserDataResponse.fromMap(Map<Object?, Object?> map) => UserDataResponse(
        code: map['code'] as int? ?? 0,
        message: map['message'] as String? ?? "",
        data: map['data'] != null ? _Data.fromMap(map['data'] as Map<Object?, Object?>) : null,
      );
}
