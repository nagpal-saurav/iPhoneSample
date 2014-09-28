//
//  FDImageView.swift
//  FaceGestureSample
//
//  Created by Saurav Nagpal on 27/08/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

import UIKit

class FDImageScrollView: UIScrollView {
    
    var imageView : UIImageView!
    var image : UIImage! {
        willSet(newImage) {
            self.imageView.image = newImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentMode = UIViewContentMode.ScaleAspectFit
        self.minimumZoomScale = 1.0
        self.maximumZoomScale = 9.0
        self.zoomScale = 1.0
        self.contentSize = imageView.bounds.size
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.imageView = UIImageView()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
