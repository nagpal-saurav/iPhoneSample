//
//  AvFoundationEdition.swift
//  FaceGestureSample
//
//  Created by Saurav Nagpal on 24/08/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

import AVFoundation
import Foundation

extension FaceDetectionManager{

    func detectFeatureFromFaceObject(faceObject:AnyObject){
        var adjustedFaceObject = faceObject as AVMetadataFaceObject
        if(adjustedFaceObject.hasYawAngle){
            if(adjustedFaceObject.yawAngle >= self.minYawAngleSwipeRight && adjustedFaceObject.yawAngle < self.maxYawAngleInDirection){
                if(lastMovement != faceMovementTypeEnum.faceMoveTypeNone){
                    return
                }
                NSLog("adjusted Face Angle\(adjustedFaceObject.yawAngle)")
                lastMovement = faceMovementTypeEnum.faceMoveRight
                self.delegate?.faceDetector!(self, didDetectMovment: faceMovementTypeEnum.faceMoveRight.toRaw())
            }else if(adjustedFaceObject.yawAngle >= self.minYawAngleSwipeLeft){
                if(lastMovement != faceMovementTypeEnum.faceMoveTypeNone){
                    return
                }
                NSLog("adjusted Face Angle\(adjustedFaceObject.yawAngle)")
                lastMovement = faceMovementTypeEnum.faceMoveLeft
                self.delegate?.faceDetector!(self, didDetectMovment: faceMovementTypeEnum.faceMoveLeft.toRaw())
            }else if(adjustedFaceObject.yawAngle == -0.0 ){
                lastMovement = faceMovementTypeEnum.faceMoveTypeNone
            }
        }
    }
}