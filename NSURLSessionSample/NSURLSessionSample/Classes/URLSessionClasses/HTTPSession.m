//
//  HTTPSession.m
//  NSURLSessionSample
//
//  Created by Saurav Nagpal on 17/11/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPSession.h"


@implementation HTTPSession

- (void) startAsynRequestWithURLString:(NSString*)urlString{
    NSURLSession* urlSession = [NSURLSession sharedSession];
    NSURL* url = [NSURL URLWithString:urlString];
    [[urlSession dataTaskWithURL:url completionHandler:^(NSData *data,
                                                        NSURLResponse *response,
                                                        NSError *error){
        if(error != nil){
            NSLog(@"Application error:%@",error.localizedDescription);
        }
        else if(response == nil){
            NSLog(@"Application is not able to acess the page. Please check the url");
        }else if(data == nil){
            NSLog(@"No Data Found");
        }
    }] resume];
}

- (void) startDownloadingDataWithUrlString:(NSString*)urlString{
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfig.allowsCellularAccess = NO;
    [sessionConfig setHTTPAdditionalHeaders:
     @{@"Accept": @"application/json"}];
    // 3
    sessionConfig.timeoutIntervalForRequest = 30.0;
    sessionConfig.timeoutIntervalForResource = 60.0;
    sessionConfig.HTTPMaximumConnectionsPerHost = 1;
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig
                                  delegate:self
                             delegateQueue:nil];
    NSURLSessionDownloadTask *getImageTask = [session downloadTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSURL *location,
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

-(void)URLSession:(NSURLSession *)session
     downloadTask:(NSURLSessionDownloadTask *)downloadTask
     didWriteData:(int64_t)bytesWritten
totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    NSLog(@"%f / %f", (double)totalBytesWritten,
          (double)totalBytesExpectedToWrite);
}

-(void)URLSession:(NSURLSession *)session
     downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    // use code above from completion handler
}

@end
