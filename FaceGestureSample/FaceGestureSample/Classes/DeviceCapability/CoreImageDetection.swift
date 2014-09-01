//
//  CoreImageDetection.swift
//  FaceGestureSample
//
//  Created by Saurav Nagpal on 31/08/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

import Foundation
import coreImage

class CoreImageDetection{
    
    var FGDetectionType:FGdetectionTypeEnum!
    var faceDetector   :CIDetector!
    init(directorWithType detectionType:FGdetectionTypeEnum){
        var context = CIContext(options: nil)
        var detectorOpts = [CIDetectorAccuracy : CIDetectorAccuracyHigh]
        faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: context, options: detectorOpts)
        FGDetectionType = detectionType
    }
    
    func detectFeatureFromImage(faceImage:CIImage, featureHandler:((feature:CIFaceFeature)->Void)?){
        var options = NSDictionary()
        if FGDetectionType.toRaw() & FGdetectionTypeEnum.FGdetectionTypeEyesBlink.toRaw() > 0{
            options.setValue("YES", forKey: CIDetectorEyeBlink)
        }
        if FGDetectionType.toRaw() & FGdetectionTypeEnum.FGdetectionTypeEyesBlink.toRaw() > 0{
            options.setValue("YES", forKey: CIDetectorSmile)
        }
        var features  = faceDetector.featuresInImage(faceImage, options: options)
        var faceFeature = features[0] as CIFaceFeature
        if(featureHandler != nil){
            featureHandler!(feature: faceFeature)
        }
        
    }
}
