//
//  FaceDetectionManager.swift
//  FaceGestureSample
//
//  Created by Saurav Nagpal on 14/07/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//


import Foundation
import UIKit
import AVFoundation

protocol FaceDetecting{
    func faceDetector(detetor:FaceDetectionManager, didDetectMovment movment:faceMovementTypeEnum)
}

class FaceDetectionManager{
    var delegate     : FaceDetecting?
    
    init(delegate:FaceDetecting){
        self.delegate = delegate;
    }
    
    func detectFeatureFromFaceObject(faceObject:AnyObject){
        var adjustedFaceObject = faceObject as AVMetadataFaceObject
        if(adjustedFaceObject.hasYawAngle){
             println("The angle is \(adjustedFaceObject.yawAngle)")
        }
    }
}