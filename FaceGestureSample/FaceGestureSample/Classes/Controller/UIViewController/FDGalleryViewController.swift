//
//  ViewController.swift
//  FaceGestureSample
//
//  Created by Saurav Nagpal on 14/07/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

import UIKit

class FDGalleryViewController: UIViewController, VideoCapturing, FaceDetecting {
    var videoCaptureSession     : VideoCaptureSession!
    var faceDetectionManager    :FaceDetectionManager!
    
    /*************************
    * View Ctrl Life Cycle
    *************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool){
        super.viewDidAppear(animated);
        if videoCaptureSession == nil {
            videoCaptureSession = VideoCaptureSession(delegate:self);
            self.addVideoPreviewLayer()
        }
        if faceDetectionManager == nil {
            faceDetectionManager = FaceDetectionManager(delegate: self)
        }
        
        videoCaptureSession.startSession();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*************************
    * Utility Method
    *************************/
    func addVideoPreviewLayer(){
        var rootLayer = self.view.layer
        rootLayer.masksToBounds = true
        videoCaptureSession.videoPreviewViewLayer.frame = rootLayer.frame
        rootLayer.addSublayer(videoCaptureSession.videoPreviewViewLayer)
    }
    /*************************
    * Video Delegate
    *************************/
    func videoCaptureSession(session:VideoCaptureSession, failWithError error:NSError?){
        if let actualError = error{
            Utility.showAlert(title: FaceDetectionConstant.errorTitle, withMessage: actualError.localizedDescription, viewCtrl: self, handler: nil);
            NSLog(actualError.localizedDescription)
        }
       
    }
    
    func videoCaptureSession(session:VideoCaptureSession, didCaptureFaceObject faceObject:AnyObject!){
        self.faceDetectionManager.detectFeatureFromImage(image)
    }
    
    /*************************
    * FaceDetection Delegate
    *************************/
    func faceDetector(detetor:FaceDetectionManager, didDetectMovment:faceMovementTypeEnum){
        
    }
}

