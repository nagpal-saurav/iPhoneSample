//
//  CoreImageDetection.swift
//  FaceGestureSample
//
//  Created by Saurav Nagpal on 31/08/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

import Foundation
import coreImage

extension FaceDetectionManager{
    
    func setFeatureDetectorOptions(){
        featureDetectorOptions = NSMutableDictionary()
        NSLog("%d",FGDetectionType)
        if (FGDetectionType & FGdetectionTypeEnum.FGdetectionTypeEyesBlink.toRaw()) > 0{
            featureDetectorOptions.setValue(NSNumber(bool: true), forKey: CIDetectorEyeBlink)
        }
        if (FGDetectionType & FGdetectionTypeEnum.FGdetectionTypeEyesBlink.toRaw()) > 0{
            featureDetectorOptions.setValue(NSNumber(bool: true), forKey: CIDetectorSmile)
        }
    }
    
    func detectFeatureFromImage(faceImage:CIImage){
        featureDetectorOptions.setValue(NSNumber(int: 6), forKey: CIDetectorImageOrientation)
        var features  = faceDetector.featuresInImage(faceImage, options: featureDetectorOptions)
        if(features.count > 0){
            var faceFeature = features[0] as CIFaceFeature
            if faceFeature.leftEyeClosed{
                var faceEvent = FaceEvent(detectedType: FGdetectionTypeEnum.FGdetectionTypeEyesBlink)
                faceEvent.addDetecttionDetail(FGEyeDetectionDetailEnum.FGEyeDetectionLeftEyeBlink.toRaw())
                self.delegate?.faceDetector!(self, didDetectEvent: faceEvent)
            }else if faceFeature.rightEyeClosed{
                var faceEvent = FaceEvent(detectedType: FGdetectionTypeEnum.FGdetectionTypeEyesBlink)
                faceEvent.addDetecttionDetail(FGEyeDetectionDetailEnum.FGEyeDetectionRightEyeBlink.toRaw())
                self.delegate?.faceDetector!(self, didDetectEvent: faceEvent)
            }
        }
        
    }
}
