/// User Data Query model
class UserDataQuery {
  final bool isWithDisplayName;
  final bool isWithExternalId;
  final bool isWithIdToken;
  final bool isWithProfileLink;
  final bool isWithBitmojiAvatarId;
  final bool isWithBitmojiAvatarUrl;

  UserDataQuery({
    required this.isWithDisplayName,
    required this.isWithExternalId,
    required this.isWithIdToken,
    required this.isWithProfileLink,
    required this.isWithBitmojiAvatarId,
    required this.isWithBitmojiAvatarUrl,
  });

  Map<String, dynamic> toMap() => {
        'isWithDisplayName': isWithDisplayName,
        'isWithExternalId': isWithExternalId,
        'isWithIdToken': isWithIdToken,
        'isWithProfileLink': isWithProfileLink,
        'isWithBitmojiAvatarId': isWithBitmojiAvatarId,
        'isWithBitmojiAvatarUrl': isWithBitmojiAvatarUrl,
      };
}

/// User Data Query Builder model class
class UserDataQueryBuilder {
  bool _withDisplayName = false;
  bool _withExternalId = false;
  bool _withIdToken = false;
  bool _withProfileLink = false;
  bool _withBitmojiAvatarId = false;
  bool _withBitmojiAvatarUrl = false;

  UserDataQueryBuilder withDisplayName() {
    _withDisplayName = true;
    return this;
  }

  UserDataQueryBuilder withExternalId() {
    _withExternalId = true;
    return this;
  }

  UserDataQueryBuilder withIdToken() {
    _withIdToken = true;
    return this;
  }

  UserDataQueryBuilder withProfileLink() {
    _withProfileLink = true;
    return this;
  }

  UserDataQueryBuilder withBitmojiAvatarId() {
    _withBitmojiAvatarId = true;
    return this;
  }

  UserDataQueryBuilder withBitmojiAvatarUrl() {
    _withBitmojiAvatarUrl = true;
    return this;
  }

  UserDataQuery build() {
    return UserDataQuery(
      isWithDisplayName: _withDisplayName,
      isWithExternalId: _withExternalId,
      isWithIdToken: _withIdToken,
      isWithProfileLink: _withProfileLink,
      isWithBitmojiAvatarId: _withBitmojiAvatarId,
      isWithBitmojiAvatarUrl: _withBitmojiAvatarUrl,
    );
  }
}
