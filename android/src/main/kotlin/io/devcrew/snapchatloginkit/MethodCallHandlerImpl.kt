package io.devcrew.snapchatloginkit

import android.util.Log
import com.snap.loginkit.LoginResultCallback
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
        when(call.method) {
            Method.startTokenGrant -> {
                startTokenGrant()
            }
            Method.addLoginStateCallback -> {
                addLoginStateCallback()
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

    private fun startTokenGrant() {
        snapLogin.startTokenGrant()
    }

    private fun logout() {
        snapLogin.clearToken()
    }

    private fun addLoginStateCallback() {
        snapLogin.addLoginStateCallback(object : LoginStateCallback {
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

        })
    }

    private object Method {
        const val startTokenGrant = "startTokenGrant"
        const val addLoginStateCallback = "addLoginStateCallback"
        const val logout = "logout"

        object Callback {
            const val onStart = "onStart"
            const val onSuccess = "onSuccess"
            const val onFailure = "onFailure"
            const val onLogout = "onLogout"
        }
    }
}