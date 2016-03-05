//
//  FavoriteCVC.m
//  MoodNote
//
//  Created by qingyun on 16/3/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "FavoriteCVC.h"
#import "ContentModel.h"
#import "DBEngine.h"
#import "FavoriteCCell.h"
#import "Common.h"
#import "UMSocial.h"

@interface FavoriteCVC ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) NSMutableArray *favorites;
@end

@implementation FavoriteCVC

static NSString * const reuseIdentifier = @"CCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSwipeGesture];
    
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)addSwipeGesture
{
    //添加下滑手势
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:[UIApplication sharedApplication].delegate action:@selector(swipeDownAction)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDown];
}

#pragma mark - Getter & Setter

- (NSArray *)favorites {
    if (_favorites == nil) {
        _favorites = [NSMutableArray array];
        _favorites = [NSMutableArray arrayWithArray:[DBEngine getFavoritesFromLocal]];
    }
    return _favorites;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.favorites.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FavoriteCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell bandingFavoriteCCellWithModel:self.favorites[indexPath.item]];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
