//
//  ACConsumptionChartViewController.m
//  A-TeamClient
//
//  Created by Administrator on 26/07/14.
//  Copyright (c) 2014 Jakir Hussain. All rights reserved.
//

#import "ACConstant.h"
#import "ACConsumptionChartViewController.h"

@interface ACConsumptionChartViewController ()

@end

@implementation ACConsumptionChartViewController

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
    
    [self.chartWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:WEB_VIEW_URL]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
