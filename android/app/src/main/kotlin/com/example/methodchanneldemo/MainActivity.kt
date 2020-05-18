package com.example.methodchanneldemo

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "test"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
                when(call.method){
                    "getPlatformVersion" -> getPlatformVersion(call, result)
                    "getCalculation" -> getCalculation(call, result)
                    else ->  result.notImplemented()
                }
        }
    }

    private fun getPlatformVersion(@NonNull Result result){
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
    }

    private fun getCalculation(Method call, @NonNull Result result){
        val n1 = call.argument<Int>("n1")
        val n2 = call.argument<Int>("n2")

        if (n1 == null || n2 == null){
            result.error("ERROR",  "can only sum integers", null)
        }

        result.success(n1 + n2)
    }
}
