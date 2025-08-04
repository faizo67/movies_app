import 'package:flutter/services.dart';

class NativeServices {
  static const MethodChannel _methodChannel = MethodChannel(
    'com.example.device/method',
  );
  static const EventChannel _eventChannel = EventChannel(
    'com.example.device/clock',
  );

  // Battery
  static Future<int> getBatteryLevel() async {
    final int battery = await _methodChannel.invokeMethod('getBatteryLevel');
    return battery;
  }

  // Storage
  static Future<Map<String, dynamic>> getStorageInfo() async {
    final result = await _methodChannel.invokeMethod('getStorageInfo');
    return Map<String, dynamic>.from(result);
  }

  // Clock Stream
  static Stream<String> clockStream() {
    return _eventChannel.receiveBroadcastStream().map(
      (event) => event.toString(),
    );
  }
}
