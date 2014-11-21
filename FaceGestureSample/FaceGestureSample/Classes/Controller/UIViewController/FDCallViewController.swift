//
//  FDCallViewController.swift
//  FaceGestureSample
//
//  Created by Saurav Nagpal on 21/11/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

import UIKit

class FDCallViewController: UIViewController, VideoCapturing, FaceDetecting {
    @IBOutlet weak var tableView: UITableView!
    var videoCaptureSession     : VideoCaptureSession!
    var faceDetectionManager    : FaceDetectionManager!
    var selctedIndex            : NSIndexPath!
    var contactList:NSArray!
    /*******************************
    *   View Controller Life Cycle
    ********************************/
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.contactList = ["Saurav", "Gaurav", "Sanjay","Neeraj"]
        self.selctedIndex = NSIndexPath(forRow: 0, inSection: 0);
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.selectRowAtIndexPath(self.selctedIndex, animated: true, scrollPosition: UITableViewScrollPosition.None)
    }
    override func viewDidAppear(animated: Bool){
        super.viewDidAppear(animated);
        if videoCaptureSession == nil {
            videoCaptureSession = VideoCaptureSession(delegate:self);
            videoCaptureSession.addFaceDetectionFeatureWithAvFoundation();
            videoCaptureSession.addFaceDetectionFeatureWithCoreImage();
            self.addVideoPreviewLayer()
        }
        if faceDetectionManager == nil {
            var detectionType = FGdetectionTypeEnum.FGdetectionTypeEyesBlink.toRaw() | FGdetectionTypeEnum.FGdetectionTypeSmile.toRaw()
            faceDetectionManager = FaceDetectionManager(delegate: self, withdetectionType: detectionType);
        }
        
        videoCaptureSession.startSession();
        
    }
    
    /*******************************
    *   UITable View Datasource
    ********************************/
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int{
        return 1;
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        return self.contactList.count;
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!{
        
        var cell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(FaceDetectionConstant.featureCell) as UITableViewCell!
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: FaceDetectionConstant.featureCell)
        }
        
        cell!.textLabel?.text = self.contactList.objectAtIndex(indexPath.row) as? String
        return cell;
    }
    /*******************************
    *   UITable View Delegate
    ********************************/
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){
        var storyboard = UIStoryboard(name: FaceDetectionConstant.storyBoardName, bundle: nil)
        var featureViewController:UIViewController!
        switch indexPath.row{
        case 0:
            featureViewController = storyboard.instantiateViewControllerWithIdentifier(FaceDetectionConstant.galleryViewIdentifier) as UIViewController
        case 1:
            featureViewController = storyboard.instantiateViewControllerWithIdentifier(FaceDetectionConstant.readingViewIdentifier) as UIViewController
        default:
            return;
        }
        self.navigationController?.pushViewController(featureViewController , animated: true)
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
    
    func videoCaptureSession(session:VideoCaptureSession, didDetectFaceObject metaObejct:AnyObject!){
        self.faceDetectionManager.detectFeatureFromFaceObject(metaObejct)
    }
    
    func videoCaptureSession(session:VideoCaptureSession, captureOutputFromSession image:CIImage!){
        self.faceDetectionManager.detectFeatureFromImage(image)
    }
    
    /*************************
    * FaceDetection Delegate
    *************************/
    
    func faceDetector(detetor:FaceDetectionManager, didDetectMovment movement:UInt32){
        if let faceMovement = faceMovementTypeEnum.fromRaw(movement){
            
        }
    }
    
    func faceDetector(detetor: FaceDetectionManager, didDetectEvent event: FaceEvent) {
        var detectedType = event.detectedType
        switch detectedType{
        case .FGdetectionTypeEyesBlink:
            if let eyeBlink = FGEyeDetectionDetailEnum.fromRaw(event.detectedDetail!){
                switch eyeBlink{
                case .FGEyeDetectionLeftEyeBlink, .FGEyeDetectionRightEyeBlink:
                    var url = NSURL(string: "Call://09953391471");
                    UIApplication.sharedApplication().openURL(url);
                    
                }
            }
        default:
            return
        }
        
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
}
