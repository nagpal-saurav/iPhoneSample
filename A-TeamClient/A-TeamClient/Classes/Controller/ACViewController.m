//
//  ACViewController.m
//  A-TeamClient
//
//  Created by Jakir Hussain on 7/25/14.
//  Copyright (c) 2014 Jakir Hussain. All rights reserved.
//

#import "ACConstant.h"
#import "ACAuthorizationViewController.h"
#import "ACUtility.h"
#import "ACBeaconReceiver.h"
#import "ACBeaconTransmitter.h"
#import "ACHttpConnection.h"
#import "ACViewController.h"


@interface ACViewController ()<ACBeaconReceiving, HTTPConnecting>{
    ACBeaconReceiver*        _receiver;
    ACBeaconTransmitter*     _transmitter;
    ACHttpConnection*        _connection;
    NSIndexPath*             _selectedIndex;
    BOOL                     _isAllLightsOn;
    NSString*                _activateLightID;
    
}

- (IBAction)StartTransmit:(id)sender;
- (IBAction)StartReceive:(id)sender;

@end

@implementation ACViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _receiver = [[ACBeaconReceiver alloc] initWithDelegate:self];
    _transmitter = [[ACBeaconTransmitter alloc] init];
    //[self configUserDefault]; After Second test
    _connection = [[ACHttpConnection alloc] initWithDelegate:self];
    [self startHttpConnectionForStatus];
    _isAllLightsOn = NO;
    _currentDistanceStatus  = CLProximityUnknown;
    
    [self.view.layer setContents:(id)[UIImage imageNamed:@"bg5.jpg"].CGImage];
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleLightContent];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSString* username = [[NSUserDefaults standardUserDefaults] valueForKey:USER_CONFIG_NAME];
    if([username isEqualToString:USER_NANDANI]){
        
        self.firstButton.frame = self.SecondButton.frame;
        self.lbl1.frame = self.lbl2.frame;
        self.firstButton.hidden = false;
        self.lbl1.hidden = false;
        self.SecondButton.hidden = true;
        self.ThirdButton.hidden = true;
        self.lbl2.hidden = true;
        self.lbl3.hidden = true;
        _activateLightID = [[NSString alloc] initWithFormat:@"%ld",(long)self.firstButton.tag];
    }else if ([username isEqualToString:USER_ROHIT]){
        self.SecondButton.hidden = false;
        self.lbl2.hidden = false;
        self.firstButton.hidden = true;
        self.ThirdButton.hidden = true;
        self.lbl1.hidden = true;
        self.lbl3.hidden = true;
        _activateLightID = [[NSString alloc] initWithFormat:@"%ld",(long)self.SecondButton.tag];
    }
    else if ([username isEqualToString:USER_SANDEEP]){
        self.ThirdButton.hidden = false;
        self.lbl3.hidden = false;
        self.ThirdButton.frame = self.SecondButton.frame;
        self.lbl3.frame = self.lbl2.frame;
        self.firstButton.hidden = true;
        self.SecondButton.hidden = true;
        self.lbl1.hidden = true;
        self.lbl2.hidden = true;
        _activateLightID = [[NSString alloc] initWithFormat:@"%ld",(long)self.ThirdButton.tag];
    }else{
        self.firstButton.frame = CGRectMake(44, 11, 249, 120);
        self.lbl1.frame = CGRectMake(101, 133, 139, 21);
        self.ThirdButton.frame = CGRectMake(38, 307, 260, 120);
        self.lbl3.frame = CGRectMake(95, 416, 151, 21);
        self.firstButton.hidden = false;
        self.lbl1.hidden = false;
        self.SecondButton.hidden = false;
        self.lbl2.hidden = false;
        self.ThirdButton.hidden = false;
        self.lbl3.hidden = false;
        _activateLightID = @"all";
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if([self isAuthorized] == NO){
        UIStoryboard* mainSTB = [UIStoryboard storyboardWithName:IPHONE_STORYBOARD bundle:[NSBundle mainBundle]];
        UIViewController* authCtrl =  [mainSTB instantiateViewControllerWithIdentifier:AUTH_CONTROLLER_ID];
        [self presentViewController:authCtrl animated:YES completion:nil];
        
    }
    [self configUserDefault]; //After Second test
}

- (void) configUserDefault{
    NSNumber* selectedRow = [[NSUserDefaults standardUserDefaults] valueForKey:USER_CONFIG_DISTANCE];
    if(selectedRow == nil){
        _selectedIndex = [NSIndexPath indexPathForRow:1 inSection:0];
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithLong:_selectedIndex.row] forKey:USER_CONFIG_DISTANCE];
    }else{
        _selectedIndex = [NSIndexPath indexPathForRow:[selectedRow longValue] inSection:0];
    }
}

- (BOOL) isAuthorized{
    if([[NSUserDefaults standardUserDefaults] valueForKey:USER_CONFIG_AUTH]){
        return YES;
    }
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBACTION 
- (IBAction)StartTransmit:(id)sender {
    [_transmitter StartTransmitting];
}

- (IBAction)StartReceive:(id)sender {
    [_receiver startMonitoring];
}

- (IBAction) refreshStatus:(id)sender {
    [self startHttpConnectionForStatus];
}

- (IBAction) bulbPressed:(id)sender{
    NSNumber* light_status = [[NSUserDefaults standardUserDefaults] valueForKey:LIGHT_MODE_AUTO];
    BOOL isModeAuto = [light_status boolValue];
    if(isModeAuto){
        [ACUtility showAlertWithTitle:@"Automatic Mode" withMessage:MANUAL_MODE_BLOCK];
        return;
    }
    UIButton* button = (UIButton*)sender;
    NSUInteger newLightStatus = button.tag;
    NSString* bulbValue  = [NSString stringWithFormat:@"%lu",(unsigned long)newLightStatus];
    if(button.selected){
        [self startHttpConnectionWithLightStatus:LIGHT_OFF forTheBulb:bulbValue];
    }else{
        [self startHttpConnectionWithLightStatus:LIGHT_ON forTheBulb:bulbValue];
    }
    _currentStatus = (NSUInteger)newLightStatus;
    //button.selected = !button.selected;
}

#pragma mark - Receiver Delegate
- (void) receiver:(ACBeaconReceiver*)reciver didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region{
    NSNumber* light_status = [[NSUserDefaults standardUserDefaults] valueForKey:LIGHT_MODE_AUTO];
    BOOL isModeAuto = [light_status boolValue];
    if(isModeAuto == false){
        return;
    }
    CLBeacon *beacon = [[CLBeacon alloc] init];
    beacon = [beacons lastObject];
    
    UIApplicationState applicationState = [UIApplication sharedApplication].applicationState;
    if (applicationState == UIApplicationStateBackground) {
        //[ACUtility showAlertWithTitle:@"Beacon" withMessage:@"Working"];
    }
    
    
    self.beaconFoundLabel.text = @"Yes";
    self.proximityUUIDLabel.text = beacon.proximityUUID.UUIDString;
    self.majorLabel.text = [NSString stringWithFormat:@"%@", beacon.major];
    self.minorLabel.text = [NSString stringWithFormat:@"%@", beacon.minor];
    self.accuracyLabel.text = [NSString stringWithFormat:@"%f", beacon.accuracy];
    NSInteger currentProximity = beacon.proximity - 1;
    if(currentProximity <= _selectedIndex.row && beacon.proximity != CLProximityUnknown){
        if(!_isAllLightsOn){
            [self startHttpConnectionWithLightStatus:LIGHT_ON forTheBulb:_activateLightID];
        }
    }else{
        if(_isAllLightsOn){
            [self startHttpConnectionWithLightStatus:LIGHT_OFF forTheBulb:_activateLightID];
            [self notifyUser:nil];
            
        }
    }
    
    if (beacon.proximity == CLProximityUnknown) {
        self.distanceLabel.text = @"Unknown Proximity";
    } else if (beacon.proximity == CLProximityImmediate) {
        self.distanceLabel.text = @"Immediate";
    } else if (beacon.proximity == CLProximityNear) {
        self.distanceLabel.text = @"Near";
    } else if (beacon.proximity == CLProximityFar) {
        self.distanceLabel.text = @"Far";
        if (self.firstButton.selected && self.SecondButton.selected && self.ThirdButton.selected) {
        }
        
    }
    _currentDistanceStatus = beacon.proximity;
    //self.rssiLabel.text = [NSString stringWithFormat:@"%i", beacon.rssi];*/
}

-(void)notifyUser:(id)args
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = @"Are you forgetting something? We will take care!!!";
    notification.soundName = @"Default";
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    
}

- (void) receiver:(ACBeaconReceiver*)reciver didExitRegion:(CLRegion *)region{
    
    if ([region isKindOfClass:[CLBeaconRegion class]]) {
//        UILocalNotification *notification = [[UILocalNotification alloc] init];
//        notification.alertBody = @"Are you forgetting something?";
//        notification.soundName = @"Default";
//        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    }
}

#pragma mark - HTTP Connection Delegate

- (void) connection:(ACHttpConnection*)httpConnection didFailWithError:(NSError *)error{
    [ACUtility showAlertWithTitle:@"Error!!" withMessage:[error localizedDescription]];
}

- (void) connection:(ACHttpConnection*)httpConnection didFinishLoadingWithLoadinData:(NSData*)data{
    NSError* error;
    //[ACUtility showAlertWithTitle:@"network" withMessage:@"Working"];
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSArray* responseKeys = [json allKeys];
    _isAllLightsOn = YES;
    for (NSString* ledKey in responseKeys) {
        NSString* bulbStatusString = [json valueForKey:ledKey];
        BOOL bulbStatus = [bulbStatusString boolValue];
        /***
         *Writen after first testing
         */
        if([_activateLightID isEqualToString:@"all"] && bulbStatus == NO){
            _isAllLightsOn = NO;
        }else if([ledKey isEqualToString:_activateLightID] && bulbStatus == NO){
            _isAllLightsOn = NO;
        }
        /*******END***************************/
        
        if([ledKey isEqualToString:@"10"]){
            self.firstButton.selected = bulbStatus;
        }else if ([ledKey isEqualToString:@"9"]){
            self.SecondButton.selected = bulbStatus;
        }else if ([ledKey isEqualToString:@"11"]){
            self.ThirdButton.selected = bulbStatus;
        }
    }
    //[ACUtility showAlertWithTitle:@"Response" withMessage:[json description]];
    
}

- (void) connection:(ACHttpConnection *)httpConnection didReceivedResponse:(NSHTTPURLResponse *)response{
    
}

#pragma mark - UTILITY METHOD
- (void) startHttpConnectionWithLightStatus:(NSUInteger)status forTheBulb:(NSString*)bulbValue{
    NSString* urlString = [NSString stringWithFormat:@"%@/%@/%@/%lu", SERVER_URL,SEND_STATUS_CALL, bulbValue,(unsigned long)status];
    [_connection startAsynRequestForUrlString:urlString withMethod:HTTP_METHOD];
}

- (void) startHttpConnectionForStatus{
    NSString* urlString = [NSString stringWithFormat:@"%@/%@", SERVER_URL, GET_STATUS_CALL];
    [_connection startAsynRequestForUrlString:urlString withMethod:HTTP_METHOD];
}

@end
