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

protocol VideoCapturing{
    func videoCaptureSession(session:VideoCaptureSession, failWithError error:NSError?)
    func videoCaptureSession(session:VideoCaptureSession, didCaptureImage image:CIImage!)
}

class VideoCaptureSession : NSObject, AVCaptureVideoDataOutputSampleBufferDelegate{
    var delegate                :VideoCapturing?
    var captureSession          :AVCaptureSession!
    var captureVideoOutput      :AVCaptureVideoDataOutput!
    var captureVideoOutputQueue :dispatch_queue_t!
    
    init(delegate:VideoCapturing){
        super.init()
        self.delegate = delegate;
        self.setUpCaptureSession()
    }
    
    
    
    func setUpCaptureSession(){
        captureSession = AVCaptureSession();
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone{
            captureSession.sessionPreset = AVCaptureSessionPreset640x480
        }else{
            var error = FDError(code: appErrorCodeEnum.cameraDoesNotExist.toRaw());
            self.delegate?.videoCaptureSession(self, failWithError: error);
        }
        
        var devices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
        var isDeviceFound : Bool = false;
        for device : AnyObject in devices{
            if device.position == AVCaptureDevicePosition.Front{
                if(addInputDevice(device as AVCaptureDevice)){
                    isDeviceFound = true;
                }
                break;
            }
        }
        if isDeviceFound {
            self.captureVideoOutput = AVCaptureVideoDataOutput();
            var videoOptions : NSDictionary = NSDictionary(object: NSNumber(integer:  kCMPixelFormat_32BGRA), forKey: kCVPixelBufferPixelFormatTypeKey)
            self.captureVideoOutput.videoSettings = videoOptions
            self.captureVideoOutput.alwaysDiscardsLateVideoFrames = true;
            self.captureVideoOutputQueue = dispatch_queue_create(FaceDetectionConstant.queueCreate, DISPATCH_QUEUE_SERIAL)
            self.captureVideoOutput.setSampleBufferDelegate(self, queue: self.captureVideoOutputQueue);
            if  self.captureSession.canAddOutput(self.captureVideoOutput) {
                self.captureSession.addOutput(self.captureVideoOutput);
            }else{
                var error = FDError(code: appErrorCodeEnum.outputDeviceNotFound.toRaw());
                self.delegate?.videoCaptureSession(self, failWithError: error);
                self.captureSession = nil;
            }
            // get the output for doing face detection.
            self.captureVideoOutput.connectionWithMediaType(AVMediaTypeVideo).enabled = true
        }else{
            var error = FDError(code: appErrorCodeEnum.frontCameraNotFound.toRaw());
            self.delegate?.videoCaptureSession(self, failWithError: error);
        }
        
    }
    
    func startSession(){
        self.captureSession.startRunning()
    }
    
    func addInputDevice(device:AVCaptureDevice) -> Bool{
        var error : NSErrorPointer!
        var deviceInput:AVCaptureDeviceInput = AVCaptureDeviceInput.deviceInputWithDevice(device, error:error) as AVCaptureDeviceInput
        if error == nil && captureSession.canAddInput(deviceInput) {
            self.captureSession.addInput(deviceInput)
        }else{
            var error = FDError(code: appErrorCodeEnum.inputDeviceNotFound.toRaw());
            self.delegate?.videoCaptureSession(self, failWithError: error);
            return false
        }
        return true
    }
    
    /*************************
    * DELEGATE
    *************************/
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!){
        var pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer).takeRetainedValue() as CVImageBufferRef
        var imageAttachments = CMCopyDictionaryOfAttachments(kCFAllocatorDefault, sampleBuffer, CMAttachmentMode(kCMAttachmentMode_ShouldPropagate))
        var image = CIImage(CVImageBuffer: pixelBuffer, options: imageAttachments.takeRetainedValue())
        if imageAttachments != nil {
            CFRelease(imageAttachments);
        }
        self.delegate?.videoCaptureSession(self, didCaptureImage: image);
    }
    
}