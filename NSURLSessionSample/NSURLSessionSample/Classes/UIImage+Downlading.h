//
//  UIImage+Downlading.h
//  NSURLSessionSample
//
//  Created by Saurav Nagpal on 17/11/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

#import "SHDownloadingDelegate.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIImage(UIImage_Downlading)

+ (void) imageDownloadWithUrl:(NSURL*)url onCompletion:(SHDownloadCompletionBlock)block;

@end
