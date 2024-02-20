class UserData {
  final String? displayName;
  final String? bitmoji;
  final String? externalId;
  final String? tokenId;

  UserData({this.displayName, this.bitmoji, this.externalId, this.tokenId});

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      displayName: map['displayName'],
      bitmoji: map['bitmoji'],
      externalId: map['externalId'],
      tokenId: map['tokenId'],
    );
  }
}

class UserDataResponse {
  final int code;
  final String message;
  final UserData? userData;

  UserDataResponse({this.code = 0, this.message = "", this.userData});

  factory UserDataResponse.fromMap(Map<String, dynamic> map) {
    return UserDataResponse(
      code: map['code'] ?? 0,
      message: map['message'] ?? "",
      userData: map['jsonStringData'] != null ? UserData.fromMap(map['jsonStringData']) : null,
    );
  }
}
