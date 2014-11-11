//
//  MyOpertion.m
//  NSOperationQueueAsynRequest
//
//  Created by Saurav Nagpal on 29/10/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

#import "HttpConnection.h"
#import "SampleOperation.h"

@interface SampleOperation()<URLConnecting>


@end

@implementation SampleOperation

- (id) init{
    self = [super init];
    return self;
}
//Main method of Operation

- (void)main {
    @autoreleasepool {
        HttpConnection* connection = [[HttpConnection alloc] initWithDelegate:self];
        [connection startAsyncRequestWithUrl:URLString];
        while(1){
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            sleep(2);
        }
    }
}

#pragma mark - HTTP Delegate
- (void) httpConnection :(HttpConnection*)connection didGetResponse:(NSURLResponse*)response{
    
}

- (void) httpConnection :(HttpConnection*)connection didFinishCompleteWithData:(NSData*)data{
    
}

- (void) httpConnection :(HttpConnection*)connection didFailWithError:(NSError*)error{
    
}

@end
