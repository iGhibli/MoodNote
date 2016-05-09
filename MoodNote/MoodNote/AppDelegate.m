//
//  AppDelegate.m
//  MoodNote
//
//  Created by qingyun on 16/1/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "AppDelegate.h"
#import "Common.h"
#import "FXBlurView.h"
#import "UMSocial.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialWechatHandler.h"
#import "GuideVC.h"

@interface AppDelegate ()
@property (nonatomic, strong) FXBlurView *blurView;
@end

@implementation AppDelegate

- (FXBlurView *)blurView {
    if (_blurView == nil) {
        CGFloat btnW = kScreenW / 7;
        _blurView = [[FXBlurView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [self.window addSubview:_blurView];
//        TopView *tView = [TopView topView];
        
        UIView *topView = [[UIView alloc]init];
        topView.frame = CGRectMake(0, 0, kScreenW, kScreenH / 6);
        topView.backgroundColor = [UIColor grayColor];
//        topView.alpha = 1.0;
        [_blurView addSubview:topView];
        
        //创建HomeButton
        UIButton *homeBtn = [[UIButton alloc]init];
        homeBtn.center = CGPointMake(kScreenW / 6, kScreenH / 6 / 2);
        homeBtn.bounds = CGRectMake(0, 0, btnW, btnW);
        UIImage *homeImage = [UIImage imageNamed:@"btn_main_normal"];
        homeImage = [homeImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [homeBtn setImage:homeImage forState:UIControlStateNormal];
        homeBtn.tintColor = [UIColor whiteColor];
        [homeBtn setImage:[UIImage imageNamed:@"btn_main_highlight"] forState:UIControlStateHighlighted];
        [homeBtn addTarget:self action:@selector(switchoverVCWithButton:) forControlEvents:UIControlEventTouchUpInside];
        homeBtn.tag = 10;
        [topView addSubview:homeBtn];
        
        //创建TodayButton
        UIButton *todayBtn = [[UIButton alloc]init];
        todayBtn.center = CGPointMake(kScreenW * 2 / 6, kScreenH / 6 / 2);
        todayBtn.bounds = CGRectMake(0, 0, btnW, btnW);
        todayBtn.tintColor = [UIColor whiteColor];
        UIImage *todayImage = [UIImage imageNamed:@"btn_today"];
        todayImage = [todayImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [todayBtn setImage:todayImage forState:UIControlStateNormal];
        [todayBtn setImage:[UIImage imageNamed:@"btn_today_h"] forState:UIControlStateHighlighted];
        [todayBtn addTarget:self action:@selector(switchoverVCWithButton:) forControlEvents:UIControlEventTouchUpInside];
        todayBtn.tag = 11;
        [topView addSubview:todayBtn];
        
        //创建VideoButton
        UIButton *videoBtn = [[UIButton alloc]init];
        videoBtn.center = CGPointMake(kScreenW * 3 / 6, kScreenH / 6 / 2);
        videoBtn.bounds = CGRectMake(0, 0, btnW, btnW);
        videoBtn.tintColor = [UIColor whiteColor];
        UIImage *videoImage = [UIImage imageNamed:@"btn_video"];
        videoImage = [videoImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [videoBtn setImage:videoImage forState:UIControlStateNormal];
        [videoBtn setImage:[UIImage imageNamed:@"btn_video_h"] forState:UIControlStateHighlighted];
        [videoBtn addTarget:self action:@selector(switchoverVCWithButton:) forControlEvents:UIControlEventTouchUpInside];
        videoBtn.tag = 12;
        [topView addSubview:videoBtn];
        
        //创建FavoriteButton
        UIButton *favoriteBtn = [[UIButton alloc]init];
        favoriteBtn.center = CGPointMake(kScreenW * 4 / 6, kScreenH / 6 / 2);
        favoriteBtn.bounds = CGRectMake(0, 0, btnW, btnW);
        favoriteBtn.tintColor = [UIColor whiteColor];
        UIImage *favoriteImage = [UIImage imageNamed:@"btn_fav_normal"];
        favoriteImage = [favoriteImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [favoriteBtn setImage:favoriteImage forState:UIControlStateNormal];
        [favoriteBtn setImage:[UIImage imageNamed:@"btn_fav_highlight"] forState:UIControlStateHighlighted];
        [favoriteBtn addTarget:self action:@selector(switchoverVCWithButton:) forControlEvents:UIControlEventTouchUpInside];
        favoriteBtn.tag = 13;
        [topView addSubview:favoriteBtn];
        
        //创建SettingButton
        UIButton *settingBtn = [[UIButton alloc]init];
        settingBtn.center = CGPointMake(kScreenW * 5 / 6, kScreenH / 6 / 2);
        settingBtn.bounds = CGRectMake(0, 0, btnW, btnW);
        settingBtn.tintColor = [UIColor whiteColor];
        UIImage *settingImage = [UIImage imageNamed:@"btn_setting_normal"];
        settingImage = [settingImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [settingBtn setImage:settingImage forState:UIControlStateNormal];
        [settingBtn setImage:[UIImage imageNamed:@"btn_setting_highlight"] forState:UIControlStateHighlighted];
        [settingBtn addTarget:self action:@selector(switchoverVCWithButton:) forControlEvents:UIControlEventTouchUpInside];
        settingBtn.tag = 14;
        [topView addSubview:settingBtn];
    }
    return _blurView;
}

- (void)swipeDownAction
{
    NSLog(@"APP");
    
    [self.window bringSubviewToFront:self.blurView];
    [UIView animateWithDuration:0.5 animations:^{
        self.blurView.blurRadius = 15;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"AAAA");
    [self.window sendSubviewToBack:_blurView];
}

#pragma mark - VC切换
- (void)switchoverVCWithButton:(UIButton *)sender
{
    switch (sender.tag) {
        case 10:
            [self switchoverVCWithIdentifier:@"HomeVCID"];
            break;
        case 11:
            [self switchoverVCWithIdentifier:@"TodayVCID"];
            break;
        case 12:
            [self switchoverVCWithIdentifier:@"VideoVCID"];
            break;
        case 13:
            [self switchoverVCWithIdentifier:@"FavoriteCVCID"];
            break;
        case 14:
            [self switchoverVCWithIdentifier:@"SettingVCID"];
            break;
            
        default:
            break;
    }
}

- (void)switchoverVCWithIdentifier:(NSString *)VCID
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:VCID];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSURL *defaultPrefsFile = [[NSBundle mainBundle] URLForResource:@"DefaultPreferences" withExtension:@"plist"];
    NSDictionary *defaultPrefs = [NSDictionary dictionaryWithContentsOfURL:defaultPrefsFile];
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultPrefs];
/****************************Umeng分享*****************************/
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:@"56a3781a67e58e9bf7002cac"];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wxdcd7e3c164f780dd" appSecret:@"625d39f9076ffd870d16d763704a0b08" url:@"https://itunes.apple.com/app/id1077987843"];
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"4292852456"
                                              secret:@"2d47c9da108e59ee2d7164c4dd6fc378"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
/*****************************************************************/
    // 读取用户偏好设置
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL isOn = [defaults boolForKey:@"SJLocalNotifications"];
    if (isOn == YES) {
        //下午
        [self registerLocalNotification:15.5*60*60*24];
        NSLog(@"开启本地通知");
    }else if(isOn == NO){
        [self cancelLocalNotificationWithKey:KSJLocalNotificationKey];
        NSLog(@"关闭本地通知");
    }
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];

    self.window.rootViewController = [self determineIsFirst];

    [self.window makeKeyAndVisible];

    return YES;
}

- (UIViewController *)determineIsFirst {
    /**
     * 判断当前版本号，确定是否显示新手引导页
     */
    //取出当前版本
    NSString *currentVersion = [[NSBundle mainBundle]objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    //取出本地存储版本
    NSString *localVersion = [[NSUserDefaults standardUserDefaults]objectForKey:kAppVersion];
    //判断两个版本是否相同，确定是否显示引导页
    if ([currentVersion isEqualToString:localVersion]) {
        return [self instantiateVCWithIdentifier:@"HomeVCID"];
    }else {
        return [self instantiateVCWithIdentifier:@"GuideVCID"];
    }
}

- (UIViewController *)instantiateVCWithIdentifier:(NSString *)VCID
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:VCID];
}

- (void)guideEnd
{
    self.window.rootViewController = [self instantiateVCWithIdentifier:@"HomeVCID"];
    //引导结束，更新本地保存的版本
    NSString *currentVersion = [[NSBundle mainBundle]objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    //设置本地保存路径
    [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:kAppVersion];
    //更新到物理文件中
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)setRootVC
{
    self.window.rootViewController = [self instantiateVCWithIdentifier:@"GuideVCID"];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    //取消徽章
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}

// 本地通知回调函数，当应用程序在前台时调用
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSLog(@"SJNotification:%@",notification);
    
    // 这里真实需要处理交互的地方
    // 获取通知所带的数据
    NSString *notMess = @"欢迎归来！\n于千万人之中，遇见你要遇见的人。\n于千万年之中，时间无涯的荒野里，\n没有早一步，也没有迟一步，\n遇上了也只能轻轻地说一句：\n“喔  原来你也在这里”\n我要你知道，\n在这个世界上总有一个人是等着你的，\n不管在什么时候，不管在什么地方，\n反正你知道，总有这么个人。\n";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"再次遇见"
                                                    message:notMess
                                                   delegate:nil
                                          cancelButtonTitle:@"喔  原来你也在这里"
                                          otherButtonTitles:nil];
    [alert show];
    
    // 更新显示的徽章个数
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    badge--;
    badge = badge >= 0 ? badge : 0;
    [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
}

// 设置本地通知
- (void)registerLocalNotification:(NSInteger)alertTime {
    //初始化一个 UILocalNotification
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    // 设置触发通知的时间
    NSDate *fireDate = [NSDate dateWithTimeIntervalSince1970:alertTime];
    notification.fireDate = fireDate;
    // 时区
    notification.timeZone = [NSTimeZone defaultTimeZone];
    // 通知重复提示的单位，可以是天、周、月
    notification.repeatInterval = kCFCalendarUnitWeek;
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
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
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

@end
