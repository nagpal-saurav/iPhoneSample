//
//  ViewController.m
//  ARCInstrumentTest
//
//  Created by Saurav Nagpal on 26/12/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

#import "TestDetailViewController.h"

#define  CLICKED        @"click"

@interface TestDetailViewController ()

@property (nonatomic, strong)NSTimer*   timer;
@property (nonatomic, assign)NSString*    sampleText;

@end

@implementation TestDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDate *fireDate = [[NSDate date] dateByAddingTimeInterval:1];
    
    self.timer = [[NSTimer alloc] initWithFireDate:fireDate interval:0 target:self selector:@selector(timerFire:) userInfo:nil repeats:YES];
    _sampleText = [[NSString alloc] initWithFormat:@"Test %@",CLICKED];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc{
    
}

- (void) timerFire:(NSTimer*)timer{
  
}

- (IBAction)testMePressed:(id)sender {
    if([_sampleText isEqualToString:@"pass"]){
        
    }
}

- (IBAction) leakArrayRetainCycle:(id)sender

{
    
    NSMutableArray *array1 = [NSMutableArray array];
    
    NSMutableArray *array2 = [NSMutableArray array];
    
    [array1 addObject:array2];
    
    [array2 addObject:array1];
    
}

- (IBAction) leakArrayCFBridge:(id)sender
{
    
    NSArray *array = [NSArray arrayWithObjects:
                      
                      @"Hello", @"World", nil];
    
    CFArrayRef leakyRef = (__bridge_retained CFArrayRef) array;
    
    leakyRef = NULL;
}



@end
