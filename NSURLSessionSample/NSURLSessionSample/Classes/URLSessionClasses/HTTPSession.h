//
//  HTTPSession.h
//  NSURLSessionSample
//
//  Created by Saurav Nagpal on 17/11/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPSession : NSObject<NSURLSessionDataDelegate, NSURLSessionDownloadDelegate>

- (void) startAsynRequestWithURLString:(NSString*)urlString;
- (void) startDownloadingDataWithUrlString:(NSString*)urlString;

@end
