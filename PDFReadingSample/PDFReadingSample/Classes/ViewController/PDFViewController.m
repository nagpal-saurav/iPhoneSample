//
//  ViewController.m
//  PDFReadingSample
//
//  Created by Saurav Nagpal on 08/10/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

#import "PDFReaderConstant.h"
#import "ReaderViewController.h"
#import "PDFViewController.h"

@interface PDFViewController ()<ReaderViewControllerDelegate>

@property(nonatomic, retain)ReaderDocument* document;

@end

@implementation PDFViewController

@synthesize selectedPDFDetail;

#pragma mark - View Controller Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
