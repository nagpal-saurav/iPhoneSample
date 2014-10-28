//
//  ACServerConfViewController.m
//  A-TeamClient
//
//  Created by Saurav Nagpal on 20/10/14.
//  Copyright (c) 2014 Jakir Hussain. All rights reserved.
//

#import "ACAppDelegate.h"
#import "ACServerConfViewController.h"

@interface ACServerConfViewController ()

@property (weak, nonatomic) IBOutlet UITextField *IPTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@end

@implementation ACServerConfViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     ACAppDelegate* appDelegate = (ACAppDelegate*)[[UIApplication sharedApplication] delegate];
    self.IPTextField.text = appDelegate.serverAddress;
   
}

- (IBAction)doneButtonPressed:(id)sender {
    ACAppDelegate* appDelegate = (ACAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate saveServerIP:self.IPTextField.text];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
