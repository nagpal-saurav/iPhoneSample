//
//  GCDSampleTableViewController.m
//  GrandCentralDispatchExample
//
//  Created by Saurav Nagpal on 18/05/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//
#define FolderName              @"images"
#define LowerProrityFolder      @"Images/lowerP"
#define HigherProrityFolder     @"Images/higher"

#import "GCDTask.h"
#import "GCDDownloadWorker.h"
#import "GCDSampleTableViewController.h"

@interface GCDSampleTableViewController ()<GCDDownloading>
- (void) addDownloadImageTask;
- (NSString*) documentDirectoryPathWithFolder:(NSString*)folderName;
@end

@implementation GCDSampleTableViewController{
    GCDDownloadWorker*      _imageDownloader;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _imageDownloader = [[GCDDownloadWorker alloc] initWithDelegate:self];
    [self addDownloadImageTask];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sampleCell" forIndexPath:indexPath];
    if(cell == nil){
        cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sampleCell"];
    }
    
    // Configure the cell...
    
    return cell;
}

#pragma mark -
#pragma GCD TASK
- (void) addDownloadImageTask{
    NSArray* lowProrityImage = @[
                                 @"https://imagizer.imageshack.us/v2/235x352q90/716/nkm8.jpg",
                                 @"https://imagizer.imageshack.us/v2/120x120q90/c/600/1ygq.jpg",
                                 @"https://imagizer.imageshack.us/v2/120x120q90/c/707/u8q3.jpg",
                                 @"https://imagizer.imageshack.us/v2/120x120q90/c/713/sqf6.jpg",
                                 @"https://imagizer.imageshack.us/v2/120x120q90/c/689/nkgc.png",
                                 @"https://imagizer.imageshack.us/v2/352x352q90/855/sq9g.jpg",
                                 @"https://imagizer.imageshack.us/v2/120x120q90/c/18/1wxz.jpg",
                                 @"https://imagizer.imageshack.us/v2/120x120q90/c/844/ybfp.jpg",
                                 @"https://imagizer.imageshack.us/v2/120x120q90/c/809/zj.jpg",
                                 @"https://imagizer.imageshack.us/v2/120x120q90/c/203/52dq.jpg",
                                 ];
    
    
    
    //Lower prority
    NSString* path = [self documentDirectoryPathWithFolder:LowerProrityFolder];
    NSUInteger count = [lowProrityImage count];
    for(NSUInteger i = 0;i<count;i++){
        NSString* url = [lowProrityImage objectAtIndex:i];
        NSString* lastPath = [url lastPathComponent];
        NSString* filePath = [path stringByAppendingPathComponent:lastPath];
        GCDTask* task = [[GCDTask alloc] initTaskWithID:i+1 forURL:url withPathToSave:filePath];
        [_imageDownloader addTask:task];
    }
    
    //hihger prority
    path = [self documentDirectoryPathWithFolder:HigherProrityFolder];
    NSString* url = [NSString stringWithFormat:@"https://imagizer.imageshack.us/v2/120x120q90/c/6/dv0a.jpg"];
    NSString* lastPath = [url lastPathComponent];
    NSString* filePath = [path stringByAppendingPathComponent:lastPath];
    GCDTask* task = [[GCDTask alloc] initTaskWithID:11 forURL:url withPathToSave:filePath];
    [_imageDownloader addHighPriorityTask:task];
    
}

- (NSString*) documentDirectoryPathWithFolder:(NSString*)folderName{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:folderName];
    return fullPath;
}

#pragma mark - 
#pragma GCD DELEGATE
- (void) backgroundWorker:(GCDDownloadWorker*)worker didCompleteWithTask:(GCDTask*)task{
    
}
- (void) backgroundWorker:(GCDDownloadWorker*)worker didFailForTask:(GCDTask*)task withError:(NSError*)error{
    
}
@end
