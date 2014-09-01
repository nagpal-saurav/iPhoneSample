//
//  ViewController.swift
//  FaceGestureSample
//
//  Created by Saurav Nagpal on 14/07/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

import UIKit

class FDGalleryViewController: UIViewController, VideoCapturing, FaceDetecting {
    @IBOutlet weak var galleyScrollView: UIScrollView!
    
    var videoCaptureSession     : VideoCaptureSession!
    var faceDetectionManager    : FaceDetectionManager!
    var imageList               : NSArray!
    var currentPageIndex        = 0
    /*************************
    * View Ctrl Life Cycle
    *************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.imageList = Utility.listFromPlistFileLocal(fileName: FaceDetectionConstant.galleryImageName)
    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool){
        super.viewDidAppear(animated);
        loadScrollViewWithDefault()
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
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        videoCaptureSession.stopSession()
    }
    
    /*************************
    * View Update Method
    *************************/
    func loadScrollViewWithDefault(){
        //We need to load 2 images initally
        var scrollViewFrame = self.galleyScrollView.frame
        var positionX = scrollViewFrame.size.width * CGFloat.convertFromIntegerLiteral(self.imageList.count)
        galleyScrollView.contentSize = CGSizeMake(positionX, scrollViewFrame.size.height)
        for index:Int in 0...1 {
            var postionX  = CGFloat.convertFromIntegerLiteral(index)  * scrollViewFrame.size.width
            var imageViewRect = CGRectMake(postionX , 0, scrollViewFrame.size.width, scrollViewFrame.size.height)
            var imageView = FDImageView(frame: imageViewRect)
            var imageName = self.imageList.objectAtIndex(index) as String
            imageView.image = UIImage(named: imageName)
            galleyScrollView.addSubview(imageView)
        }
        self.currentPageIndex = 0
    }
    
    func loadScrollViewForIndex(index:Int){
        var scrollViewFrame = self.galleyScrollView.frame
        
    }
    
    func swipeScrollViewToDirection(movement:faceMovementTypeEnum){
        switch movement{
        case .faceMoveLeft:
            NSLog("Move right")
            self.currentPageIndex -= 1
            if(self.currentPageIndex <= 0){
                return
            }
        case .faceMoveRight:
            self.currentPageIndex += 1
            if(self.currentPageIndex >= imageList.count){
                return
            }
        default:
            return
        }
        
        var scrollViewFrame = self.galleyScrollView.frame
        var postionX  = CGFloat.convertFromIntegerLiteral(self.currentPageIndex)  * scrollViewFrame.size.width
        var newPoint = CGPointMake(postionX, 0);
        self.galleyScrollView.setContentOffset(newPoint, animated: true)
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
        self.faceDetectionManager.detectFeatureFromFaceObject(faceObject)
    }
    
    /*************************
    * FaceDetection Delegate
    *************************/
    func faceDetector(detetor:FaceDetectionManager, didDetectMovment movement:UInt32){
        if let faceMovement = faceMovementTypeEnum.fromRaw(movement){
            swipeScrollViewToDirection(faceMovement)
        }
    }
}

