//
//  ACAuthorizationViewController.h
//  A-TeamClient
//
//  Created by Jakir Hussain on 7/26/14.
//  Copyright (c) 2014 Jakir Hussain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACAuthorizationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userId;
@property (weak, nonatomic) IBOutlet UITextField *passcode;

- (IBAction) authButtonClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *authBtn;
@end
