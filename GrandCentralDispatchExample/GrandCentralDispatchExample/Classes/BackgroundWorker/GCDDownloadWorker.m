//
//  GCDBackgroundWorker.m
//  GrandCentralDispatchExample
//
//  Created by Saurav Nagpal on 04/05/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

#import "GCDTask.h"
#import "GCDDownloadWorker.h"


@interface GCDDownloadWorker (PRIVATEMETHODS)

- (BOOL) saveData:(NSData*)data toPath:(NSString*)path;
- (void) performTask:(GCDTask*) task;
- (void) sendStatusTaskFail:(GCDTask*)task;

@end

@implementation GCDDownloadWorker{
    dispatch_queue_t        lowPriorityQueue; // For all the low priority task
    dispatch_queue_t        highPriorityQueue; //For high pro
}

- (id) initWithDelegate:(id<GCDDownloading>)delegate{
    self = [super init];
    if(self == nil)
        return nil;
    self.delegate = delegate;
    lowPriorityQueue  = dispatch_queue_create(lowPriorityLabel, DISPATCH_QUEUE_SERIAL);
    highPriorityQueue = dispatch_queue_create(highPriorityLabel, DISPATCH_QUEUE_SERIAL);
    dispatch_set_target_queue(lowPriorityQueue, highPriorityQueue);
    return self;
}

- (void) addTask:(GCDTask*)task{
    dispatch_async(lowPriorityQueue,  ^{
        [self performTask:task];
    });
}

- (void) addHighPriorityTask:(GCDTask*)task{
    dispatch_suspend(lowPriorityQueue);
    dispatch_async(highPriorityQueue, ^{
        [self performTask:task];
         dispatch_resume(lowPriorityQueue);
    });
}

- (void) addBarrierTask:(GCDTask*)task{
    dispatch_barrier_async(lowPriorityQueue, ^{
        [self performTask:task];
    });
}

#pragma mark -
#pragma Private Method

#pragma mark FileHandling
- (BOOL) saveData:(NSData*)data toPath:(NSString*)path{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSString* dataPath = [path stringByDeletingLastPathComponent];
    NSError* error = nil;
    if (![fileManager fileExistsAtPath:dataPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:&error];
    if(error){
        return false;
    }
    [data writeToFile:path atomically:YES];
    return true;
}

- (void) performTask:(GCDTask*) task{
    NSError* error = nil;
    task.status = taskStatusInProgress;
    NSData* taskData = [NSData dataWithContentsOfURL:[NSURL URLWithString:task.URL] options:NSDataReadingUncached error:&error];
    if(error == nil){
        BOOL isDataSaved = [self saveData:taskData toPath:task.pathToSaveData];
        if(isDataSaved){
            task.status = taskStatusSucceed;
            dispatch_sync(dispatch_get_main_queue(), ^{
                if([self.delegate respondsToSelector:@selector(backgroundWorker:didCompleteWithTask:)]){
                    [self.delegate backgroundWorker:self didCompleteWithTask:task];
                }
            });
        }else{
            [self sendStatusTaskFail:task withError:error];
        }
    }
    else{
        [self sendStatusTaskFail:task withError:error];
    }
}

- (void) sendStatusTaskFail:(GCDTask*)task withError:(NSError*)error{
    task.status = taskStatusFail;
    dispatch_sync(dispatch_get_main_queue(), ^{
        if([self.delegate respondsToSelector:@selector(backgroundWorker:didFailForTask:withError:)]){
            [self.delegate backgroundWorker:self didFailForTask:task withError:error];
        }
    });
}

@end
