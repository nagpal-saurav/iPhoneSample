//
//  ACBLESearch.m
//  A-TeamClient
//
//  Created by Jakir Hussain on 7/25/14.
//  Copyright (c) 2014 Jakir Hussain. All rights reserved.
//

#import "ACBLESearch.h"

@implementation ACBLESearch{
    
}

/*
- (id) init
{
 http://developer.radiusnetworks.com/2013/10/21/corebluetooth-doesnt-let-you-see-ibeacons.html
    NSLog(@"loaded test view for finding beacons using core bluetooth");
    _manager = [[CBCentralManager alloc] initWithDelegate:self
                                                    queue:nil];
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state)
    {
        case CBCentralManagerStatePoweredOn:
        {
            NSDictionary *options = @{
                                      CBCentralManagerScanOptionAllowDuplicatesKey: @YES
                                      };
            [_manager scanForPeripheralsWithServices:nil
                                             options:options];
            NSLog(@"I just started scanning for peripherals");
            break;
        }
    }
}

- (void)   centralManager:(CBCentralManager *)central
    didDiscoverPeripheral:(CBPeripheral *)peripheral
        advertisementData:(NSDictionary *)advertisementData
                     RSSI:(NSNumber *)RSSI
{
    NSLog(@"I see an advertisement with identifer: %@, state: %@, name: %@, services: %@, description: %@",
          [peripheral identifier],
          [peripheral state],
          [peripheral name],
          [peripheral services],
          [advertisementData description]);
    
    if (_peripheral == nil)
    {
        NSLog(@"Trying to connect to peripheral");
        _peripheral = peripheral;
        _peripheral.delegate = (id)self;
        [central connectPeripheral:_peripheral
                           options:nil];
    }
}

- (void)  centralManager:(CBCentralManager *)central
    didConnectPeripheral:(CBPeripheral *)peripheral
{
    if (peripheral == nil)
    {
        NSLog(@"connect callback has nil peripheral");
    } else {
        NSLog(@"Connected to peripheral with identifer: %@, state: %d, name: %@, services: %@",
              [peripheral identifier],
              [peripheral state],
              [peripheral name],
              [peripheral services]);
        
        NSLog(@"discovering services...");
        _peripheral = peripheral;
        _peripheral.delegate = (id)self;
        [_peripheral discoverServices:nil];
    }
}

- (void)     peripheral:(CBPeripheral *)peripheral
    didDiscoverServices:(NSArray *)serviceUuids
{
    NSLog(@"discovered a peripheral's services: %@", serviceUuids);
}*/

@end
