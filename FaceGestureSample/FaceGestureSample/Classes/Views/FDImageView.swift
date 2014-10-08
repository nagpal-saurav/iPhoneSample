//
//  FDImageView.swift
//  FaceGestureSample
//
//  Created by Saurav Nagpal on 27/08/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

import UIKit

class FDImageScrollView: UIScrollView, UIScrollViewDelegate {
    
    var imageView : UIImageView!
    init(frame: CGRect, withImageName imageName:String) {
        super.init(frame: frame)
        self.contentMode = UIViewContentMode.ScaleAspectFit
        self.minimumZoomScale = 1.0
        self.maximumZoomScale = 9.0
        self.zoomScale = 1.0
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.initImageView(imageName)
        self.contentSize = imageView.bounds.size;
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initImageView(imageName:String){
        var imageFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
        imageView = UIImageView(frame: imageFrame)
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        let newImageName = imageName.stringByReplacingOccurrencesOfString(".jpg", withString: "", options: nil, range:nil)
        var filePath = NSBundle.mainBundle().pathForResource(newImageName, ofType: ".jpg")
        imageView.image = UIImage(contentsOfFile: filePath!)
        self.addSubview(imageView)
    }
}
