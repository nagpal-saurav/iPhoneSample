//
//  ACAuthorizationViewController.m
//  A-TeamClient
//
//  Created by Jakir Hussain on 7/26/14.
//  Copyright (c) 2014 Jakir Hussain. All rights reserved.
//

#import "ACConstant.h"
#import "ACUtility.h"
#import "ACAuthorizationViewController.h"

@interface ACAuthorizationViewController ()

@end

@implementation ACAuthorizationViewController

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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorWithRed:65.0/255 green:67.0/255 blue:61.0/255 alpha:1.0];
    [self.authBtn setBackgroundColor:[UIColor colorWithRed:240.0/255 green:112.0/255 blue:59.0/255 alpha:1.0]];
    [self.authBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.authBtn.layer.cornerRadius = 5;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) authButtonClicked:(id)sender{
    NSString* usernameText = self.userId.text;
    if([usernameText isEqualToString:USER_ADMIN] || [usernameText isEqualToString:USER_NANDANI] || [usernameText isEqualToString:USER_ROHIT] || [usernameText isEqualToString:USER_SANDEEP]){
        [[NSUserDefaults standardUserDefaults] setValue:usernameText forKey:USER_CONFIG_NAME];
        [[NSUserDefaults standardUserDefaults] setValue:@"Yes" forKey:USER_CONFIG_AUTH];
        if([self.passcode.text isEqualToString:@"1111"]){
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [ACUtility showAlertWithTitle:@"Error!!" withMessage:@"Please enter valid credential"];
        }
        
    }else{
        [ACUtility showAlertWithTitle:@"Error!!" withMessage:@"Please enter valid credential"];
    }
    
}

@end
