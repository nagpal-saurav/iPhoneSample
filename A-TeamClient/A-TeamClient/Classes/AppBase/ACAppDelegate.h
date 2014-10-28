//
//  ACAppDelegate.h
//  A-TeamClient
//
//  Created by Jakir Hussain on 7/25/14.
//  Copyright (c) 2014 Jakir Hussain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *serverAddress;

- (void) saveServerIP:(NSString*)serverIP;

@end
