//
//  HttpConnection.h
//  GrandCentralDispatchExample
//
//  Created by Saurav Nagpal on 18/05/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

typedef enum connectionStatusEnum{
    connectionSetupStage,
    connectionOverflow,
    connectionInProgress,
    connectionFail,
    connectionSucess,
}connectionStatus;

@class HttpConnection;

@protocol URLConnecting <NSObject>

@optional
- (void) httpConnection :(HttpConnection*)connection didGetResponse:(NSURLResponse*)response;

@required
- (void) httpConnection :(HttpConnection*)connection didFinishCompleteWithData:(NSData*)data;
- (void) httpConnection :(HttpConnection*)connection didFailWithError:(NSError*)error;

@end


@interface HttpConnection : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic, weak)id<URLConnecting> delegate;
@property (nonatomic, assign)connectionStatus status;

- (id) initWithDelegate:(id<URLConnecting>)deleagte;
- (connectionStatus) startAsyncRequestWithUrl:(NSString*)urlString;

@end
