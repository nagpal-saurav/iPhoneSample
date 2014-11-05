//
//  ViewController.m
//  SNSideMenu
//
//  Created by Saurav Nagpal on 31/10/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

#import "SSRevealViewController.h"

#define mCellIdentifier      @"revealViewCell"
#define mExposedWidth        200.0

@interface SSRevealViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *slideMenuListView;
@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic, strong) NSArray *slideMenuTitles;
@property (nonatomic, assign) NSInteger indexOfVisibleController;
@property (nonatomic, assign) BOOL isMenuVisible;

- (CGRect)offScreenFrame;
- (void) displayVisbleViewController;
- (void) adjustFrameOnSlideMenuVisibilty;
- (void) replaceVisibleViewControllerWithViewControllerAtIndex:(NSInteger)index;

@end

@implementation SSRevealViewController

#pragma mark - ViewController Life Cycle
- (id)initWithViewControllers:(NSArray *)viewControllers andMenuTitles:(NSArray *)titles{
    if(self = [super init]){
        NSAssert(viewControllers.count == titles.count, [NSString stringWithFormat:@"Every View controller should have menu titles"]);
        NSMutableArray* tempViewControllers = [NSMutableArray arrayWithCapacity:viewControllers.count];
        self.slideMenuTitles = [titles copy];
        
        for (UIViewController* viewCtrl in viewControllers) {
            if([viewCtrl isMemberOfClass:[UINavigationController class]]){
                [tempViewControllers addObject:viewCtrl];
            }else{
                [tempViewControllers addObject:[[UINavigationController alloc] initWithRootViewController:viewCtrl]];
            }
            
            UIBarButtonItem* revealMenuBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(revealMenuItemPressed:)];
            UIViewController* viewCtrl = [(UINavigationController*)tempViewControllers.lastObject topViewController];
            viewCtrl.navigationItem.leftBarButtonItems = [@[revealMenuBarButtonItem] arrayByAddingObjectsFromArray:viewCtrl.navigationItem.leftBarButtonItems];
        }
        self.viewControllers = [tempViewControllers copy];
        self.slideMenuListView = [[UITableView alloc] init];
        self.slideMenuListView.delegate = self;
        self.slideMenuListView.dataSource = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.slideMenuListView registerClass:[UITableViewCell class] forCellReuseIdentifier:mCellIdentifier];
    self.slideMenuListView.frame = self.view.bounds;
    [self.view addSubview:self.slideMenuListView];
    self.indexOfVisibleController = 0;
    [self displayVisbleViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.slideMenuTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mCellIdentifier];
    cell.textLabel.text = self.slideMenuTitles[indexPath.row];
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self replaceVisibleViewControllerWithViewControllerAtIndex:indexPath.row];
}

#pragma mark - IBAction

- (IBAction) revealMenuItemPressed:(id)sender{
    self.isMenuVisible = !self.isMenuVisible;
    [self adjustFrameOnSlideMenuVisibilty];
}

#pragma mark - Reusable Method

- (void) displayVisbleViewController{
    
    UIViewController* visibleViewCtrl = [self.viewControllers objectAtIndex:self.indexOfVisibleController];
    [self addChildViewController:visibleViewCtrl];
    [self.view addSubview:visibleViewCtrl.view];
    self.isMenuVisible = NO;
    [self adjustFrameOnSlideMenuVisibilty];
    [visibleViewCtrl didMoveToParentViewController:self];
}

- (void) adjustFrameOnSlideMenuVisibilty{
    UIViewController *visibleViewController = self.viewControllers[self.indexOfVisibleController];
    CGSize viewCtrlSize = visibleViewController.view.frame.size;
    if(self.isMenuVisible){
         [UIView animateWithDuration:0.5 animations:^{
             visibleViewController.view.frame = CGRectMake(mExposedWidth, 0, viewCtrlSize.width, viewCtrlSize.height);
         }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
             visibleViewController.view.frame = CGRectMake(0, 0, viewCtrlSize.width, viewCtrlSize.height);
        }];
    }
    
}

- (void) replaceVisibleViewControllerWithViewControllerAtIndex:(NSInteger)index{
     if (index == self.indexOfVisibleController) return;
    UIViewController *newViewController = self.viewControllers[index];
    UIViewController *currentViewController = self.viewControllers[self.indexOfVisibleController];
    
    CGRect visibleFrame = self.view.bounds;
    [currentViewController willMoveToParentViewController:nil];
    [self addChildViewController:newViewController];
    newViewController.view.frame = [self offScreenFrame];
    [newViewController beginAppearanceTransition:YES animated:NO];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [self transitionFromViewController:currentViewController toViewController:newViewController
                              duration:0.5 options:UIViewAnimationOptionTransitionNone
                            animations:^{
                                [newViewController.view setFrame:visibleFrame];
                            } completion:^(BOOL finished){
                                [self didMoveToParentViewController:newViewController];
                                [currentViewController removeFromParentViewController];
                                self.isMenuVisible = NO;
                                self.indexOfVisibleController = index;
                                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                            }];
    
    
    
}

- (CGRect)offScreenFrame
{
    return CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
}

@end
