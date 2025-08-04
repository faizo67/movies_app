package com.example.device_info_app

import android.content.Context
import android.os.BatteryManager
import android.os.Bundle
import android.os.Environment
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import java.text.SimpleDateFormat
import java.util.*
import kotlin.concurrent.fixedRateTimer

class MainActivity: FlutterActivity() {
    private val METHOD_CHANNEL = "com.example.device/method"
    private val EVENT_CHANNEL = "com.example.device/clock"
    private var clockTimer: Timer? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // METHOD CHANNEL
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, METHOD_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "getBatteryLevel" -> {
                        val bm = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
                        val battery = bm.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
                        result.success(battery)
                    }
                    "getStorageInfo" -> {
                        val free = Environment.getExternalStorageDirectory().usableSpace
                        val total = Environment.getExternalStorageDirectory().totalSpace
                        val map = mapOf("free" to free, "total" to total)
                        result.success(map)
                    }
                    else -> result.notImplemented()
                }
            }

        // EVENT CHANNEL (Clock)
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENT_CHANNEL)
            .setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    clockTimer = fixedRateTimer("clock", initialDelay = 0, period = 1000) {
                        val time = SimpleDateFormat("HH:mm:ss", Locale.getDefault()).format(Date())
                        events?.success(time)
                    }
                }

                override fun onCancel(arguments: Any?) {
                    clockTimer?.cancel()
                }
            })
    }
}
