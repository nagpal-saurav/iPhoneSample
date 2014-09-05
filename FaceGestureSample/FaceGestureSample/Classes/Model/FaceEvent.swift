//
//  FaceEvent.swift
//  FaceGestureSample
//
//  Created by Saurav Nagpal on 05/09/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

import UIKit

class FaceEvent: NSObject {
    var detectedType : FGdetectionTypeEnum
    var detectedDetail:UInt32?
    
    init(detectedType:FGdetectionTypeEnum){
        self.detectedType = detectedType
    }
    
    func addDetecttionDetail(detail:UInt32){
        self.detectedDetail = detail
    }
    
}
