package com.example.methodchanneldemo

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "test"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
                when(call.method){
                    "getPlatformVersion" -> getPlatformVersion(result)
                    "getCalculation" -> getCalculation(call, result)
                    else ->  result.notImplemented()
                }
        }
    }

    private fun getPlatformVersion(result: MethodChannel.Result) {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
    }

    private fun getCalculation(call: MethodCall, result: MethodChannel.Result) {
        val n1 = call.argument<Int>("first")
        val n2 = call.argument<Int>("second")

        if (n1 == null || n2 == null){
            result.error("ERROR",  "can only sum integers", null)
        }

        result.success(n1!! + n2!!)
    }
}
