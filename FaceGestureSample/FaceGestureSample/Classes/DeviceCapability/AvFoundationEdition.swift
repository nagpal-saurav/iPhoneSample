//
//  AvFoundationEdition.swift
//  FaceGestureSample
//
//  Created by Saurav Nagpal on 24/08/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

import AVFoundation
import Foundation

class AvFoundationEdition{
    var  metaDataOutput:AVCaptureMetadataOutput!
    var  captureSession:AVCaptureSession!
    
    init(session:AVCaptureSession){
       self.captureSession = session
    }
    
    func addFaceDetectionFeatureWithDelegate(#delegate:AVCaptureMetadataOutputObjectsDelegate){
        self.metaDataOutput = AVCaptureMetadataOutput()
        if(captureSession.canAddOutput(self.metaDataOutput)){
            self.metaDataOutput.setMetadataObjectsDelegate(delegate, queue: dispatch_get_main_queue())
            self.captureSession.addOutput(self.metaDataOutput)
            var supportedMetaData:NSArray = self.metaDataOutput.availableMetadataObjectTypes
            if supportedMetaData.containsObject(AVMetadataObjectTypeFace) == false{
                self.tearDownAVFaceDetection()
                return
            }
            self.metaDataOutput.metadataObjectTypes = [AVMetadataObjectTypeFace]
            
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
}