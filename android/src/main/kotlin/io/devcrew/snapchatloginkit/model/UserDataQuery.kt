package io.devcrew.snapchatloginkit.model

import com.snap.loginkit.BitmojiQuery;
import com.snap.loginkit.UserDataQuery;

data class UserFetchDataQuery(
    val isWithDisplayName: Boolean,
    val isWithExternalId: Boolean,
    val isWithIdToken: Boolean,
    val isWithProfileLink: Boolean,
    val isWithBitmojiAvatarId: Boolean,
    val isWithBitmojiAvatarUrl: Boolean
) {
    constructor(map: Map<String, Any?>) : this(
        isWithDisplayName = map["isWithDisplayName"] as? Boolean ?: false,
        isWithExternalId = map["isWithExternalId"] as? Boolean ?: false,
        isWithIdToken = map["isWithIdToken"] as? Boolean ?: false,
        isWithProfileLink = map["isWithProfileLink"] as? Boolean ?: false,
        isWithBitmojiAvatarId = map["isWithBitmojiAvatarId"] as? Boolean ?: false,
        isWithBitmojiAvatarUrl = map["isWithBitmojiAvatarUrl"] as? Boolean ?: false
    )

    fun prepareUserDataQuery(): UserDataQuery {
        val builder = UserDataQuery.newBuilder()
        val bitmojiQueryBuilder: BitmojiQuery.Builder = BitmojiQuery.newBuilder()
        val bitmojiQuery: BitmojiQuery
        if (isWithDisplayName) {
            builder.withDisplayName()
        }
        if (isWithExternalId) {
            builder.withExternalId()
        }
        if (isWithIdToken) {
            builder.withIdToken()
        }

        if (isWithBitmojiAvatarId || isWithBitmojiAvatarUrl) {
            if (isWithBitmojiAvatarId) {
                bitmojiQueryBuilder.withAvatarId()
            }
            if (isWithBitmojiAvatarUrl) {
                bitmojiQueryBuilder.withTwoDAvatarUrl()
            }
            bitmojiQuery = bitmojiQueryBuilder.build()
            builder.withBitmoji(bitmojiQuery)
        }
        return builder.build()
    }
}



