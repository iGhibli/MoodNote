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
#import "DetailVC.h"
#import "NSString+Size.h"
#import "UIImageView+WebCache.h"

@interface FavoriteCVC ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSMutableArray *favorites;
@end

@implementation FavoriteCVC

static NSString * const reuseIdentifier = @"CCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSwipeGesture];
    self.collectionView.pagingEnabled = YES;
    [self.collectionView registerClass:[FavoriteCCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)viewWillAppear:(BOOL)animated {
    self.favorites = [NSMutableArray arrayWithArray:[DBEngine getFavoritesFromLocal]];
    [self.collectionView reloadData];
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
    FavoriteCCell *cell = (FavoriteCCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    ContentModel *model = self.favorites[indexPath.item];
    //图片的实际尺寸
    CGFloat realW = [model.picWidth floatValue];
    CGFloat realH = [model.picHeight floatValue];
    
    //图片显示的尺寸
    CGFloat displayW = kScreenW / 2.0 - 10 - 10;
    CGFloat displayH = realH * (kScreenW / 2.0 - 10 - 10) / realW;
    
    //文字显示的尺寸
    CGSize titleSize = [model.title sizeWithFont:[UIFont systemFontOfSize:10] AndWidth:kScreenW / 2.0 - 20];
    
    //图片和文字及间隔的总尺寸
    CGFloat totalH = displayH + 10 + titleSize.height;
    
    cell.title.font = [UIFont systemFontOfSize:10];
    cell.title.numberOfLines = 0;
    //控件布局
    if (totalH >= kScreenH / 2.0) {
        CGFloat scale = (kScreenH / 2.0 - titleSize.height - 10 - 10 - 10) / displayH;
        CGFloat picW = displayW * scale;
        CGFloat picH = displayH * scale;
        
        cell.icon.frame = CGRectMake((kScreenW / 2.0 - picW) / 2, 10, picW, picH);
        cell.title.frame = CGRectMake(10, cell.icon.frame.origin.y + picH + 10, titleSize.width, titleSize.height);
    }else {
        cell.icon.frame = CGRectMake(10, (kScreenH / 2.0 - totalH) / 2, displayW, displayH);
        cell.title.frame = CGRectMake(10, cell.icon.frame.origin.y + displayH + 10, titleSize.width, titleSize.height);
    }
    
    cell.title.text = model.title;
    //使用SDWebImage加载网络图片数据
    NSString *imageURLStr = [kImageBaseURL stringByAppendingPathComponent:model.pic_url];
    [cell.icon sd_setImageWithURL:[NSURL URLWithString:imageURLStr]];
    
    return cell;
}



#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize itemSize = CGSizeMake((kScreenW - 0) / 2.0, (kScreenH - 0) / 2.0);
    return itemSize;
}

#pragma mark <UICollectionViewDelegate>

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailVC *VC = [DetailVC new];
    VC.model = self.favorites[indexPath.item];
    [self presentViewController:VC animated:YES completion:nil];
}

@end
