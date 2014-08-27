//
//  FDImageView.swift
//  FaceGestureSample
//
//  Created by Saurav Nagpal on 27/08/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

import UIKit

class FDImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentMode = UIViewContentMode.ScaleAspectFit
        
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    

}
