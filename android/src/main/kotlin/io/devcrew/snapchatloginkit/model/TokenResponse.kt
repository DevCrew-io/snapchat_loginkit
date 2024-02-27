package io.devcrew.snapchatloginkit.model

class TokenResponse(override var code: Int = 200, override var message: String = "Success") : SnapchatResponse {
    var token: String? = null
    override fun toMap(): Map<String, Any?> = mapOf(
        "code" to code,
        "message" to message,
        "token" to token
    )
}