//
//  VideoCaptureSession.swift
//  FaceGestureSample
//
//  Created by Saurav Nagpal on 15/07/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

protocol videoCapturing{
    func videoCaptureSession(session:VideoCaptureSession, failWithError:NSError?)
}

class VideoCaptureSession{
    var delegate       :videoCapturing?
    var captureSession :AVCaptureSession!
    init(){
     
        self.setUpCaptureSession();
    }
    
    func setUpCaptureSession(){
        captureSession = AVCaptureSession();
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone{
            captureSession.sessionPreset = AVCaptureSessionPreset640x480
        }else{
            self.delegate?.videoCaptureSession(self, failWithError: nil);
        }
        
        var devices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
        var isDeviceFound : Bool = false;
        for device : AnyObject in devices{
            if device.position == AVCaptureDevicePosition.Front{
                isDeviceFound = true;
                addInputDevice(device as AVCaptureDevice);
                break;
            }
        }
        if isDeviceFound == false{
            self.delegate?.videoCaptureSession(self, failWithError: nil);
        }
    }
    
    func addInputDevice(device:AVCaptureDevice){
        var error : NSErrorPointer!
        var deviceInput:AVCaptureDeviceInput = AVCaptureDeviceInput.deviceInputWithDevice(device, error:error) as AVCaptureDeviceInput
        if error == nil && captureSession.canAddInput(deviceInput) {
            self.captureSession.addInput(deviceInput)
        }else{
            self.delegate?.videoCaptureSession(self, failWithError: nil);
        }
    }
    
}