//
//  AboutVC.m
//  MoodNote
//
//  Created by qingyun on 16/3/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "AboutVC.h"
#import "SDImageCache.h"
#import "AppDelegate.h"

@interface AboutVC ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *clearLabel;

@end

@implementation AboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.icon.layer.cornerRadius = 120 / 2;
    self.icon.clipsToBounds = YES;
    [self addSwipeGesture];
}

- (void)viewWillAppear:(BOOL)animated {
    NSString *memoryString = [NSString stringWithFormat:@"当前缓存:  %.2f Mb",[[SDImageCache sharedImageCache] getSize] / 1024.f / 1024.f];
    self.clearLabel.text = memoryString;
}

- (void)addSwipeGesture
{
    //添加下滑手势
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:[UIApplication sharedApplication].delegate action:@selector(swipeDownAction)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDown];
}

#pragma mark - ButtonAction
- (IBAction)helpAction:(UIButton *)sender {
    AppDelegate * app = [UIApplication sharedApplication].delegate;
    [app setRootVC];
}

- (IBAction)goodAction:(UIButton *)sender {
    //跳转到AppStore当前应用界面
    //当前应用的AppID
    int myAPPID = 1077987843;
    NSString *str = [NSString stringWithFormat:
                     @"itms-apps://itunes.apple.com/cn/app/encounter/id%d?mt=8",
                     myAPPID ];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (IBAction)clearAction:(UIButton *)sender {
    //清除缓存
    [[SDImageCache sharedImageCache] clearDisk];
    NSString *memoryString = [NSString stringWithFormat:@"当前缓存:  %.2f Mb",[[SDImageCache sharedImageCache] getSize] / 1024.f / 1024.f];
    self.clearLabel.text = memoryString;
}

- (IBAction)emailAction:(UIButton *)sender {
    NSMutableString *mailUrl = [[NSMutableString alloc]init];
    //添加收件人
    NSArray *toRecipients = [NSArray arrayWithObject: @"iGhibli@163.com"];
    [mailUrl appendFormat:@"mailto:%@", [toRecipients componentsJoinedByString:@","]];
    //添加抄送
    NSArray *ccRecipients = [NSArray arrayWithObjects:@"iGhibli@163.com", nil];
    [mailUrl appendFormat:@"?cc=%@", [ccRecipients componentsJoinedByString:@","]];
    //添加密送
    NSArray *bccRecipients = [NSArray arrayWithObjects:@"iGhibli@163.com", nil];
    [mailUrl appendFormat:@"&bcc=%@", [bccRecipients componentsJoinedByString:@","]];
    //添加主题
    [mailUrl appendString:@"&subject=Encounter遇见，心中的小美好。"];
    //添加邮件内容
    [mailUrl appendString:@"&body=<b>eyu,遇见就是缘分！</b> 您有什么建议或疑惑，请在这里写下并发送给我，我将随时为您解答！"];
    NSString* email = [mailUrl stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];
}

- (IBAction)aboutAction:(UIButton *)sender {
    //获取当前版本号
    NSString *message = [NSString stringWithFormat:@"Author: iGhibli\nEmail: iGhibli@163.com\nVersion: %@\n^_^ 谢谢使用 ^_^",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        // iOS 8.0+ code
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"关于遇见" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertC addAction:cancleAction];
        [self presentViewController:alertC animated:YES completion:nil];
    }else {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"关于遇见" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
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
