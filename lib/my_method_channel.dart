import 'package:flutter/services.dart';

/// VERY IMPORTANT TO USE THE SAME NAMES ON BOTH SIDES
///
class MyMethodChannel{
  static const MethodChannel _channel = const MethodChannel('test');

  static Future getPlatformVersion() async {
    final version = await _channel.invokeMethod('getPlatformVersion');

    return version;
  }

  // example with arguments
  static Future<double> getCalculation(int n1, int n2) async {
    final sum = await _channel.invokeMethod('getCalculation', {
      "first": n1,
      "second": n2,
    });

    return sum;
  }
}