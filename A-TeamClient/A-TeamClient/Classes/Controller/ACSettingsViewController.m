//
//  ACSettingsViewController.m
//  A-TeamClient
//
//  Created by Jakir Hussain on 7/26/14.
//  Copyright (c) 2014 Jakir Hussain. All rights reserved.
//

#import "ACUtility.h"
#import "ACConstant.h"
#import "ACSettingsViewController.h"

@interface ACSettingsViewController ()
@property (weak, nonatomic) IBOutlet UITableViewCell *transmitterCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *receiverCell;


@end

@implementation ACSettingsViewController{
    NSIndexPath*    selectedIndex;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSNumber* selectedRow = [[NSUserDefaults standardUserDefaults] valueForKey:USER_CONFIG_DISTANCE];
    selectedIndex = [NSIndexPath indexPathForRow:[selectedRow longValue] inSection:0];
    [self.tableView cellForRowAtIndexPath:selectedIndex].accessoryType = UITableViewCellAccessoryCheckmark;
    NSNumber* light_status = [[NSUserDefaults standardUserDefaults] valueForKey:LIGHT_MODE_AUTO];
    BOOL isModeAuto = [light_status boolValue];
    self.lightModeSwitch.on = isModeAuto;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return 3;
//    }else if(section == 1){
//        return 1;
//    }
//    return 1;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [tableView cellForRowAtIndexPath:selectedIndex].accessoryType = UITableViewCellAccessoryNone;
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithLong:indexPath.row] forKey:USER_CONFIG_DISTANCE];
        selectedIndex = indexPath;
    }else if (indexPath.section == 1){
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_CONFIG_AUTH];
        [self dismissViewControllerAnimated:YES completion:nil];
        //[ACUtility showAlertWithTitle:@"Done" withMessage:@"App Credential Cleared"];
    }else if (indexPath.section == 2){
        NSNumber* modeStatus = [NSNumber numberWithBool:self.lightModeSwitch.isOn];
        [[NSUserDefaults standardUserDefaults] setValue:modeStatus forKey:LIGHT_MODE_AUTO];
        [self.tableView reloadData];
    }
    
}


- (IBAction)donePressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)modeChangePressed:(id)sender {
    NSNumber* modeStatus = [NSNumber numberWithBool:self.lightModeSwitch.isOn];
    [[NSUserDefaults standardUserDefaults] setValue:modeStatus forKey:LIGHT_MODE_AUTO];
}


@end
