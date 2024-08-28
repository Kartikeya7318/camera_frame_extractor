import 'package:flutter_test/flutter_test.dart';
import 'package:camera_frame_extractor/camera_frame_extractor.dart';
import 'package:camera_frame_extractor/camera_frame_extractor_platform_interface.dart';
import 'package:camera_frame_extractor/camera_frame_extractor_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCameraFrameExtractorPlatform
    with MockPlatformInterfaceMixin
    implements CameraFrameExtractorPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final CameraFrameExtractorPlatform initialPlatform = CameraFrameExtractorPlatform.instance;

  test('$MethodChannelCameraFrameExtractor is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCameraFrameExtractor>());
  });

  test('getPlatformVersion', () async {
    CameraFrameExtractor cameraFrameExtractorPlugin = CameraFrameExtractor();
    MockCameraFrameExtractorPlatform fakePlatform = MockCameraFrameExtractorPlatform();
    CameraFrameExtractorPlatform.instance = fakePlatform;

    expect(await cameraFrameExtractorPlugin.getPlatformVersion(), '42');
  });
}
