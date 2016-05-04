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
#import "TodayView.h"
#import "TodayModel.h"

@interface TodayVC ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet JT3DScrollView *JTScorll;
@property (nonatomic, strong) NSMutableArray *numArray;
@property (nonatomic, strong) NSMutableArray *contentArray;

@end

@implementation TodayVC

- (void)viewDidLoad {
    [self loadDatas];
    [super viewDidLoad];
    [self addSwipeGesture];
}

- (NSMutableArray *)numArray {
    if (_numArray == nil) {
        _numArray = [NSMutableArray array];
    }
    return _numArray;
}

- (NSMutableArray *)contentArray {
    if (_contentArray == nil) {
        _contentArray = [NSMutableArray array];
    }
    return _contentArray;
}

#pragma mark - 手势
- (void)addSwipeGesture
{
    //添加下滑手势
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:[UIApplication sharedApplication].delegate action:@selector(swipeDownAction)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDown];
}

- (void)setupJTScrollView
{
    self.JTScorll.effect = JT3DScrollViewEffectDepth;
    self.JTScorll.delegate = self;
}

- (void)loadDatas
{
    //完整的URL
    NSString *URLString = @"http://v3.wufazhuce.com:8000/api/music/idlist/0";
//    NSString *URLString = @"http://v3.wufazhuce.com:8000/api/music/detail/90";

    //使用AFNetWorking进行网络数据请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *tempArray = responseObject[@"data"];
        for (NSString *str in tempArray) {
            [self.numArray addObject:str];
        }
        [self loadDataForManyTimes];
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
                [self addSubViews];
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
            [self.contentArray addObject:model];
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

- (void)addSubViews
{
    for (int i = 0; i < self.numArray.count; i++) {
        CGFloat width = CGRectGetWidth(self.JTScorll.frame);
        CGFloat height = CGRectGetHeight(self.JTScorll.frame);
        
        CGFloat x = self.JTScorll.subviews.count * width;
        
        TodayView *view = [[TodayView alloc] initWithFrame:CGRectMake(x, 0, width, height)];

        [view bandingTodayViewWithTodayModel:self.contentArray[i]];
        [self.JTScorll addSubview:view];
        self.JTScorll.contentSize = CGSizeMake(x + width, height);
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

@end
