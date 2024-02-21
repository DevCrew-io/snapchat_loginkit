package io.devcrew.snapchatloginkit

import android.util.Log
import com.snap.loginkit.LoginStateCallback
import com.snap.loginkit.SnapLogin
import com.snap.loginkit.UserDataResultCallback
import com.snap.loginkit.exceptions.LoginException
import com.snap.loginkit.exceptions.UserDataException
import com.snap.loginkit.models.UserDataResult
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
        val userData = UserData()
        val userDataResponse = UserDataResponse()
        query?.let {
            val userDataQuery = it.fetchUserData()
            snapLogin.fetchUserData(userDataQuery, object : UserDataResultCallback {
                override fun onSuccess(userDataResult: UserDataResult) {
                    if (userDataResult.data == null) {
                        return
                    }
                    if (userDataResult.data!!.meData != null) {
                        val data = userDataResult.data!!.meData!!
                        userData.displayName = data.displayName
                        userData.bitmoji = data.bitmojiData?.twoDAvatarUrl
                        userData.externalId = data.externalId
                        userData.tokenId = data.idToken
                        userDataResponse.code = 200
                        userDataResponse.message = "Success"
                        userDataResponse.userDataMap = userData.toMap()
                    }
                    result.success(userDataResponse.toMap())
                }

                override fun onFailure(exception: UserDataException) {
                    userDataResponse.code = exception.statusCode
                    userDataResponse.message = exception.message.toString()
                    userDataResponse.userDataMap = mapOf()
                    result.success(userDataResponse.toMap())
                }
            })
        }
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

        object Callback {
            const val onStart = "onStart"
            const val onSuccess = "onSuccess"
            const val onFailure = "onFailure"
            const val onLogout = "onLogout"
        }
    }
}

