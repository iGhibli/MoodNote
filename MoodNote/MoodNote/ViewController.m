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
#import "DBEngine.h"
#import "UMSocial.h"


@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *ContentArray;
@property (nonatomic, strong) FXBlurView *blurView;
@property (nonatomic, strong) ContentModel *currentModel;
@property (nonatomic, strong) NSArray *favoriteModels;
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
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.transform = CGAffineTransformMakeRotation(-M_PI_2);
        _tableView.center = CGPointMake(kScreenW / 2, kScreenH / 2);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.pagingEnabled = YES;
//        _tableView.backgroundColor = [UIColor redColor];
        [_tableView registerNib:[UINib nibWithNibName:@"ContentCell" bundle:nil] forCellReuseIdentifier:identifier];
    }
    return _tableView;
}

- (FXBlurView *)blurView {
    if (_blurView == nil) {
        
        _blurView = [[FXBlurView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [self.view addSubview:_blurView];
        UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenBlurView)];
        [_blurView addGestureRecognizer:click];
        
        UIView *bottomView = [[UIView alloc]init];
        bottomView.frame = CGRectMake(0, kScreenH * 5 / 6, kScreenW, kScreenH / 6);
        bottomView.backgroundColor = [UIColor grayColor];
        bottomView.alpha = 0.5;
        bottomView.tag = 23;
        [_blurView addSubview:bottomView];
        
        //创建HomeButton
        UIButton *copyBtn = [[UIButton alloc]init];
        copyBtn.center = CGPointMake(kScreenW / 4, kScreenH / 6 / 2);
        copyBtn.bounds = CGRectMake(0, 0, kScreenH / 6, kScreenH / 6);
        [copyBtn setImage:[UIImage imageNamed:@"btn-copyfile"] forState:UIControlStateNormal];
        [copyBtn setImage:[UIImage imageNamed:@"btn-copyfile-2"] forState:UIControlStateHighlighted];
        [copyBtn addTarget:self action:@selector(bottomViewButtonActionWithTag:) forControlEvents:UIControlEventTouchUpInside];
        copyBtn.tag = 20;
        [bottomView addSubview:copyBtn];
        
        //创建HomeButton
        UIButton *likeBtn = [[UIButton alloc]init];
        likeBtn.center = CGPointMake(kScreenW * 3 / 4, kScreenH / 6 / 2);
        likeBtn.bounds = CGRectMake(0, 0, kScreenH / 6, kScreenH / 6);
        [likeBtn setImage:[UIImage imageNamed:@"btn-like-1"] forState:UIControlStateNormal];
        [likeBtn setImage:[UIImage imageNamed:@"btn-like-2"] forState:UIControlStateHighlighted];
        [likeBtn setImage:[UIImage imageNamed:@"btn-like-3"] forState:UIControlStateSelected];
        [likeBtn addTarget:self action:@selector(bottomViewButtonActionWithTag:) forControlEvents:UIControlEventTouchUpInside];
        likeBtn.tag = 22;
        [bottomView addSubview:likeBtn];
        
        //创建FavoriteButton
        UIButton *shareBtn = [[UIButton alloc]init];
        shareBtn.center = CGPointMake(kScreenW / 2, kScreenH / 6 / 2);
        shareBtn.bounds = CGRectMake(0, 0, kScreenH / 6, kScreenH / 6);
        [shareBtn setImage:[UIImage imageNamed:@"btn-link"] forState:UIControlStateNormal];
        [shareBtn setImage:[UIImage imageNamed:@"btn-link-2"] forState:UIControlStateHighlighted];
        [shareBtn addTarget:self action:@selector(bottomViewButtonActionWithTag:) forControlEvents:UIControlEventTouchUpInside];
        shareBtn.tag = 21;
        [bottomView addSubview:shareBtn];
        
    }
    return _blurView;
}

- (NSMutableArray *)ContentArray {
    if (_ContentArray == nil) {
        _ContentArray = [NSMutableArray array];
    }
    return _ContentArray;
}

- (NSArray *)favoriteModels {
    if (_favoriteModels == nil) {
        _favoriteModels = [NSArray array];
    }
    return _favoriteModels;
}

#pragma mark - CustomMethod

- (void)CreateAndSetUpSubViews
{
    [self.view addSubview:self.tableView];
    
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.transform = CGAffineTransformMakeRotation(M_PI_2);

    [cell bandingContentCellWithModel:self.ContentArray[indexPath.row]];
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
#pragma mark - 截屏
    
    //1.开启图片上下文
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, YES, 0.0);
    //2.获取当前上下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    //3.绘制
    [self.view.layer renderInContext:ctx];
    //4.取出图片，
    UIImage *currentImage=UIGraphicsGetImageFromCurrentImageContext();
    NSData *imageData=UIImagePNGRepresentation(currentImage);
    
    NSString *tempPath = NSTemporaryDirectory();
    NSString *imageDataPath = [tempPath stringByAppendingPathComponent:@"CurrentScreenData"];
//    NSLog(@"%@",imageDataPath);
    [imageData writeToFile:imageDataPath atomically:YES];
    //.关闭图形上下文
    UIGraphicsEndImageContext();
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentModel = self.ContentArray[indexPath.row];
//    NSLog(@"%@",self.currentModel);
    self.favoriteModels = [DBEngine getFavoritesFromLocal];
    UIButton *likebtn;
    UIView *view = self.blurView.subviews.firstObject;
    for (UIButton *btn in view.subviews) {
        if (btn.tag == 22) {
            likebtn = btn;
        }
    }
    
    for (ContentModel *model in self.favoriteModels) {
        if ([model.ID intValue] == [self.currentModel.ID intValue] ) {
            likebtn.selected = YES;
            [self.view bringSubviewToFront:self.blurView];
            
            [UIView animateWithDuration:0.5 animations:^{
                self.blurView.blurRadius = 15;
            }];
            return;
        }
    }
    likebtn.selected = NO;
    [self.view bringSubviewToFront:self.blurView];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.blurView.blurRadius = 15;
    }];
    
}

#pragma mark - 手势
- (void)addSwipeGesture
{
    //添加下滑手势
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:[UIApplication sharedApplication].delegate action:@selector(swipeDownAction)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDown];
}

#pragma mark - Action

- (void)bottomViewButtonActionWithTag:(UIButton *)sender
{
    switch (sender.tag) {
        case 20:
            [self copyAction];
            break;
        case 21:
            [self shareAction];
            break;
        case 22:
            [self likeActionWithButton:sender];
            break;
            
        default:
            break;
    }
}

- (void)copyAction
{
    //获取剪切板
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    //将内容赋值给剪切板
    pasteBoard.string = self.currentModel.title;
    UILabel *popLabel = [[UILabel alloc]init];
    popLabel.textAlignment = NSTextAlignmentCenter;
    popLabel.font = [UIFont systemFontOfSize:12];
    popLabel.text = @"已复制美句到剪切板";
    popLabel.layer.cornerRadius = 10;
    popLabel.clipsToBounds = YES;
    popLabel.backgroundColor = [UIColor orangeColor];
    popLabel.frame = CGRectMake(75, kScreenH * 5 / 6 - 40, kScreenW - 150, 20);
    [self.view addSubview:popLabel];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:popLabel selector:@selector(removeFromSuperview) userInfo:nil repeats:NO];
}

- (void)shareAction
{
#pragma mark - UM分享
    //获取Tempora目录下存储的截屏文件路径
    NSString *tempPath = NSTemporaryDirectory();
    NSString *imageDataPath = [tempPath stringByAppendingPathComponent:@"CurrentScreenData"];
    UIImage *shareImage = [UIImage imageWithData:[NSData dataWithContentsOfFile:imageDataPath]];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"56a3781a67e58e9bf7002cac"
                                      shareText:[self.currentModel.title stringByAppendingString:@"      --来自Encounter遇见，心中的小美好。"]
                                     shareImage:shareImage
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToEmail,UMShareToSms,nil]
                                       delegate:nil];
}

- (void)likeActionWithButton:(UIButton *)btn
{
    if (btn.selected) {
        btn.selected = NO;
        UILabel *popLabel = [[UILabel alloc]init];
        popLabel.textAlignment = NSTextAlignmentCenter;
        popLabel.font = [UIFont systemFontOfSize:12];
        popLabel.text = @"取消收藏成功";
        popLabel.layer.cornerRadius = 10;
        popLabel.clipsToBounds = YES;
        popLabel.backgroundColor = [UIColor orangeColor];
        popLabel.frame = CGRectMake(75, kScreenH * 5 / 6 - 40, kScreenW - 150, 20);
        [self.view addSubview:popLabel];
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:popLabel selector:@selector(removeFromSuperview) userInfo:nil repeats:NO];
        
        [DBEngine deleteDataWithID:self.currentModel.ID];
    }else {
        btn.selected = YES;
        UILabel *popLabel = [[UILabel alloc]init];
        popLabel.textAlignment = NSTextAlignmentCenter;
        popLabel.font = [UIFont systemFontOfSize:12];
        popLabel.text = @"收藏成功";
        popLabel.layer.cornerRadius = 10;
        popLabel.clipsToBounds = YES;
        popLabel.backgroundColor = [UIColor orangeColor];
        popLabel.frame = CGRectMake(75, kScreenH * 5 / 6 - 40, kScreenW - 150, 20);
        [self.view addSubview:popLabel];
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:popLabel selector:@selector(removeFromSuperview) userInfo:nil repeats:NO];
        
        [DBEngine saveToLocalWithModel:self.currentModel];
    }
}

- (void)hiddenBlurView
{
    [UIView animateWithDuration:0.5 animations:^{
        [self.view sendSubviewToBack:self.blurView];
    }];
}

@end
