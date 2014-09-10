//
//  ACHttpConnection.m
//  A-TeamClient
//
//  Created by Jakir Hussain on 7/25/14.
//  Copyright (c) 2014 Jakir Hussain. All rights reserved.
//

#import "ACHttpConnection.h"

@interface ACHttpConnection()<NSURLConnectionDelegate>{
    
}
@end

@implementation ACHttpConnection {
    NSMutableData*             _responseData;
    NSURLConnection*           _connection;
}

@synthesize delegate;

#pragma mark -  OBJECT LIFE CYCLE

- (id) init{
    return [self initWithDelegate:nil];
}

- (id) initWithDelegate:(id<HTTPConnecting>)paramDelegate{
    self = [super init];
    self.delegate = paramDelegate;
    return self;
}

- (void) startAsynRequestForUrlString:(NSString*)urlString withMethod:(NSString*)method{
    // Create the request.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    // Create url connection and fire request
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [_connection start];
}

- (void) cancelRequest{
    [_connection cancel];
}

#pragma mark - NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    if([self.delegate respondsToSelector:@selector(connection:didReceivedResponse:)]){
        [self.delegate connection:self didReceivedResponse:(NSHTTPURLResponse*)_responseData];
    }
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    if([self.delegate respondsToSelector:@selector(connection:didFinishLoadingWithLoadinData:)]){
        [self.delegate connection:self didFinishLoadingWithLoadinData:_responseData];
    }
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    if([self.delegate respondsToSelector:@selector(connection:didFailWithError:)]){
        [self.delegate connection:self didFailWithError:error];
    }
}

@end
