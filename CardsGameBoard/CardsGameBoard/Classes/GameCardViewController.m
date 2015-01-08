//
//  ViewController.m
//  CardsGameBoard
//
//  Created by Saurav Nagpal on 06/01/15.
//  Copyright (c) 2015 Saurav Nagpal. All rights reserved.
//

#import "GameCardConstant.h"
#import "GameCardViewController.h"

@interface GameCardViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *gridView;
@property (nonatomic, assign)NSUInteger  gridCount;

@end

@implementation GameCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareGameView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _gridCount;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cardCell = [collectionView dequeueReusableCellWithReuseIdentifier:SBID_GRID_CELL forIndexPath:indexPath];
    cardCell.backgroundColor = [UIColor whiteColor];
    return cardCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    // Prepare for animation
    
    [_gridView.collectionViewLayout invalidateLayout];
    UICollectionViewCell *cell = [_gridView cellForItemAtIndexPath:indexPath];
    [UIView transitionWithView:cell duration:0.15f options: UIViewAnimationOptionTransitionFlipFromRight animations:^(){
         CGRect frame = cell.frame;
         frame.size = CGSizeZero;
         cell.frame = frame;
    } completion:^(BOOL isFinish){
        [self showCellAnimation:cell];
    }];
}

- (void) showCellAnimation:(UICollectionViewCell*)cell{
    [UIView transitionWithView:cell duration:0.15f options: UIViewAnimationOptionTransitionFlipFromRight animations:^(){
        CGRect frame = cell.frame;
        frame.size = CGSizeMake(50, 50);
        cell.frame = frame;
        [cell setBackgroundColor:[UIColor blueColor]];
    } completion:^(BOOL isFinish){
        
    }];
}

- (void) prepareGameView{
    _gridCount = GRID_SIZE * GRID_SIZE;
    CGRect gridFrame = _gridView.frame;
    gridFrame.size.width = gridFrame.size.height = (GRID_SIZE * 50) + (GRID_SIZE * 10) + 10;
    gridFrame.origin.x = (self.view.frame.size.width - gridFrame.size.width)/2;
    gridFrame.origin.y = (self.view.frame.size.height - gridFrame.size.height)/2;
    _gridView.frame = gridFrame;
    
}

@end
