//
//  ACBeaconRegion.m
//  A-TeamClient
//
//  Created by Jakir Hussain on 7/25/14.
//  Copyright (c) 2014 Jakir Hussain. All rights reserved.
//

#import "ACBeaconRegion.h"

@implementation ACBeaconRegion{
    NSMutableDictionary *_beacons;
    CLLocationManager *_locationManager;
    NSMutableArray *_rangedRegions;
    CLBeaconRegion *_region;
    
}

@end
