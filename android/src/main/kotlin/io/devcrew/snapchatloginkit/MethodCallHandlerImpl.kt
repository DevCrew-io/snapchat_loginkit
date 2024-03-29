package io.devcrew.snapchatloginkit

import android.util.Log
import com.snap.loginkit.AccessTokenResultCallback
import com.snap.loginkit.FirebaseCustomTokenResultCallback
import com.snap.loginkit.LoginStateCallback
import com.snap.loginkit.SnapLogin
import com.snap.loginkit.UserDataResultCallback
import com.snap.loginkit.exceptions.AccessTokenException
import com.snap.loginkit.exceptions.FirebaseCustomTokenException
import com.snap.loginkit.exceptions.LoginException
import com.snap.loginkit.exceptions.UserDataException
import com.snap.loginkit.models.UserDataResult
import io.devcrew.snapchatloginkit.model.TokenResponse
import io.devcrew.snapchatloginkit.model.UserFetchDataQuery
import io.devcrew.snapchatloginkit.model.UserResponse
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


class MethodCallHandlerImpl(
    private val snapLogin: SnapLogin,
    private val channel: MethodChannel
) : MethodCallHandler {
    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            Method.login -> {
                login()
            }

            Method.addLoginStateCallback -> {
                addLoginStateCallback()
            }

            Method.removeLoginStateCallback -> {
                removeLoginStateCallback()
            }

            Method.logout -> {
                logout()
            }

            Method.isUserLoggedIn -> {
                isUserLoggedIn(result)
            }

            Method.fetchUserData -> {
                fetchUserData(call.arguments as? Map<String, Any>, result)
            }

            Method.fetchAccessToken -> {
                fetchAccessToken(result)
            }

            Method.hasAccessToScope -> {
                hasAccessToScope(call.arguments as? String, result)
            }

            Method.loginWithFirebase -> {
                loginWithFirebase(result)
            }

            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    private fun login() {
        addLoginStateCallback()
        snapLogin.startTokenGrant()
    }

    private fun logout() {
        snapLogin.clearToken()
    }

    private fun isUserLoggedIn(result: Result) {
        result.success(snapLogin.isUserLoggedIn())
    }

    private fun fetchUserData(arguments: Map<String, Any>?, result: Result) {
        val query = arguments?.let { UserFetchDataQuery(it) }
        val userResponse = UserResponse()
        query?.let {
            snapLogin.fetchUserData(it.prepareUserDataQuery(), object : UserDataResultCallback {
                override fun onSuccess(userDataResult: UserDataResult) {
                    if (userDataResult.data == null) {
                        return
                    }
                    if (userDataResult.data!!.meData != null) {
                        val data = userDataResult.data!!.meData!!
                        userResponse.userData = mapOf(
                            "displayName" to data.displayName,
                            "avatarId" to data.bitmojiData?.avatarId,
                            "avatarUrl" to data.bitmojiData?.twoDAvatarUrl,
                            "externalId" to data.externalId,
                            "tokenId" to data.idToken,
                            "profileLink" to ""
                        )
                    }
                    result.success(userResponse.toMap())
                }

                override fun onFailure(exception: UserDataException) {
                    userResponse.code = exception.statusCode
                    userResponse.message = exception.message.toString()
                    result.success(userResponse.toMap())
                }
            })
        }
    }

    private fun fetchAccessToken(result: Result) {
        val response = TokenResponse()
        snapLogin.fetchAccessToken(object : AccessTokenResultCallback {
            override fun onSuccess(accessToken: String) {
                response.token = accessToken
                result.success(response.toMap())
            }

            override fun onFailure(exception: AccessTokenException) {
                response.code = exception.statusCode
                response.message = exception.message.toString()
                result.success(response.toMap())
            }
        })
    }

    private fun hasAccessToScope(scope: String?, result: Result) =
        result.success(snapLogin.hasAccessToScope(scope ?: ""))

    private fun loginWithFirebase(result: Result) {
        val response = TokenResponse()
        snapLogin.startFirebaseTokenGrant(object : FirebaseCustomTokenResultCallback {
            override fun onSuccess(token: String) {
                response.token = token
                result.success(response.toMap())
            }

            override fun onFailure(exception: FirebaseCustomTokenException) {
                response.code = exception.statusCode
                response.message = exception.message.toString()
                result.success(response.toMap())
            }
        })
    }

    private val loginStateCallback = object : LoginStateCallback {
        override fun onStart() {
            Log.d("SnapChatLoginKit", "onStart")
            channel.invokeMethod(Method.Callback.onStart, null)
        }

        override fun onSuccess(token: String) {
            Log.d("SnapChatLoginKit", "onSuccess")
            channel.invokeMethod(Method.Callback.onSuccess, token)
        }

        override fun onFailure(e: LoginException) {
            Log.d("SnapChatLoginKit", "onFailure")
            channel.invokeMethod(Method.Callback.onFailure, e.message ?: "Snapchat login failed")
        }

        override fun onLogout() {
            Log.d("SnapChatLoginKit", "onLogout")
            channel.invokeMethod(Method.Callback.onLogout, null)
        }
    }

    private fun addLoginStateCallback() {
        snapLogin.addLoginStateCallback(loginStateCallback)
    }

    private fun removeLoginStateCallback() {
        snapLogin.removeLoginStateCallback(loginStateCallback)
    }

    private object Method {
        const val login = "login"
        const val addLoginStateCallback = "addLoginStateCallback"
        const val removeLoginStateCallback = "removeLoginStateCallback"
        const val logout = "logout"
        const val isUserLoggedIn = "isUserLoggedIn"
        const val fetchUserData = "fetchUserData"
        const val fetchAccessToken = "fetchAccessToken"
        const val hasAccessToScope = "hasAccessToScope"
        const val loginWithFirebase = "loginWithFirebase"

        object Callback {
            const val onStart = "onStart"
            const val onSuccess = "onSuccess"
            const val onFailure = "onFailure"
            const val onLogout = "onLogout"
        }
    }
}

