package io.devcrew.snapchatloginkit

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
        snapLogin.startTokenGrant(object : LoginResultCallback {
            override fun onStart() {
                channel.invokeMethod(Method.Callback.onStart, null)
            }

            override fun onSuccess(token: String) {
                channel.invokeMethod(Method.Callback.onSuccess, token)
            }

            override fun onFailure(e: LoginException) {
                e.printStackTrace()
                channel.invokeMethod(Method.Callback.onFailure, e)
            }

        })
    }

    private fun addLoginStateCallback() {
        snapLogin.addLoginStateCallback(object : LoginStateCallback {
            override fun onStart() {
                TODO("Not yet implemented")
            }

            override fun onSuccess(p0: String) {
                TODO("Not yet implemented")
            }

            override fun onFailure(p0: LoginException) {
                TODO("Not yet implemented")
            }

            override fun onLogout() {
                TODO("Not yet implemented")
            }

        })
    }

    private object Method {
        const val startTokenGrant = "startTokenGrant"
        const val addLoginStateCallback = "addLoginStateCallback"

        object Callback {
            const val onStart = "onStart"
            const val onSuccess = "onSuccess"
            const val onFailure = "onFailure"
            const val onLogout = "onLogout"
        }
    }
}