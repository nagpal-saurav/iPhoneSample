//
//  ViewController.swift
//  FaceGestureSample
//
//  Created by Saurav Nagpal on 14/07/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, VideoCapturing, FaceDetecting {
    var videoCaptureSession     : VideoCaptureSession!
    var faceDetectionManager    :FaceDetectionManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated);
        if videoCaptureSession == nil {
            videoCaptureSession = VideoCaptureSession(delegate:self);
            videoCaptureSession.startSession();
        }
        
        if faceDetectionManager == nil {
            faceDetectionManager = FaceDetectionManager(delegate: self)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func videoCaptureSession(session:VideoCaptureSession, failWithError:NSError?){
        UIAlertView(title: "good", message: "Has Mouse", delegate: nil, cancelButtonTitle: "Ok").show()
    }
    
    func videoCaptureSession(session:VideoCaptureSession, didCaptureImage image:CIImage!){
        self.faceDetectionManager.detectFeatureFromImage(image)
    }
    
    func faceDetector(detetor:FaceDetectionManager, didDetectMovment:faceMovementTypeEnum){
        
    }
}

