class UserData {
  final String? displayName;
  final String? bitmoji;
  final String? externalId;
  final String? tokenId;

  UserData({this.displayName, this.bitmoji, this.externalId, this.tokenId});

  factory UserData.fromMap(Map<Object?, Object?> map) => UserData(
      displayName: map['displayName'] != null ? map['displayName'] as String : null,
      bitmoji: map["bitmoji"] != null ? map["bitmoji"] as String : null,
      externalId: map['externalId'] != null ? map['externalId'] as String : null,
      tokenId: map['tokenId'] != null ? map['tokenId'] as String : null);
}

class UserDataResponse {
  int code;
  String message;
  UserData? userData;

  UserDataResponse({this.code = 0, this.message = "", this.userData});

  factory UserDataResponse.fromMap(Map<Object?, Object?> map) => UserDataResponse(
        code: map['code'] as int? ?? 0,
        message: map['message'] as String? ?? "",
        userData: map['jsonStringData'] != null
            ? UserData.fromMap(map['jsonStringData'] as Map<Object?, Object?>)
            : null,
      );
}
