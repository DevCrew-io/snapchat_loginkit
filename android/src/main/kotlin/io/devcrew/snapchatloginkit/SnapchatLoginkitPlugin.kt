package io.devcrew.snapchatloginkit

import com.snap.loginkit.SnapLogin
import com.snap.loginkit.SnapLoginProvider

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel

/** SnapchatLoginkitPlugin */
class SnapchatLoginkitPlugin : FlutterPlugin {

    private lateinit var channel: MethodChannel

    private var snapLogin: SnapLogin? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "snapchat_loginkit")
        snapLogin = SnapLoginProvider.get(flutterPluginBinding.applicationContext)
        channel.setMethodCallHandler(
            MethodCallHandlerImpl(snapLogin = snapLogin!!, channel = channel)
        )
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        snapLogin = null
    }

}
