#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint camera_frame_extractor.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'camera_frame_extractor'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter plugin for capturing camera frames and saving them as .bin files on iOS.'
  
  s.description      = <<-DESC
  The camera_frame_extractor plugin allows developers to capture raw camera frames on iOS devices and save them as .bin files. 
  It uses the AVFoundation framework to access the camera and process the frames.
  DESC
  
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain an i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
