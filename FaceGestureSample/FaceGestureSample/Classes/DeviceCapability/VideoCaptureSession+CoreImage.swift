//
//  VideoCaptureSession+CoreImage.swift
//  FaceGestureSample
//
//  Created by Saurav Nagpal on 04/09/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

import CoreImage
import AVFoundation

extension VideoCaptureSession {

    func addFaceDetectionFeatureWithCoreImage(){
        var rgbOutputSettings = [ kCVPixelBufferPixelFormatTypeKey : kCMPixelFormat_32BGRA ]
        self.videoOutput = AVCaptureVideoDataOutput()
        self.videoOutput.videoSettings = rgbOutputSettings
        
        if self.captureSession.canAddOutput(self.videoOutput) == false{
            tearDownCoreImageFaceDetection();
            var error = FDError(code: appErrorCodeEnum.coreVideooutputNotAdded.toRaw());
            self.delegate?.videoCaptureSession!(self, failWithError: error)
            return
        }
        self.videoOutput.alwaysDiscardsLateVideoFrames = true
        var videoDataOutputQueue = dispatch_queue_create("VideoDataOutputQueue", DISPATCH_QUEUE_SERIAL);
        self.videoOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
        self.captureSession.addOutput(self.videoOutput)
        self.videoOutput.connectionWithMediaType(AVMediaTypeVideo).enabled = true
    }
    
    func tearDownCoreImageFaceDetection(){
        if (self.videoOutput != nil){
            self.captureSession.removeOutput(self.videoOutput)
        }
        self.videoOutput = nil
    }

    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        var imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        var attachmentMode : UInt32 = UInt32(kCMAttachmentMode_ShouldPropagate)
        var attachments = CMCopyDictionaryOfAttachments(kCFAllocatorDefault, sampleBuffer, attachmentMode).takeUnretainedValue() as NSDictionary
        var image = CIImage(CVPixelBuffer: imageBuffer, options: attachments)
        self.delegate?.videoCaptureSession!(self, captureOutputFromSession: image)
  }
}
