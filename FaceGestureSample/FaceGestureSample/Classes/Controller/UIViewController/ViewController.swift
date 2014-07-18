//
//  ViewController.swift
//  FaceGestureSample
//
//  Created by Saurav Nagpal on 14/07/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, VideoCapturing {
    var videoCaptureSession : VideoCaptureSession!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated);
        videoCaptureSession = VideoCaptureSession(delegate:self);
        videoCaptureSession.startSession();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func videoCaptureSession(session:VideoCaptureSession, failWithError:NSError?){
    
    }
    
    func videoCaptureSession(session:VideoCaptureSession, didCaptureImage:CIImage!){
        
    }
}

