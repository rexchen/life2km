//
//  ViewController.swift
//  life2km
//
//  Created by Rex on 8/25/15.
//  Copyright (c) 2015 huijun.org. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var camera = "back"
    var cameraType = AVCaptureDevicePosition.Back
    let captureSession = AVCaptureSession()
    var previewLayer : AVCaptureVideoPreviewLayer?
    var captureDevice : AVCaptureDevice?

    @IBOutlet weak var switchButton: UIButton!
    @IBOutlet weak var cameraView: UIView!

    @IBAction func switchCamera(sender: AnyObject) {
        if camera == "back" {
            camera = "front"
            cameraType = AVCaptureDevicePosition.Front
            switchButton.setTitle("Front", forState: UIControlState.Normal)
        }
        else{
            camera = "back"
            cameraType = AVCaptureDevicePosition.Back
            switchButton.setTitle("Back", forState: UIControlState.Normal)
        }
        let currentCameraInput: AVCaptureInput = captureSession.inputs[0] as! AVCaptureInput
        captureSession.removeInput(currentCameraInput)
        captureSession.stopRunning()
        previewLayer!.removeFromSuperlayer()
        reloadCamera();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadCamera();
    }
    
    func reloadCamera() {
        let devices = AVCaptureDevice.devices()
        for device in devices {
            if (device.hasMediaType(AVMediaTypeVideo)) {
                if(device.position == cameraType) {
                    captureDevice = device as? AVCaptureDevice
                    if captureDevice != nil {
                        beginSession()
                    }
                }
            }
        }
    }
    
    func beginSession() {
        var err : NSError? = nil
        captureSession.addInput(AVCaptureDeviceInput(device: captureDevice, error: &err))
        
        if err != nil {
            println("error: \(err?.localizedDescription)")
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraView.layer.addSublayer(previewLayer)
        previewLayer?.frame = self.view.layer.frame
        captureSession.startRunning()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

