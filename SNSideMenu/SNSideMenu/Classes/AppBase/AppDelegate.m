//
//  AppDelegate.m
//  SNSideMenu
//
//  Created by Saurav Nagpal on 31/10/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

#import "SampleViewController1.h"
#import "SampleViewController2.h"
#import "SSRevealViewController.h"
#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    SampleViewController1* viewCtrl1 = [[SampleViewController1 alloc] init];
    SampleViewController2* viewCtrl2 = [[SampleViewController2 alloc] init];
    NSArray* viewCtrls = @[viewCtrl1, viewCtrl2];
    NSArray* viewTitles = @[@"Red", @"Blue"];
    SSRevealViewController* revealViewCtrl  =[[SSRevealViewController alloc] initWithViewControllers:viewCtrls andMenuTitles:viewTitles];
    revealViewCtrl.view.frame = self.window.frame;
    self.window.rootViewController = revealViewCtrl;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
