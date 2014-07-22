//
//  FaceDetectionManager.swift
//  FaceGestureSample
//
//  Created by Saurav Nagpal on 14/07/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//


import Foundation
import UIKit
import CoreImage

protocol FaceDetecting{
    func faceDetector(detetor:FaceDetectionManager, didDetectMovment movment:faceMovementTypeEnum)
}

class FaceDetectionManager{
    var faceDetector : CIDetector!
    var delegate     : FaceDetecting?
    
    init(delegate:FaceDetecting){
        var context = CIContext();
        var detectorOptions = NSDictionary(object: CIDetectorAccuracyHigh, forKey: CIDetectorAccuracy)
        faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: context, options: detectorOptions)
        self.delegate = delegate;
    }
    
    func detectFeatureFromImage(image:CIImage){
        
        // make sure your device orientation is not locked.
        //var currentOrienatation = UIDevice.currentDevice().orientation
        var features = self.faceDetector.featuresInImage(image) as CIFaceFeature[];
        for faceFeature :CIFaceFeature  in features {
            var faceFrame = faceFeature.bounds;
        }
    }
}