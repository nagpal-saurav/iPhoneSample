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

@objc protocol FaceDetecting{
    optional func faceDetector(detetor:FaceDetectionManager, didDetectMovment movment:UInt32)
    optional func faceDetector(detetor:FaceDetectionManager, didDetectfeature feature:CIFaceFeature)
}

class FaceDetectionManager : NSObject{
    var delegate              : FaceDetecting?
    var minYawAngleSwipeRight : CGFloat = 45
    var stillYawAngle         : CGFloat = 0
    var maxYawAngleSwipeLeft  : CGFloat = 315
    var lastMovement          : faceMovementTypeEnum = faceMovementTypeEnum.faceMoveTypeNone
    var FGDetectionType       :FGdetectionTypeEnum!
    var faceDetector          :CIDetector!
    

    
    init(directorWithType detectionType:FGdetectionTypeEnum){
        var context = CIContext(options: nil)
        var detectorOpts = [CIDetectorAccuracy : CIDetectorAccuracyHigh]
        faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: context, options: detectorOpts)
        FGDetectionType = detectionType
    }
    init(delegate:FaceDetecting){
        self.delegate = delegate;
    }
    
}