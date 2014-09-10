//
//  ACBeaconReciver.h
//  A-TeamClient
//
//  Created by Jakir Hussain on 7/25/14.
//  Copyright (c) 2014 Jakir Hussain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class ACBeaconReceiver;

@protocol ACBeaconReceiving <NSObject>

- (void) receiver:(ACBeaconReceiver*)reciver didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region;
- (void) receiver:(ACBeaconReceiver*)reciver didExitRegion:(CLRegion *)region;

@end

@interface ACBeaconReceiver : NSObject<CLLocationManagerDelegate>

@property (weak, nonatomic) id<ACBeaconReceiving> delegate;

@property (strong, nonatomic) CLBeaconRegion *beaconRegion;
@property (strong, nonatomic) CLLocationManager *locationManager;

- (void) startMonitoring;
- (id) initWithDelegate:(id<ACBeaconReceiving>)delegate;

@end
