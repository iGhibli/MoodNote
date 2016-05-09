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
#import "Common.h"

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
    NSString *message = [NSString stringWithFormat:@"于千万人之中，遇见你要遇见的人。\n于千万年之中，时间无涯的荒野里，\n没有早一步，也没有迟一步，\n遇上了也只能轻轻地说一句：\n“喔 原来你也在这里”\n我要你知道，\n在这个世界上总有一个人是等着你的，\n不管在什么时候，不管在什么地方，\n反正你知道，总有这么个人。\n\nAuthor: ZhouShuaijie\nEmail: iGhibli@163.com\nVersion: %@\n^_^ 感谢生命中遇见你 ^_^",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
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
        [self cancelLocalNotificationWithKey:KSJLocalNotificationKey];
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
        [self registerLocalNotification];
    }
    
}

// 设置本地通知
- (void)registerLocalNotification {
    //初始化一个 UILocalNotification
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    // 设置触发通知的时间
    NSDate *fireDate = [NSDate dateWithTimeIntervalSince1970:2*60*60+10];
    notification.fireDate = fireDate;
    // 时区
    notification.timeZone = [NSTimeZone defaultTimeZone];
    // 通知重复提示的单位，可以是天、周、月
    notification.repeatInterval = kCFCalendarUnitDay;
    // 通知内容
    notification.alertBody =  @"💞遇见你是我的缘，守望你是我的歌！一切等待不再是等待，我的一生就选择了你！我要你知道，在这个世界上总有一个人是等着你的，不管在什么时候，不管在什么地方.赶紧看看今天能遇见什么吧！💝";
    // 设置 icon 上 红色数字
    notification.applicationIconBadgeNumber = 1;
    // 通知被触发时播放的声音
    notification.soundName = UILocalNotificationDefaultSoundName;
    // 通知参数
    NSDictionary *userDict = [NSDictionary dictionaryWithObject:@"SJEncounter" forKey:KSJLocalNotificationKey];
    notification.userInfo = userDict;
    
    // ios8后，需要添加这个注册，才能得到授权
    float sysVersion=[[UIDevice currentDevice]systemVersion].floatValue;
    if (sysVersion>=8.0) {
        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    // 执行通知注册
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

// 取消某个本地推送通知
- (void)cancelLocalNotificationWithKey:(NSString *)key {
    // 获取所有本地通知数组
    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    //便利这个数组 根据 key 拿到我们想要的 UILocalNotification
    for (UILocalNotification *notification in localNotifications) {
        NSDictionary *userInfo = notification.userInfo;
        if (userInfo) {
            // 根据设置通知参数时指定的key来获取通知参数
            NSString *info = userInfo[key];
            
            // 如果找到需要取消的通知，则取消
            if ([info isEqualToString:@"SJEncounter"]) {
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
                break;
            }
        }
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
