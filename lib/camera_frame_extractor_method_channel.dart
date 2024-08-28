import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'camera_frame_extractor_platform_interface.dart';

/// An implementation of [CameraFrameExtractorPlatform] that uses method channels.
class MethodChannelCameraFrameExtractor extends CameraFrameExtractorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('camera_frame_extractor');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
