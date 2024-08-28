import 'dart:async';
import 'package:flutter/services.dart';

class CameraFrameExtractor {
  static const MethodChannel _channel =
      const MethodChannel('camera_frame_extractor');

  static Future<void> startCamera() async {
    await _channel.invokeMethod('startCamera');
  }

  static Future<void> stopCamera() async {
    await _channel.invokeMethod('stopCamera');
  }

  static Future<void> captureFrame(String path) async {
    await _channel.invokeMethod('captureFrame', {'path': path});
  }
}
