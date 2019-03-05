import 'dart:async';

import 'package:flutter/services.dart';

class FlutterNakama {
  static const MethodChannel _channel =
      const MethodChannel('flutter_nakama');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
