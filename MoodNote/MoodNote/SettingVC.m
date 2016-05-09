//
//  SettingVC.m
//  MoodNote
//
//  Created by 赛驰 on 16/5/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "SettingVC.h"
#import "AppDelegate.h"
#import "SDImageCache.h"

@interface SettingVC ()
@property (weak, nonatomic) IBOutlet UILabel *memoryLabel;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIImageView *messageImage;
@property (nonatomic, assign) BOOL isOn;

@end

@implementation SettingVC

- (void)viewWillAppear:(BOOL)animated {
    NSString *memoryStr = [NSString stringWithFormat:@"%.2f",[[SDImageCache sharedImageCache] getSize] / 1024.f / 1024.f];
    self.memoryLabel.text = memoryStr;
    // 读取用户偏好设置
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.isOn = [defaults boolForKey:@"SJLocalNotifications"];
    if (self.isOn) {
        self.messageImage.image = [UIImage imageNamed:@"me_message_on"];
    }else {
        self.messageImage.image = [UIImage imageNamed:@"me_message_off"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupShaowStyleTwoWith:self.topView];
    [self setupShaowStyleTwoWith:self.bottomView];
    [self addSwipeGesture];
}

- (void)setupShaowStyleTwoWith:(UIView *)view
{
    view.layer.masksToBounds = NO;
    //shadowColor阴影颜色
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    //shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    view.layer.shadowOffset = CGSizeMake(0,0);
    //阴影透明度，默认0
    view.layer.shadowOpacity = 0.8;
    //阴影半径，默认3
    view.layer.shadowRadius = 5;
}

- (void)addSwipeGesture
{
    //添加下滑手势
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:[UIApplication sharedApplication].delegate action:@selector(swipeDownAction)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDown];
}

#pragma mark - ButtonAction
- (IBAction)guideBtnAction:(UIButton *)sender {
    AppDelegate * app = [UIApplication sharedApplication].delegate;
    [app setRootVC];
}

- (IBAction)goodBtnAction:(UIButton *)sender {
    //跳转到AppStore当前应用界面
    //当前应用的AppID
    int myAPPID = 1077987843;
    NSString *str = [NSString stringWithFormat:
                     @"itms-apps://itunes.apple.com/cn/app/encounter/id%d?mt=8",
                     myAPPID ];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (IBAction)clearBtnAction:(UIButton *)sender {
    //清除缓存
    [[SDImageCache sharedImageCache] clearDisk];
    NSString *memoryString = [NSString stringWithFormat:@"%.2f",[[SDImageCache sharedImageCache] getSize] / 1024.f / 1024.f];
    self.memoryLabel.text = memoryString;
}

- (IBAction)feedBackBtnAction:(UIButton *)sender {
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

- (IBAction)aboutBtnAction:(UIButton *)sender {
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

- (IBAction)messageSwitch:(UIButton *)sender {
    if (self.isOn) {
        self.messageImage.image = [UIImage imageNamed:@"me_message_off"];
        self.isOn = NO;
        // 获取用户偏好设置对象
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        // 保存用户偏好设置
        [defaults setBool:NO forKey:@"SJLocalNotifications"];
        // 注意：UserDefaults设置数据时，不是立即写入，而是根据时间戳定时地把缓存中的数据写入本地磁盘。所以调用了set方法之后数据有可能还没有写入磁盘应用程序就终止了。
        // 出现以上问题，可以通过调用synchornize方法强制写入
        // 现在这个版本不用写也会马上写入 不过之前的版本不会
        [defaults synchronize];
    }else {
        self.messageImage.image = [UIImage imageNamed:@"me_message_on"];
        self.isOn = YES;
        // 获取用户偏好设置对象
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        // 保存用户偏好设置
        [defaults setBool:YES forKey:@"SJLocalNotifications"];
        // 注意：UserDefaults设置数据时，不是立即写入，而是根据时间戳定时地把缓存中的数据写入本地磁盘。所以调用了set方法之后数据有可能还没有写入磁盘应用程序就终止了。
        // 出现以上问题，可以通过调用synchornize方法强制写入
        // 现在这个版本不用写也会马上写入 不过之前的版本不会
        [defaults synchronize];
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
