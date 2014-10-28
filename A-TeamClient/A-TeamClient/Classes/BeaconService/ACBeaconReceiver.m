//
//  ACBeaconReciver.m
//  A-TeamClient
//
//  Created by Jakir Hussain on 7/25/14.
//  Copyright (c) 2014 Jakir Hussain. All rights reserved.
//

#import "ACConstant.h"
#import "ACUtility.h"
#import "ACBeaconReceiver.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@implementation ACBeaconReceiver

@synthesize delegate;

- (id) init {
    return [self initWithDelegate:nil];
}

- (id) initWithDelegate:(id<ACBeaconReceiving>)paramDelegate;
{
	// Do any additional setup after loading the view.
    self = [super init];
    self.delegate = paramDelegate;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    //In ViewDidLoad
    if(IS_OS_8_OR_LATER) {
        [self.locationManager requestAlwaysAuthorization];
    }
    [self initRegion];
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}

- (void)initRegion {
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:PROXIMITY_UDID];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:PROXIMITY_IDENTIFIER];
}

- (void) startMonitoring{
   
    [self.locationManager startMonitoringForRegion:self.beaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    NSLog(@"Beacon Found");
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    NSLog(@"Left Region");
    [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
    if([self.delegate respondsToSelector:@selector(receiver:didExitRegion:)]){
        [self.delegate receiver:self didExitRegion:region];
    }
    //self.beaconFoundLabel.text = @"No";
}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    
    if([self.delegate respondsToSelector:@selector(receiver:didRangeBeacons:inRegion:)]){
        [self.delegate receiver:self didRangeBeacons:beacons inRegion:region];
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"Couldn't turn on ranging: Location services are not enabled.");
    }
    
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways) {
        [ACUtility showAlertWithTitle:@"Light Off!!" withMessage:@"Couldn't turn on monitoring: Location services not authorised."];
        NSLog(@"Couldn't turn on monitoring: Location services not authorised.");
    }
}

- (void)didReceiveMemoryWarning
{
    //[super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
