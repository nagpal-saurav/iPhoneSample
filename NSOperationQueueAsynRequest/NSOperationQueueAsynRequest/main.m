//
//  main.m
//  NSOperationQueueAsynRequest
//
//  Created by Saurav Nagpal on 11/11/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//
#import "SampleOperation.h"
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSOperationQueue* opertionQueue = [[NSOperationQueue alloc] init];
        opertionQueue.name = @"SHDownlaodQueue";
        SampleOperation* opertion = [[SampleOperation alloc] init];
        [opertionQueue addOperation:opertion];
        while(true){
            
        }
    }
    return 0;
}
