//
//  PDFListViewController.m
//  PDFReadingSample
//
//  Created by Saurav Nagpal on 09/10/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

#import "Utility.h"
#import "ReaderDocument.h"
#import "MFDocumentManager.h"
#import "PDFReaderConstant.h"
#import "PDFViewController.h"
#import "SearchManager.h"
#import "NotificationFactory.h"
#import "PDFListViewController.h"

@interface PDFListViewController ()<UISearchBarDelegate>{
    NSMutableArray*     _searchManagerList;
    NSMutableArray*     _searchResult;
    NSUInteger          _serachFileCount;
}

@property (nonatomic, retain) NSArray*   pdfFileList;
@property (weak, nonatomic) IBOutlet UITableView *PDFListView;
@property (assign, nonatomic)BOOL isSearch;

- (void) showPDFViewerWithDetail:(NSDictionary*)pdfDetail;

@end

@implementation PDFListViewController

#pragma mark - View Controller Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pdfFileList = [Utility listFromPlistFileWithName:PDF_LIST_FILE_NAME];
    [[NSNotificationCenter defaultCenter] addObserver:self
                           selector:@selector(handleSearchResultsAvailableNotification:)
                               name:kNotificationSearchResultAvailable
                             object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleSearchResultsStopNotification:)
                                                 name:kNotificationSearchDidStop
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleSearchResultsStopNotification:)
                                                 name:kNotificationSearchGotCancelled
                                               object:nil];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isSearch = false;
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
    if(_isSearch){
        return _searchResult.count;
    }
    return self.pdfFileList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:PDF_CELL_IDENTIFIER];
    NSDictionary* cellInfo = nil;
    if(_isSearch){
        cellInfo = [_searchResult objectAtIndex:indexPath.row];
    }else{
        cellInfo = [self.pdfFileList objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = [cellInfo objectForKey:CELL_TEXT];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[cellInfo objectForKey:CELL_TEXT] ofType:FILE_TYPE_PDF];
    NSURL *documentUrl = [NSURL fileURLWithPath:filePath];
    
    //
    // Now that we have the URL, we can allocate an istance of the MFDocumentManager class (a wrapper) and use
    // it to initialize an MFDocumentViewController subclass
    MFDocumentManager *aDocManager = [[MFDocumentManager alloc]initWithFileUrl:documentUrl];
    NSString* content = [aDocManager wholeTextForPage:1];
   /* NSString* content = convertPDF(filePath);
    NSString *trimmedText = [content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];*/
    cell.detailTextLabel.text = content;
    return cell;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* selectedPDFDetail = [self.pdfFileList objectAtIndex:indexPath.row];
    [self showPDFViewerWithDetail:selectedPDFDetail];
    
}

#pragma mark - serach bar delgate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if(_isSearch){
        return;
    }
    _searchResult = [[NSMutableArray alloc] init];
    _searchManagerList = [[NSMutableArray alloc] init];
    _isSearch = true;
    NSUInteger docId = 0;
    for (NSDictionary* pdfInfo in self.pdfFileList) {
        NSString* pdfFileName = [pdfInfo objectForKey:CELL_TEXT];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:pdfFileName ofType:FILE_TYPE_PDF];
        NSURL *documentUrl = [NSURL fileURLWithPath:filePath];
        //
        // Now that we have the URL, we can allocate an istance of the MFDocumentManager class (a wrapper) and use
        // it to initialize an MFDocumentViewController subclass
        MFDocumentManager *aDocManager = [[MFDocumentManager alloc]initWithFileUrl:documentUrl];
        SearchManager* newManager = [[SearchManager alloc] init];
        [_searchManagerList addObject:newManager];
        newManager.searchDocId = docId;
        newManager.document = aDocManager;
        [newManager startSearchOfTerm:searchBar.text fromPage:1];
        docId++;
        
    }
    _serachFileCount = docId;
}


-(void)handleSearchResultsAvailableNotification:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    NSArray* searchResult = [userInfo objectForKey:kNotificationSearchInfoResults];
    if([searchResult count] > 0) {
        SearchManager* manager = [userInfo objectForKey:kNotificationSearchInfoSearchManger];
        NSDictionary* pdfInfo = [self.pdfFileList objectAtIndex:manager.searchDocId];
        [_searchResult addObject:pdfInfo];
        [manager stopSearch];
        [self.PDFListView reloadData];
    }
}

- (void)handleSearchResultsStopNotification:(NSNotification *)notification {
    _serachFileCount--;
    if(_serachFileCount == 0){
        _isSearch = false;
    }
}
#pragma mark - Utility

- (void) showPDFViewerWithDetail:(NSDictionary*)pdfDetail{
    UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NSString *fileName = [pdfDetail objectForKey:CELL_TEXT];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:FILE_TYPE_PDF];
    NSURL *documentUrl = [NSURL fileURLWithPath:filePath];
    MFDocumentManager *aDocManager = [[MFDocumentManager alloc]initWithFileUrl:documentUrl];
    PDFViewController *pdfViewC =[[storybord instantiateViewControllerWithIdentifier:PDFVIEWER_STORYBOARD_ID] initWithDocumentManager:aDocManager];
    [self.navigationController pushViewController:pdfViewC animated:YES];
}

@end
