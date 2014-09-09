//
//  VideoCaptureSession+OpenCv.h
//  FaceGestureSample
//
//  Created by Saurav Nagpal on 08/09/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//


#import <Foundation/Foundation.h>

@protocol CvVideoCameraDelegate;
@class    CvVideoCamera;

@interface VideoCaptureSession(openCV) <CvVideoCameraDelegate>

@property (nonatomic, strong)CvVideoCamera     *videoCamera;

- (void) addFaceDetectionFeatureWithParentView:(UIView*)view;

@end
