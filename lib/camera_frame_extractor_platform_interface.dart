import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'camera_frame_extractor_method_channel.dart';

abstract class CameraFrameExtractorPlatform extends PlatformInterface {
  /// Constructs a CameraFrameExtractorPlatform.
  CameraFrameExtractorPlatform() : super(token: _token);

  static final Object _token = Object();

  static CameraFrameExtractorPlatform _instance = MethodChannelCameraFrameExtractor();

  /// The default instance of [CameraFrameExtractorPlatform] to use.
  ///
  /// Defaults to [MethodChannelCameraFrameExtractor].
  static CameraFrameExtractorPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CameraFrameExtractorPlatform] when
  /// they register themselves.
  static set instance(CameraFrameExtractorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
