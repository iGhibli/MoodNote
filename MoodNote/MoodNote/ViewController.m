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

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *ContentArray;
@end

@implementation ViewController
static NSString *identifier = @"ContentCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDatas];
    [self CreateAndSetUpSubViews];
}

#pragma mark - Getter & Setter
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
}

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
        NSArray *tempArray = responseObject[@"content"];
        
        self.ContentArray = [NSMutableArray arrayWithArray:tempArray];
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
    return ScreenW;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
//    if (cell == nil) {
//        cell = [[ContentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//    }
    cell.transform = CGAffineTransformMakeRotation(M_PI_2);
//    cell.textLabel.numberOfLines = 0;
//    cell.textLabel.text = self.ContentArray[indexPath.row][@"title"];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
