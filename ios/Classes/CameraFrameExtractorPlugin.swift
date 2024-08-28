import Flutter
import UIKit
import AVFoundation

public class CameraFrameExtractorPlugin: NSObject, FlutterPlugin, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    var captureSession: AVCaptureSession?
    var videoOutput: AVCaptureVideoDataOutput?
    var device: AVCaptureDevice?
    var imagePath: String?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "camera_frame_extractor", binaryMessenger: registrar.messenger())
        let instance = CameraFrameExtractorPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "startCamera":
            startCamera()
            result(nil)
        case "stopCamera":
            stopCamera()
            result(nil)
        case "captureFrame":
            if let args = call.arguments as? [String: Any],
               let path = args["path"] as? String {
                self.imagePath = path
                result(nil)
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Path not provided", details: nil))
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    func startCamera() {
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = .medium
        
        device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
        
        guard let device = device else { return }
        
        do {
            let input = try AVCaptureDeviceInput(device: device)
            captureSession?.addInput(input)
        } catch {
            print("Error setting device input: \(error)")
            return
        }
        
        videoOutput = AVCaptureVideoDataOutput()
        videoOutput?.setSampleBufferDelegate(self, queue: DispatchQueue(label: "camera_frame_queue"))
        captureSession?.addOutput(videoOutput!)
        
        captureSession?.startRunning()
    }
    
    func stopCamera() {
        captureSession?.stopRunning()
        captureSession = nil
    }
    
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let path = imagePath else { return }
        
        let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
        CVPixelBufferLockBaseAddress(pixelBuffer, .readOnly)
        
        let baseAddress = CVPixelBufferGetBaseAddress(pixelBuffer)
        let dataSize = CVPixelBufferGetDataSize(pixelBuffer)
        
        let data = Data(bytes: baseAddress!, count: dataSize)
        do {
            try data.write(to: URL(fileURLWithPath: path))
            print("Image buffer saved at \(path)")
        } catch {
            print("Failed to save image buffer: \(error)")
        }
        
        CVPixelBufferUnlockBaseAddress(pixelBuffer, .readOnly)
        imagePath = nil
    }
}
