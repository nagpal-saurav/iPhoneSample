//
//  GCDTask.h
//  GrandCentralDispatchExample
//
//  Created by Saurav Nagpal on 14/05/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

typedef enum taskStatusEnum{
    taskStatusNotStarted = 1,
    taskStatusInProgress,
    taskStatusSucceed,
    taskStatusFail,
}taskStatus;

@interface GCDTask : NSObject

@property (nonatomic, strong) NSString*  URL;
@property (nonatomic, strong) NSString*  pathToSaveData;
@property (nonatomic, assign) NSUInteger serialID;
@property (nonatomic, assign) taskStatus status;

- (id) initTaskWithID:(NSUInteger)ID forURL:(NSString*)url withPathToSave:(NSString*)path;

@end
