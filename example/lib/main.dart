import 'package:camera_frame_extractor/camera_frame_extractor.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Start the camera
  await CameraFrameExtractor.startCamera();

  // Get the documents directory
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = '${documentsDirectory.path}/frame.bin';

  // Save the frame to the documents directory
  await CameraFrameExtractor.captureFrame(path);

  // Stop the camera
  await CameraFrameExtractor.stopCamera();
}
