//
//  ViewController.m
//  MoodNote
//
//  Created by qingyun on 16/1/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import "Common.h"
#import "AFNetworking.h"
#import "ContentCell.h"
#import "ContentModel.h"
#import "FXBlurView.h"
#import "BottomView.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *ContentArray;
@property (weak, nonatomic) IBOutlet FXBlurView *blurView;

@end

@implementation ViewController
static NSString *identifier = @"ContentCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSwipeGesture];
    [self loadDatas];
    [self CreateAndSetUpSubViews];
}

#pragma mark - Getter & Setter
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenH, kScreenW) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.transform = CGAffineTransformMakeRotation(-M_PI_2);
        _tableView.center = CGPointMake(kScreenW / 2, kScreenH / 2);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.pagingEnabled = YES;
//        _tableView.backgroundColor = [UIColor redColor];
        [_tableView registerNib:[UINib nibWithNibName:@"ContentCell" bundle:nil] forCellReuseIdentifier:identifier];
    }
    return _tableView;
}

- (NSMutableArray *)ContentArray {
    if (_ContentArray == nil) {
        _ContentArray = [NSMutableArray array];
    }
    return _ContentArray;
}

#pragma mark - CustomMethod

- (void)CreateAndSetUpSubViews
{
    [self.view addSubview:self.tableView];
    UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenBlurView)];
    [self.blurView addGestureRecognizer:click];
}

- (void)loadDatas
{
    //获取时间，日期
    NSDate *currentDate = [NSDate date];
    NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow:-(24 * 60 * 60)];
    //初始化一个时间格式化工具
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //设置时间格式
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    //将当前时间按照格式转化为字符串
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
//    NSLog(@"%@",dateString);
    //拼接URL字符串后部分
    NSString *suffixString = [@"ten" stringByAppendingPathComponent:dateString];
    //拼接完整的URL
    NSString *URLString = [kBaseURL stringByAppendingPathComponent:suffixString];
//    NSLog(@"%@",URLString);
    
    //使用AFNetWorking进行网络数据请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
        NSArray *tempArray = responseObject[@"content"];
        for (NSDictionary *dict in tempArray) {
            ContentModel *model = [[ContentModel alloc]initContentModelWithDictionary:dict];;
            [self.ContentArray addObject:model];
        }
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"!!!!!!%@",error);
    }];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ContentArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenW;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];

    cell.transform = CGAffineTransformMakeRotation(M_PI_2);

    [cell bandingContentCellWithModel:self.ContentArray[indexPath.row]];
    return cell;
}

#pragma mark - 手势
- (void)addSwipeGesture
{
    //添加下滑手势
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:[UIApplication sharedApplication].delegate action:@selector(swipeDownAction)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDown];
    
    //添加上滑手势
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeUpAction)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUp];
    
}

#pragma mark - 蒙版效果
- (void)swipeUpAction
{
    NSLog(@"UP");
#if 1
    for (UIView *subView in self.blurView.subviews) {
        if ([subView isKindOfClass:[BottomView class]]) {
            [subView removeFromSuperview];
        }
    }
    BottomView *bView = [BottomView bottomView];
    bView.frame = CGRectMake(0, kScreenH, kScreenW, kScreenH / 5);
    bView.alpha = 0.5;
    [self.blurView addSubview:bView];
    [self.view bringSubviewToFront:self.blurView];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.blurView.blurRadius = 15;
        
        bView.frame = CGRectMake(0, kScreenH / 6 * 5, kScreenW, kScreenH / 6);
        
    }];
#endif
}

- (void)hiddenBlurView
{
    [UIView animateWithDuration:0.5 animations:^{
        [self.view sendSubviewToBack:self.blurView];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
