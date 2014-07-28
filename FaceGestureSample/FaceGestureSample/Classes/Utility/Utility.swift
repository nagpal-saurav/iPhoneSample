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
        alertView.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: handler))
        viewCtrl.presentViewController(alertView, animated: true, completion: nil)
    }
    
}