//
//  cameraOpenView.swift
//  20230206circleTracker
//
//  Created by yook on 2023/02/06.
//

import SwiftUI
import AVFoundation

func recordSetting() {
    let captureSession = AVCaptureSession()
    captureSession.sessionPreset = .high
    let videoDevice = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back)
}

func bestDevice(in position: AVCaptureDevice.Position) -> AVCaptureDevice {
  var deviceTypes: [AVCaptureDevice.DeviceType]!
  
  if #available(iOS 11.1, *) {
    deviceTypes = [.builtInTrueDepthCamera, .builtInDualCamera, .builtInWideAngleCamera]
  } else {
    deviceTypes = [.builtInDualCamera, .builtInWideAngleCamera]
  }
  
  let discoverySession = AVCaptureDevice.DiscoverySession(
    deviceTypes: deviceTypes,
    mediaType: .video,
    position: .unspecified
  )
  
  let devices = discoverySession.devices
  guard !devices.isEmpty else { fatalError("Missing capture devices.")}
  
  return devices.first(where: { device in device.position == position })!
}

let videoDevice = bestDevice(in: .back)

private func setupSession() {
  do {
    captureSession.beginConfiguration() // 1

    // 2
    let videoInput = try AVCaptureDeviceInput(device: videoDevice!)
    if captureSession.canAddInput(deviceInput) {
      captureSession.addInput(deviceInput)
    }

    // 3
    let audioDevice = AVCaptureDevice.default(for: AVMediaType.audio)!
    let audioInput = try AVCaptureDeviceInput(device: audioDevice)
    if captureSession.canAddInput(audioInput) {
      captureSession.addInput(audioInput)
    }

    // 4
    videoOutput = AVCaptureMovieFileOutput()
    if captureSession.canAddOutput(videoOutput) {
      captureSession.addOutput(videoOutput)
    }

    captureSession.commitConfiguration() // 5
  }
  catch let error as NSError {
    NSLog("\(error), \(error.localizedDescription)")
  }
}


struct cameraOpenView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct cameraOpenView_Previews: PreviewProvider {
    static var previews: some View {
        cameraOpenView()
    }
}
