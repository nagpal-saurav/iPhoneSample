//
//  GCDTask.m
//  GrandCentralDispatchExample
//
//  Created by Saurav Nagpal on 14/05/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

#import "GCDTask.h"

@implementation GCDTask

#pragma mark -
#pragma LIFE CYCLE METHOD

- (id) initTaskWithID:(NSUInteger)ID forURL:(NSString*)url withPathToSave:(NSString*)path{
    self = [super init];
    if(self == nil)
        return nil;
    self.URL = url;
    self.serialID = ID;
    self.pathToSaveData = path;
    self.status = taskStatusNotStarted;
    return self;
}

@end
