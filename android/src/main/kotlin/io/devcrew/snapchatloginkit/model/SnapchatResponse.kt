package io.devcrew.snapchatloginkit.model

interface SnapchatResponse {
    var code: Int
    var message: String
    fun toMap(): Map<String, Any?>
}