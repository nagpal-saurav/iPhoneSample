//
//  UIImage+Downlading.m
//  NSURLSessionSample
//
//  Created by Saurav Nagpal on 17/11/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

#import "UIImage+Downlading.h"

@implementation UIImage(UIImage_Downlading)

+ (void) imageDownloadWithUrl:(NSURL*)url onCompletion:(SHDownloadCompletionBlock)block{
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfig.allowsCellularAccess = NO;
    [sessionConfig setHTTPAdditionalHeaders:
     @{@"Accept": @"application/json"}];
    // 3
    sessionConfig.timeoutIntervalForRequest = 30.0;
    sessionConfig.timeoutIntervalForResource = 60.0;
    sessionConfig.HTTPMaximumConnectionsPerHost = 1;
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig
                                                          delegate:nil
                                                     delegateQueue:nil];
    NSURLSessionDownloadTask *getImageTask = [session downloadTaskWithURL:url completionHandler:^(NSURL *location,
                                                                                                  NSURLResponse *response,
                                                                                                NSError *error){
        if(error != nil){
            NSLog(@"Application error:%@",error.localizedDescription);
        }
        else if(response == nil){
            NSLog(@"Application is not able to acess the page. Please check the url");
        }
        UIImage* image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
        if(image){
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
        }
    }];
    
    [getImageTask resume];
}

@end
