package io.devcrew.snapchatloginkit

import android.util.Log
import com.snap.loginkit.LoginStateCallback
import com.snap.loginkit.SnapLogin
import com.snap.loginkit.exceptions.LoginException
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

            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    private fun login() {
        snapLogin.startTokenGrant()
        addLoginStateCallback()
    }

    private fun logout() {
        snapLogin.clearToken()
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
            channel.invokeMethod(Method.Callback.onFailure, e)
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

        object Callback {
            const val onStart = "onStart"
            const val onSuccess = "onSuccess"
            const val onFailure = "onFailure"
            const val onLogout = "onLogout"
        }
    }
}