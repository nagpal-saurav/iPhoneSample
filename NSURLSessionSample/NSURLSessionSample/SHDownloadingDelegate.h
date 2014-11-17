//
//  SHDownloadingDelegate.h
//  NSURLSessionSample
//
//  Created by Saurav Nagpal on 17/11/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifndef NSURLSessionSample_SHDownloadingDelegate_h
#define NSURLSessionSample_SHDownloadingDelegate_h

typedef void (^SHDownloadCompletionBlock)(NSURL *location, NSURLResponse *response, NSError *error);

#endif
