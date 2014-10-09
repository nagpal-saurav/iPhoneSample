//
//  PDFListViewController.m
//  PDFReadingSample
//
//  Created by Saurav Nagpal on 09/10/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

#import "Utility.h"
#import "PDFReaderConstant.h"
#import "PDFListViewController.h"

@interface PDFListViewController ()

@property (nonatomic, retain) NSArray*   pdfFileList;

@end

@implementation PDFListViewController

#pragma mark - View Controller Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pdfFileList = [Utility listFromPlistFileWithName:PDF_LIST_FILE_NAME];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table View Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.pdfFileList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:PDF_CELL_IDENTIFIER];
    
    return cell;
}


@end
