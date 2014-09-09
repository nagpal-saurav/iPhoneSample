//
//  FDReadingViewController.swift
//  FaceGestureSample
//
//  Created by Saurav Nagpal on 09/09/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

import UIKit

class FDReadingViewController: UIViewController, VideoCapturing {

    @IBOutlet weak var readingImageView: UIImageView!
    var videoCaptureSession     : VideoCaptureSession!
    var openCv                  : ExtensionFaceDetectionOpenCv!
    
    /*************************
    * View Ctrl Life Cycle
    *************************/
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool){
        super.viewDidAppear(animated);
        if videoCaptureSession == nil {
            videoCaptureSession = VideoCaptureSession(delegate:self);
            //videoCaptureSession.addFaceDetectionFeatureWithParentView(self.readingImageView);
        }
        if openCv == nil {
            openCv = ExtensionFaceDetectionOpenCv()
            openCv.detectFeature()
        }
        videoCaptureSession.startSession();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
