//
//  VideoCaptureSession+AvFoundation.swift
//  FaceGestureSample
//
//  Created by Saurav Nagpal on 04/09/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

import AVFoundation


extension VideoCaptureSession{

    func addFaceDetectionFeatureWithAvFoundation(){
        self.metaDataOutput = AVCaptureMetadataOutput()
        if(captureSession.canAddOutput(self.metaDataOutput)){
            self.metaDataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
            self.captureSession.addOutput(self.metaDataOutput)
            var supportedMetaData:NSArray = self.metaDataOutput.availableMetadataObjectTypes
            if supportedMetaData.containsObject(AVMetadataObjectTypeFace) == false{
                self.tearDownAVFaceDetection()
                 var error = FDError(code: appErrorCodeEnum.coreVideooutputNotAdded.toRaw());
                 self.delegate?.videoCaptureSession(self, failWithError: error)
                return
            }
            self.metaDataOutput.metadataObjectTypes = [AVMetadataObjectTypeFace]
            self.metaDataOutput.connectionWithMediaType(AVMediaTypeMetadata).enabled = true
        }else{
            self.tearDownAVFaceDetection()
        }
    }
    
    func tearDownAVFaceDetection(){
        if (self.metaDataOutput != nil){
            self.captureSession.removeOutput(self.metaDataOutput)
        }
        self.metaDataOutput = nil
    }

    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        var faceObjects = metadataObjects as [AVMetadataFaceObject]
        for  faceObject:AVMetadataFaceObject in faceObjects{
            var adjustedFaceObject = self.videoPreviewViewLayer.transformedMetadataObjectForMetadataObject(faceObject) as AVMetadataFaceObject
            if(adjustedFaceObject.hasYawAngle){
                self.delegate?.videoCaptureSession(self, didDetectFaceObject: adjustedFaceObject)
            }
            
        }
    }

}
