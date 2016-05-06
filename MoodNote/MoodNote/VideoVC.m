//
//  VideoVC.m
//  MoodNote
//
//  Created by 赛驰 on 16/5/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "VideoVC.h"
#import "VideoModel.h"
#import "VideoCell.h"
#import "Common.h"
#import "AFNetworking.h"
#import "VideoDetailVC.h"

@interface VideoVC ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation VideoVC

static NSString *identifier = @"VideoCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    bgImageView.image = [UIImage imageNamed:@"BG"];
    [self.view addSubview:bgImageView];
    [self.view sendSubviewToBack:bgImageView];
    
    [self addSwipeGesture];
    [self setupCollectionView];
    [self loadDatas];
}

#pragma mark - Getter & Setter
- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
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
    [self.collectionView registerNib:[UINib nibWithNibName:@"VideoCell" bundle:nil] forCellWithReuseIdentifier:identifier];
}

- (void)loadDatas
{
    //获取时间，日期
    NSDate *currentDate = [NSDate date];
    //    NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow:-(24 * 60 * 60)];
    //初始化一个时间格式化工具
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //设置时间格式
    [dateFormatter setDateFormat:@"YYYYMMdd"];
    //将当前时间按照格式转化为字符串
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    //拼接完整的URL
    NSString *URLString = [kVideoBaseURL stringByReplacingOccurrencesOfString:@"19921010" withString:dateString];
        NSLog(@"%@",URLString);
    //使用AFNetWorking进行网络数据请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"%@",responseObject);
        NSArray *dailyList = responseObject[@"dailyList"];
        for (NSDictionary *dict in dailyList) {
            NSArray *videoList = dict[@"videoList"];
            for (NSDictionary *tempDict in videoList) {
                VideoModel *model = [[VideoModel alloc]initVideoModelWithDictionary:tempDict];;
                [self.dataSource addObject:model];
            }
        }
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
    VideoModel *model = self.dataSource[indexPath.row];
    VideoCell *cell = (VideoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [cell bandingVideoCellWithModel:model];
    return cell;
}

#pragma mark <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize itemSize = CGSizeMake(kScreenW, (kScreenH / 3));
    return itemSize;
}

#pragma mark <UICollectionViewDelegate>
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    VideoModel *model = self.dataSource[indexPath.row];
    UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VideoDetailVC *VC = [SB instantiateViewControllerWithIdentifier:@"VideoDetailVCID"];
    VC.videoUrlStr = model.playUrl;
    VC.titleText = model.title;
    VC.descText = model.desc;
    VC.coverBlurred = model.coverBlurred;
    VC.coverForDetail = model.coverForDetail;
    VC.timeText = model.duration;
    VC.sortText = model.category;
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
