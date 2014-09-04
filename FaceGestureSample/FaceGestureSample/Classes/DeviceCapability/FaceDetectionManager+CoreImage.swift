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
    
    func detectFeatureFromImage(faceImage:CIImage){
        var options = NSDictionary()
        if FGDetectionType.toRaw() & FGdetectionTypeEnum.FGdetectionTypeEyesBlink.toRaw() > 0{
            options.setValue("YES", forKey: CIDetectorEyeBlink)
        }
        if FGDetectionType.toRaw() & FGdetectionTypeEnum.FGdetectionTypeEyesBlink.toRaw() > 0{
            options.setValue("YES", forKey: CIDetectorSmile)
        }
        var features  = faceDetector.featuresInImage(faceImage, options: options)
        if(features.count > 0){
            var faceFeature = features[0] as CIFaceFeature
            self.delegate?.faceDetector!(self, didDetectfeature: faceFeature)
        }
        
    }
}
