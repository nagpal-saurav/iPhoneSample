//
//  ACBeaconReciver.m
//  A-TeamClient
//
//  Created by Jakir Hussain on 7/25/14.
//  Copyright (c) 2014 Jakir Hussain. All rights reserved.
//

#import "ACConstant.h"
#import "ACBeaconReceiver.h"

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
    [self locationManager:self.locationManager didStartMonitoringForRegion:self.beaconRegion];
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

- (void)didReceiveMemoryWarning
{
    //[super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
