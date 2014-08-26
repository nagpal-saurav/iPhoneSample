//
//  FDError.swift
//  FaceGestureSample
//
//  Created by Saurav Nagpal on 28/07/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

import Foundation

class FDError: NSError {
    let  fddomain = "com.facedetection.errordomain"
    var  errorDescription:Dictionary<Int, String> =
    [   appErrorCodeEnum.cameraDoesNotExist.toRaw()  :  "Application is unable to find camera on device",
        appErrorCodeEnum.frontCameraNotFound.toRaw()  : "Application require front camera to recognize gesture",
        appErrorCodeEnum.inputDeviceNotFound.toRaw()  : "Application is unable to find input device",
        appErrorCodeEnum.outputDeviceNotFound.toRaw() : "Application is unable to find input device"
    ]
    
    init(code: appErrorCodeEnum.Raw) {
        if let value = errorDescription[code]{
            var info:NSDictionary = NSDictionary(object: value, forKey: NSLocalizedDescriptionKey)
            super.init(domain: fddomain, code: code, userInfo: info);
        }else{
            super.init(domain: fddomain, code: code, userInfo: nil);
        }
    }

    required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
    }
}
