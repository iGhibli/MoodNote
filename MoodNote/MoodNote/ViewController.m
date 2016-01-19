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

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *ContentArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDatas];
    [self CreateAndSetUpSubViews];
}

- (void)CreateAndSetUpSubViews
{
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenH, ScreenW) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.transform = CGAffineTransformMakeRotation(-M_PI_2);
        _tableView.center = CGPointMake(ScreenW / 2, ScreenH / 2);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.pagingEnabled = YES;
        _tableView.backgroundColor = [UIColor redColor];
    }
    return _tableView;
}

#pragma mark - CustomMethod

- (void)loadDatas
{
    //获取当前时间，日期
    NSDate *currentDate = [NSDate date];
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
    NSString *URLString = [BaseURL stringByAppendingPathComponent:suffixString];
//    NSLog(@"%@",URLString);
    
    //使用AFNetWorking进行网络数据请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"!!!!!!%@",error);
    }];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScreenW;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
    }
    cell.transform = CGAffineTransformMakeRotation(M_PI_2);
    cell.textLabel.text = @"TEST";
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
