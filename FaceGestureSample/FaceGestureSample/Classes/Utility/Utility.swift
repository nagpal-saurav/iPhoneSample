//
//  Utility.swift
//  FaceGestureSample
//
//  Created by Saurav Nagpal on 28/07/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

import UIKit
import Foundation

class Utility{
    class func showAlert(#title:NSString, withMessage message:NSString, viewCtrl:UIViewController ,handler: ((UIAlertAction!) -> Void)?){
        var alertView = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertView.addAction(UIAlertAction(title: FaceDetectionConstant.alertInfoBtnTitle, style: UIAlertActionStyle.Default, handler: handler))
        viewCtrl.presentViewController(alertView, animated: true, completion: nil)
    }
    
    class func showAlertWithConfirmation(#title:NSString, withMessage message:NSString, viewCtrl:UIViewController , alertCancelTitle cancelTitle:String,confirmButtonTitle cnfmTitle:NSString ,handler: ((UIAlertAction!) -> Void)?){
        var alertView = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertView.addAction(UIAlertAction(title: cancelTitle, style: UIAlertActionStyle.Default, handler: handler))
        alertView.addAction(UIAlertAction(title: cnfmTitle, style: UIAlertActionStyle.Default, handler: handler))
        viewCtrl.presentViewController(alertView, animated: true, completion: nil)
    }
    
    class func showActionSheet(#title:NSString, withMessage message:NSString, viewCtrl:UIViewController , options:[String] ,handler: ((UIAlertAction!) -> Void)?){
        var actionSheet = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.ActionSheet)
        var count = 1;
        for option in options{
            var actionStyle = UIAlertActionStyle.Default
            if count == countElements(options){
                actionStyle = UIAlertActionStyle.Cancel
            }
            actionSheet.addAction(UIAlertAction(title: option, style: actionStyle, handler: handler))
            count++
        }
        viewCtrl.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    class func dictionaryFromPlistFileLocal(#fileName:String)->NSDictionary{
        var filePath = NSBundle.mainBundle().pathForResource(fileName, ofType: FaceDetectionConstant.plistType)
        var fileContent = NSDictionary(contentsOfFile: filePath!);
        return fileContent;
    }
    
    class func listFromPlistFileLocal(#fileName:String)->NSArray{
        var filePath = NSBundle.mainBundle().pathForResource(fileName, ofType: FaceDetectionConstant.plistType)
        var fileContent = NSArray(contentsOfFile: filePath!);
        return fileContent;
    }
    
}