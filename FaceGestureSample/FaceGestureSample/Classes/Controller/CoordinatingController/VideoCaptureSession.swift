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
import CoreMedia

@objc protocol VideoCapturing{
    optional func videoCaptureSession(session:VideoCaptureSession, failWithError error:NSError?)
    optional func videoCaptureSession(session:VideoCaptureSession, didDetectFaceObject metaObejct:AnyObject!)
    optional func videoCaptureSession(session:VideoCaptureSession, captureOutputFromSession image:CIImage!)
}

@objc class VideoCaptureSession : NSObject, AVCaptureMetadataOutputObjectsDelegate, AVCaptureVideoDataOutputSampleBufferDelegate{
    var delegate                :VideoCapturing?
    var captureSession          :AVCaptureSession!
    var videoPreviewViewLayer   :AVCaptureVideoPreviewLayer!
    var metaDataOutput          :AVCaptureMetadataOutput!
    var videoOutput             :AVCaptureVideoDataOutput!
    /*************************
    * Session Initlization
    *************************/
    init(delegate:VideoCapturing){
        super.init()
        self.delegate = delegate;
        self.setUpCaptureSession()
        self.initVideoPreviewLayer()
    }
    
    func setUpCaptureSession(){
        captureSession = AVCaptureSession();
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone{
            captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        }else{
            var error = FDError(code: appErrorCodeEnum.cameraDoesNotExist.toRaw());
            self.delegate?.videoCaptureSession!(self, failWithError: error);
        }
        self.updateCameraSelection()
    }
    
    func startSession(){
        self.captureSession.startRunning()
    }
    
    func stopSession(){
        self.captureSession.stopRunning()
    }
    
    /*************************
    * camera Selection Code
    *************************/
    func updateCameraSelection(){
        self.captureSession.beginConfiguration()
        //remove Old Input
        var inputs = self.captureSession.inputs as [AVCaptureInput]
        for input in inputs{
            self.captureSession.removeInput(input)
        }
        var newInput = self.pickCamera()
        if let inputDevice = newInput{
            self.captureSession.addInput(inputDevice)
        }else{
            var error = FDError(code: appErrorCodeEnum.frontCameraNotFound.toRaw());
            self.delegate?.videoCaptureSession!(self, failWithError: error);
        }
        self.captureSession.commitConfiguration()
    }

    func pickCamera()->AVCaptureDeviceInput?{
        var inputDevice:AVCaptureDeviceInput?
        var devices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
        var isDeviceFound : Bool = false;
        for device : AnyObject in devices{
            if device.position == AVCaptureDevicePosition.Front{
                var error : NSError? = nil
                var actualDevice  = device as AVCaptureDevice
               /* actualDevice.lockForConfiguration(&error);
                actualDevice.activeVideoMinFrameDuration = CMTimeMake(1, 1)
                actualDevice.activeVideoMaxFrameDuration = CMTimeMake(1, 1)
                actualDevice.unlockForConfiguration()*/
                var deviceInput:AVCaptureDeviceInput = AVCaptureDeviceInput.deviceInputWithDevice(actualDevice, error:&error) as AVCaptureDeviceInput
                if error == nil && captureSession.canAddInput(deviceInput) {
                    inputDevice = deviceInput
                }else{
                    var error = FDError(code: appErrorCodeEnum.inputDeviceNotFound.toRaw());
                    self.delegate?.videoCaptureSession!(self, failWithError: error);
                }
                break;
            }
        }
        return inputDevice
    }
    
    /*************************
    * Video Preview Layer
    *************************/
    func initVideoPreviewLayer(){
        videoPreviewViewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewViewLayer.backgroundColor = UIColor.blackColor().CGColor
        videoPreviewViewLayer.videoGravity = AVLayerVideoGravityResizeAspect
        videoPreviewViewLayer.opacity = 0.0;
        
    }
    
}