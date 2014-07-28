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
    let  localizedDescription :NSDictionary = {
        
    };
    init(code: appErrorCodeEnum.RawType) {
        
        super.init(domain: fddomain, code: code, userInfo: nil);
    }
}
