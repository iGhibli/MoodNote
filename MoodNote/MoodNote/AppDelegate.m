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

@interface AppDelegate ()
@property (nonatomic, strong) FXBlurView *blurView;
@end

@implementation AppDelegate

- (FXBlurView *)blurView {
    if (_blurView == nil) {
        
        _blurView = [[FXBlurView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [self.window addSubview:_blurView];
//        TopView *tView = [TopView topView];
        
        UIView *topView = [[UIView alloc]init];
        topView.frame = CGRectMake(0, 0, kScreenW, kScreenH / 6);
        topView.backgroundColor = [UIColor grayColor];
        topView.alpha = 0.5;
        [_blurView addSubview:topView];
        
        //创建HomeButton
        UIButton *homeBtn = [[UIButton alloc]init];
        homeBtn.center = CGPointMake(kScreenW / 4, kScreenH / 6 / 2);
        homeBtn.bounds = CGRectMake(0, 0, kScreenH / 6, kScreenH / 6);
        [homeBtn setImage:[UIImage imageNamed:@"btn_main_normal"] forState:UIControlStateNormal];
        [homeBtn setImage:[UIImage imageNamed:@"btn_main_highlight"] forState:UIControlStateHighlighted];
        [homeBtn addTarget:self action:@selector(switchoverVCWithButton:) forControlEvents:UIControlEventTouchUpInside];
        homeBtn.tag = 10;
        [topView addSubview:homeBtn];
        
        //创建HomeButton
        UIButton *settingBtn = [[UIButton alloc]init];
        settingBtn.center = CGPointMake(kScreenW * 3 / 4, kScreenH / 6 / 2);
        settingBtn.bounds = CGRectMake(0, 0, kScreenH / 6, kScreenH / 6);
        [settingBtn setImage:[UIImage imageNamed:@"btn_setting_normal"] forState:UIControlStateNormal];
        [settingBtn setImage:[UIImage imageNamed:@"btn_setting_highlight"] forState:UIControlStateHighlighted];
        [settingBtn addTarget:self action:@selector(switchoverVCWithButton:) forControlEvents:UIControlEventTouchUpInside];
        settingBtn.tag = 12;
        [topView addSubview:settingBtn];
        
        //创建FavoriteButton
        UIButton *favoriteBtn = [[UIButton alloc]init];
        favoriteBtn.center = CGPointMake(kScreenW / 2, kScreenH / 6 / 2);
        favoriteBtn.bounds = CGRectMake(0, 0, kScreenH / 6, kScreenH / 6);
        [favoriteBtn setImage:[UIImage imageNamed:@"btn_fav_normal"] forState:UIControlStateNormal];
        [favoriteBtn setImage:[UIImage imageNamed:@"btn_fav_highlight"] forState:UIControlStateHighlighted];
        [favoriteBtn addTarget:self action:@selector(switchoverVCWithButton:) forControlEvents:UIControlEventTouchUpInside];
        favoriteBtn.tag = 11;
        [topView addSubview:favoriteBtn];
        
    }
    return _blurView;
}

- (void)swipeDownAction
{
//    NSLog(@"APP");
    
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
            [self switchoverVCWithIdentifier:@"FavoriteVCID"];
            break;
        case 12:
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
    
    [UMSocialData setAppKey:@"56a3781a67e58e9bf7002cac"];
    
    // Override point for customization after application launch.
    return YES;
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
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
