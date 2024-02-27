package io.devcrew.snapchatloginkit.model

class UserResponse(override var code: Int = 200, override var message: String = "Success") : SnapchatResponse {
    var userData: Map<String, Any?>? = null
    override fun toMap(): Map<String, Any?> = mapOf(
        "code" to code,
        "message" to message,
        "user" to userData
    )
}