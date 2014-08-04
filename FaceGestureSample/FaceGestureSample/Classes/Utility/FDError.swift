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
    var  errorDescription:Dictionary<appErrorCodeEnum, String> =
    [   appErrorCodeEnum.cameraDoesNotExist  :"Application is unable to find camera on device",
        appErrorCodeEnum.frontCameraNotFound  : "Application require front camera to recognize gesture",
        appErrorCodeEnum.inputDeviceNotFound  : "Application is unable to find input device",
        appErrorCodeEnum.outputDeviceNotFound : "Application is unable to find input device"
    ]
    
    init(code: appErrorCodeEnum.RawType) {
        if let validErrorCode = appErrorCodeEnum.fromRaw(code){
            var info:NSDictionary?;
            var value = errorDescription[validErrorCode];
            info = NSDictionary(object: value!, forKey: NSLocalizedDescriptionKey);
            super.init(domain: fddomain, code: code, userInfo: info);
            NSLog(self.domain);
        }else{
            super.init(domain: fddomain, code: code, userInfo: nil);
        }
    }
}
