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
#import "SJPlayerManager.h"
#import "MusicVC.h"

@interface TodayVC ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *numArray;

@end

@implementation TodayVC

static NSString *identifier = @"TodayCellID";

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
        TodayModel *model = [[TodayModel alloc]initTodayModelWithDict:dict];
        [self.dataSource addObject:model];
        
        [self.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"!!!!!!%@",error);
    }];
}

- (void)loadDataForManyTimes
{
    dispatch_source_t source =dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_event_handler(source,^{
        int count = dispatch_source_get_data(source);
        if (count == self.numArray.count) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        }
    });
    dispatch_resume(source);
    
    NSMutableArray *operations = [NSMutableArray array];
    for (NSString *str in self.numArray) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/music/detail/%@",str]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        //将请求对象封装成请求操作对象 区别于单任务
        AFHTTPRequestOperation *operation=[[AFHTTPRequestOperation alloc]initWithRequest:request];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];
        //开始异步请求操作
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict = responseObject[@"data"];
            TodayModel *model = [[TodayModel alloc]initTodayModelWithDict:dict];
            [self.dataSource addObject:model];
            dispatch_source_merge_data(source, 1);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"!!!!!!error%@",error);
        }];
        [operations addObject:operation];
    }
    
    //将多个请求对象放在队列中
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    //设置队列中请求对象的个数
    queue.maxConcurrentOperationCount = operations.count;
    //8.将所有请求对象存放在队列中
    [queue addOperations:operations waitUntilFinished:YES];
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
    if (sender.selected) {
        sender.selected = NO;
        [[SJPlayerManager defaultManager] pauseMusic:model.music_id];
    }else {
        sender.selected = YES;
        [[SJPlayerManager defaultManager] playingMusic:model.music_id];
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

@end
