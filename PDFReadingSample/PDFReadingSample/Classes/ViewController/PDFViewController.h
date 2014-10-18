//
//  ViewController.h
//  PDFReadingSample
//
//  Created by Saurav Nagpal on 08/10/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

#import "ReaderViewController.h"
#import "MFDocumentViewController.h"
#import "MFDocumentViewControllerDelegate.h"
#import <UIKit/UIKit.h>

@interface PDFViewController : MFDocumentViewController

@property (nonatomic, retain)NSDictionary* selectedPDFDetail;

@end

