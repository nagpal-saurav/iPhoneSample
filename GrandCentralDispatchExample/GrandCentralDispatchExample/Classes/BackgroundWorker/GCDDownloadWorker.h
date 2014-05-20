//
//  GCDBackgroundWorker.h
//  GrandCentralDispatchExample
//
//  Created by Saurav Nagpal on 04/05/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

#define  lowPriorityLabel     "com.sample.lowPriority"
#define  highPriorityLabel    "com.sample.highPriority"

#import <dispatch/dispatch.h>

@class GCDDownloadWorker;
@class GCDTask;

@protocol GCDDownloading <NSObject>

@optional
- (void) backgroundWorker:(GCDDownloadWorker*)worker didCompleteWithTask:(GCDTask*)task;
- (void) backgroundWorker:(GCDDownloadWorker*)worker didFailForTask:(GCDTask*)task withError:(NSError*)error;

@end

@interface GCDDownloadWorker : NSObject

@property (nonatomic, weak)id<GCDDownloading>  delegate;

- (id) initWithDelegate:(id<GCDDownloading>)delegate;
- (void) addTask:(GCDTask*)task;
- (void) addHighPriorityTask:(GCDTask*)task;
- (void) addBarrierTask:(GCDTask*)task;

@end
