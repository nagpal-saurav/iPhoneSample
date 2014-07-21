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
    func videoCaptureSession(session:VideoCaptureSession, failWithError:NSError?)
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
                self.delegate?.videoCaptureSession(self, failWithError: nil);
                self.captureSession = nil;
            }
            // get the output for doing face detection.
            self.captureVideoOutput.connectionWithMediaType(AVMediaTypeVideo).enabled = true
        }else{
            self.delegate?.videoCaptureSession(self, failWithError: nil);
        }
        
    }
    
    func startSession(){
        self.captureSession.startRunning()
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