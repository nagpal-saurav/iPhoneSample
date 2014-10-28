//
//  ACHttpConnection.h
//  A-TeamClient
//
//  Created by Jakir Hussain on 7/25/14.
//  Copyright (c) 2014 Jakir Hussain. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ACHttpConnection;

@protocol HTTPConnecting <NSObject>

- (void) connection:(ACHttpConnection*)httpConnection didFailWithError:(NSError *)error;
- (void) connection:(ACHttpConnection*)httpConnection didFinishLoadingWithLoadinData:(NSData*)data;
@optional
- (void) connection:(ACHttpConnection *)httpConnection didReceivedResponse:(NSHTTPURLResponse *)response;

@end

@interface ACHttpConnection : NSObject

@property (weak, nonatomic) id<HTTPConnecting> delegate;
@property (retain, nonatomic) NSString         *urlString;

- (id) initWithDelegate:(id<HTTPConnecting>)delegate;
- (void) startAsynRequestForUrlString:(NSString*)urlString withMethod:(NSString*)method;
@end
