//
//  FaceDetectionManager.swift
//  FaceGestureSample
//
//  Created by Saurav Nagpal on 14/07/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//


import Foundation
import CoreImage;

class FaceDetectionManager{
    var faceDetector : CIDetector!
    
    init(){
        var context = CIContext();
        var detectorOptions = NSDictionary(object: CIDetectorAccuracyHigh, forKey: CIDetectorAccuracy)
        faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: context, options: detectorOptions)
    }
}