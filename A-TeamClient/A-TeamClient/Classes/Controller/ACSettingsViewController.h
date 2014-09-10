//
//  ACSettingsViewController.h
//  A-TeamClient
//
//  Created by Jakir Hussain on 7/26/14.
//  Copyright (c) 2014 Jakir Hussain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACSettingsViewController : UITableViewController <UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UISwitch *lightModeSwitch;
- (IBAction)modeChangePressed:(id)sender;

@end
