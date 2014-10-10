//
//  PDFListViewController.m
//  PDFReadingSample
//
//  Created by Saurav Nagpal on 09/10/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

#import "Utility.h"
#import "PDFReaderConstant.h"
#import "PDFViewController.h"
#import "PDFListViewController.h"

@interface PDFListViewController ()

@property (nonatomic, retain) NSArray*   pdfFileList;
@property (weak, nonatomic) IBOutlet UITableView *PDFListView;

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
    NSDictionary* cellInfo = [self.pdfFileList objectAtIndex:indexPath.row];
    cell.textLabel.text = [cellInfo objectForKey:CELL_TEXT];
    return cell;
}

#pragma mark segue Delegate

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:SEGUE_PUSH_PDFVIEWER]){
        PDFViewController* pdfViewC = segue.destinationViewController;
        NSIndexPath* selectedIndex = self.PDFListView.indexPathForSelectedRow;
        [pdfViewC setSelectedPDFDetail:[self.pdfFileList objectAtIndex:selectedIndex.row]];        
    }
}

@end
