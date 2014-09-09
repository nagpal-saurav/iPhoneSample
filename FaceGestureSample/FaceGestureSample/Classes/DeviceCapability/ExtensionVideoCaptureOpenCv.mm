//
//  VideoCaptureSession+OpenCv.m
//  FaceGestureSample
//
//  Created by Saurav Nagpal on 08/09/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//
#import <objc/runtime.h>
#import <opencv2/opencv.hpp>
#import "opencv2/highgui/cap_ios.h"
#import "FaceGestureSample-swift.h"
#import "ExtensionVideoCaptureOpenCv.h"


@implementation VideoCaptureSession(openCV)
@dynamic videoCamera;

#pragma mark -
#pragma mark Setter Getter
- (CvVideoCamera *)videoCamera {
    return objc_getAssociatedObject(self, @selector(videoCamera));
}

- (void)setLaserUnicorns:(CvVideoCamera *)videoCamera {
    objc_setAssociatedObject(self, @selector(videoCamera), videoCamera, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void) addFaceDetectionFeatureWithParentView:(UIView*)view{
    self.videoCamera = [[CvVideoCamera alloc] initWithParentView:view];
    self.videoCamera.delegate = self;
    self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;
    self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset352x288;
    self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self.videoCamera.defaultFPS = 30;
}

#pragma open CV Delagte
- (void)processImage:(cv::Mat&)image{
    
}

@end
