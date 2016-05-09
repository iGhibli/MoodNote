//
//  TodayVC.m
//  MoodNote
//
//  Created by 赛驰 on 16/5/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "TodayVC.h"
#import "AFNetworking.h"
#import "JT3DScrollView.h"
#import "TodayCell.h"
#import "TodayModel.h"
#import "Common.h"
#import "ZFPlayer.h"
#import "MusicVC.h"

@interface TodayVC ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *numArray;
@property (nonatomic, strong) ZFPlayerView *playerView;
@property (nonatomic, strong) NSString *currentTitle;

@end

@implementation TodayVC

static NSString *identifier = @"TodayCellID";

- (void)dealloc {
    [self.playerView resetPlayer];
}

- (void)viewDidLoad {
    [self loadDatas];
    [super viewDidLoad];
    [self addSwipeGesture];
    [self setupCollectionView];
}

#pragma mark - Getter & Setter
- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)numArray {
    if (_numArray == nil) {
        _numArray = [NSMutableArray array];
    }
    return _numArray;
}

#pragma mark - 手势
- (void)addSwipeGesture
{
    //添加下滑手势
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:[UIApplication sharedApplication].delegate action:@selector(swipeDownAction)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDown];
}

- (void)setupCollectionView
{
    self.collectionView.pagingEnabled = YES;
    [self.collectionView registerNib:[UINib nibWithNibName:@"TodayCell" bundle:nil] forCellWithReuseIdentifier:identifier];
}

- (void)loadDatas
{
    //完整的URL
    NSString *URLString = @"http://v3.wufazhuce.com:8000/api/music/idlist/0";

    //使用AFNetWorking进行网络数据请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *tempArray = responseObject[@"data"];
        for (NSString *str in tempArray) {
            [self.numArray addObject:str];
            [self loadDetailDataWithIDStr:str];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"!!!!!!%@",error);
    }];
}

- (void)loadDetailDataWithIDStr:(NSString *)str
{
    //完整的URL
    NSString *URLString = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/music/detail/%@",str];
    
    //使用AFNetWorking进行网络数据请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = responseObject[@"data"];
        NSLog(@"------>%@",dict);
        TodayModel *model = [[TodayModel alloc]initTodayModelWithDict:dict];
        [self.dataSource addObject:model];
        
        [self.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"!!!!!!%@",error);
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TodayModel *model = self.dataSource[indexPath.row];
    TodayCell *cell = (TodayCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [cell bandingTodayCellWithTodayModel:model];
    cell.playBtn.tag = indexPath.item;
    [cell.playBtn addTarget:self action:@selector(playBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)playBtnAction:(UIButton *)sender
{
    TodayModel *model = self.dataSource[sender.tag];
    NSLog(@"----->%@",model.music_id);
    if (sender.selected) {
        sender.selected = NO;
        [self.playerView resetPlayer];
        self.currentTitle = nil;
    }else {
        sender.selected = YES;
        [self.playerView resetPlayer];
        self.playerView = [ZFPlayerView playerView];
        NSURL *URL = [NSURL URLWithString:model.music_id];
        // 设置player相关参数
        [self.playerView setVideoURL:URL];
        self.currentTitle = model.title;
    }
}

#pragma mark <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize itemSize = CGSizeMake(kScreenW, kScreenH);
    return itemSize;
}

#pragma mark <UICollectionViewDelegate>
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TodayModel *model = self.dataSource[indexPath.item];
    UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MusicVC *VC = [SB instantiateViewControllerWithIdentifier:@"MusicVCID"];
    VC.model = model;
    [self presentViewController:VC animated:YES completion:nil];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    TodayCell *willCell = (TodayCell *)cell;
    TodayModel *model = self.dataSource[indexPath.row];
    if ([self.currentTitle isEqualToString:model.title]) {
        willCell.playBtn.selected = YES;
    }else {
        willCell.playBtn.selected = NO;
    }
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

#pragma mark - 控制屏幕旋转
- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
