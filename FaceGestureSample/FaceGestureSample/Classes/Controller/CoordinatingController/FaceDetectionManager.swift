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
    var minYawAngleSwipeRight : CGFloat = 45
    var stillYawAngle         : CGFloat = 0
    var maxYawAngleSwipeLeft  : CGFloat = 315
    var lastMovement          : faceMovementTypeEnum = faceMovementTypeEnum.faceMoveTypeNone
    
    init(delegate:FaceDetecting){
        self.delegate = delegate;
    }
    
    func detectFeatureFromFaceObject(faceObject:AnyObject){
        var adjustedFaceObject = faceObject as AVMetadataFaceObject
        if(adjustedFaceObject.hasYawAngle){
            if(adjustedFaceObject.yawAngle > self.minYawAngleSwipeRight){
                if(lastMovement != faceMovementTypeEnum.faceMoveTypeNone){
                    return
                }
                lastMovement = faceMovementTypeEnum.faceMoveRight
                self.delegate?.faceDetector(self, didDetectMovment: faceMovementTypeEnum.faceMoveRight)
            }else if(adjustedFaceObject.yawAngle > self.maxYawAngleSwipeLeft){
                if(lastMovement != faceMovementTypeEnum.faceMoveTypeNone){
                    return
                }
                lastMovement = faceMovementTypeEnum.faceMoveLeft
                self.delegate?.faceDetector(self, didDetectMovment: faceMovementTypeEnum.faceMoveLeft)
            }else if(adjustedFaceObject.yawAngle == self.stillYawAngle){
                lastMovement = faceMovementTypeEnum.faceMoveTypeNone
            }
        }
    }
}