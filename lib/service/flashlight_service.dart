import 'package:flutter/services.dart';

class FlashlightService {
  static const _platform = MethodChannel('com.example.flashlight/torch');

  Future<void> turnOn() async {
    await _platform.invokeMethod('turnOn');
  }

  Future<void> turnOff() async {
    await _platform.invokeMethod('turnOff');
  }
}
