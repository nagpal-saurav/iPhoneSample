//
//  ACAppDelegate.m
//  A-TeamClient
//
//  Created by Jakir Hussain on 7/25/14.
//  Copyright (c) 2014 Jakir Hussain. All rights reserved.
//

#import "ACAppDelegate.h"
#import "ACUtility.h"
#import "ACConstant.h"

@implementation ACAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
     [[UIApplication sharedApplication] cancelAllLocalNotifications];
    NSObject* light_status = [[NSUserDefaults standardUserDefaults] valueForKey:LIGHT_MODE_AUTO];
    if(light_status == nil){
        NSNumber* modeStatus = [NSNumber numberWithBool:DEFAULT_LIGHT_MODE];
        [[NSUserDefaults standardUserDefaults] setValue:modeStatus forKey:LIGHT_MODE_AUTO];
    }
    NSString* serverIP = [self fetchServerIP];
    if(serverIP == nil){
        [self saveServerIP:SERVER_URL];
    }else{
        self.serverAddress = serverIP;
    }
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIApplicationState applicationState = application.applicationState;
    if (applicationState == UIApplicationStateBackground) {
        [application presentLocalNotificationNow:notification];
    }else{
        [ACUtility showAlertWithTitle:@"Info!!" withMessage:@"Are you forgetting something? We will take care!!!"];
    }
}

- (void) saveServerIP:(NSString*)serverIP{
    self.serverAddress = serverIP;
    [[NSUserDefaults standardUserDefaults] setObject:serverIP forKey:@"serverIP"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString*) fetchServerIP{
    NSString *serverIP = [[NSUserDefaults standardUserDefaults] stringForKey:@"serverIP"];
    return serverIP;
}


@end
