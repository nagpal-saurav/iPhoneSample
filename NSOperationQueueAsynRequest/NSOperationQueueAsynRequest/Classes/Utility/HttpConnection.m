//
//  HttpConnection.m
//  GrandCentralDispatchExample
//
//  Created by Saurav Nagpal on 18/05/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//
#define CONNECTIONTIMEOUT          60u

#import "HttpConnection.h"

@implementation HttpConnection{
    NSMutableData*      receivedData;
    NSURLConnection*    theConnection;
}

#pragma mark -
#pragma NSURL Life Cycle Method

- (id) initWithDelegate:(id<URLConnecting>)deleagte{
    self = [super init];
    if(self == nil)
        return nil;
    self.delegate = deleagte;
    receivedData = [[NSMutableData alloc] init];
    return self;
}

- (connectionStatus) startAsyncRequestWithUrl:(NSString*)urlString{
    self.status = connectionSetupStage;
    assert(urlString != nil && urlString.length > 0);
    NSURL* url = [[NSURL alloc] initWithString:urlString];
    NSURLRequest* urlRequest = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:CONNECTIONTIMEOUT];
    theConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    return self.status;
}
#pragma mark - 
#pragma NSURL CONNECTION DELEGATE
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    if(httpResponse.statusCode == 200){
        self.status = connectionInProgress;
        
    }else{
        self.status = connectionFail;
    }
    if([self.delegate respondsToSelector:@selector(httpConnection:didGetResponse:)]){
        [self.delegate httpConnection:self didGetResponse:response];
    }
    
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse object.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    // receivedData is an instance variable declared elsewhere.
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    // Release the connection and the data object
    // by setting the properties (declared elsewhere)
    // to nil.  Note that a real-world app usually
    // requires the delegate to manage more than one
    // connection at a time, so these lines would
    // typically be replaced by code to iterate through
    // whatever data structures you are using.
    theConnection = nil;
    receivedData = nil;
    if([self.delegate respondsToSelector:@selector(httpConnection:didFailWithError:)]){
        [self.delegate httpConnection:self didFailWithError:error];
    }
    // inform the userx
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a property elsewhere
    if([self.delegate respondsToSelector:@selector(httpConnection:didFinishCompleteWithData:)]){
        [self.delegate httpConnection:self didFinishCompleteWithData:receivedData];
    }
    NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
    
    // Release the connection and the data object
    // by setting the properties (declared elsewhere)
    // to nil.  Note that a real-world app usually
    // requires the delegate to manage more than one
    // connection at a time, so these lines would
    // typically be replaced by code to iterate through
    // whatever data structures you are using.
    theConnection = nil;
    receivedData = nil;
}

@end
