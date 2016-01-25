//
//  SettingVC.m
//  MoodNote
//
//  Created by qingyun on 16/1/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "SettingVC.h"
#import "Common.h"
#import "SDImageCache.h"
#import "SettingButton.h"
#import "AppDelegate.h"

@interface SettingVC ()
@property (nonatomic, strong) UIView *aboutView;
@property (nonatomic, strong) UIView *clearView;
@property (nonatomic, strong) UILabel *memoryLabel;
@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSwipeGesture];
    [self setupSubviews];
}

- (void)addSwipeGesture
{
    //添加下滑手势
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:[UIApplication sharedApplication].delegate action:@selector(swipeDownAction)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDown];
}

- (void)setupSubviews
{
    SettingButton *clearBtn = [[SettingButton alloc]init];
    clearBtn.center = CGPointMake(kScreenW / 4, kScreenH / 4);
    clearBtn.bounds = CGRectMake(0, 0, 100, 100);
    [clearBtn setImage:[UIImage imageNamed:@"set-clear"] forState:UIControlStateNormal];
    clearBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [clearBtn setTitle:@"清理缓存" forState:UIControlStateNormal];
    [clearBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [clearBtn addTarget:self action:@selector(clearAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearBtn];
    
    SettingButton *guideBtn = [[SettingButton alloc]init];
    guideBtn.center = CGPointMake(kScreenW * 3 / 4, kScreenH / 4);
    guideBtn.bounds = CGRectMake(0, 0, 100, 100);
    [guideBtn setImage:[UIImage imageNamed:@"set-guide"] forState:UIControlStateNormal];
    guideBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [guideBtn setTitle:@"使用引导" forState:UIControlStateNormal];
    [guideBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [guideBtn addTarget:self action:@selector(guideAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:guideBtn];
    
    SettingButton *goodBtn = [[SettingButton alloc]init];
    goodBtn.center = CGPointMake(kScreenW / 4, kScreenH * 3 / 4);
    goodBtn.bounds = CGRectMake(0, 0, 100, 100);
    [goodBtn setImage:[UIImage imageNamed:@"set-good"] forState:UIControlStateNormal];
    goodBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [goodBtn setTitle:@"鼓励支持" forState:UIControlStateNormal];
    [goodBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [goodBtn addTarget:self action:@selector(goodAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goodBtn];
    
    SettingButton *aboutBtn = [[SettingButton alloc]init];
    aboutBtn.center = CGPointMake(kScreenW * 3 / 4, kScreenH * 3 / 4);
    aboutBtn.bounds = CGRectMake(0, 0, 100, 100);
    [aboutBtn setImage:[UIImage imageNamed:@"set-about"] forState:UIControlStateNormal];
    aboutBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [aboutBtn setTitle:@"关于应用" forState:UIControlStateNormal];
    [aboutBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [aboutBtn addTarget:self action:@selector(aboutAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aboutBtn];
}

#pragma mark - Getter & Setter
- (UIView *)aboutView {
    if (_aboutView == nil) {
        _aboutView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _aboutView.backgroundColor = [UIColor grayColor];
        _aboutView.alpha = 0.98;
//        [self.view addSubview:_aboutView];
        
        UILabel *author = [[UILabel alloc]initWithFrame:CGRectMake(10, kScreenH / 2 - 35, kScreenW - 20, 30)];
        author.text = @"Author: ZhouShuaijie";
        author.font = [UIFont systemFontOfSize:22];
        author.textAlignment = NSTextAlignmentCenter;
        [_aboutView addSubview:author];
        
#if 1
        UIButton *emailBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, kScreenH / 2, kScreenW - 20, 30)];
        [emailBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [emailBtn setTitle:@"Email: iGhibli@163.com" forState:UIControlStateNormal];
        [emailBtn addTarget:self action:@selector(sendEmailToMe) forControlEvents:UIControlEventTouchUpInside];
        [_aboutView addSubview:emailBtn];
#else
        UILabel *email = [[UILabel alloc]initWithFrame:CGRectMake(10, kScreenH / 2, kScreenW - 20, 30)];
        email.text = @"Email: iGhibli@163.com";
        email.textAlignment = NSTextAlignmentCenter;
        [_aboutView addSubview:email];
#endif
        
        UILabel *version = [[UILabel alloc]initWithFrame:CGRectMake(10, kScreenH / 2 + 35, kScreenW - 20, 30)];
        version.text = @"Version: 1.0";
        version.font = [UIFont systemFontOfSize:16];
        version.textAlignment = NSTextAlignmentCenter;
        [_aboutView addSubview:version];
        UILabel *thanks = [[UILabel alloc]initWithFrame:CGRectMake(10, kScreenH / 2 + 70, kScreenW - 20, 30)];
        thanks.text = @"^_^ 谢谢使用 ^_^";
        
        thanks.textAlignment = NSTextAlignmentCenter;
        [_aboutView addSubview:thanks];
        
        UIButton *cancel = [[UIButton alloc]init];
        cancel.center = CGPointMake(kScreenW / 2, kScreenH - 30);
        cancel.bounds = CGRectMake(0, 0, 40, 40);
        [cancel setImage:[UIImage imageNamed:@"btn-cancel-1"] forState:UIControlStateNormal];
        [cancel setImage:[UIImage imageNamed:@"btn-cancel-2"] forState:UIControlStateHighlighted];
        [cancel addTarget:self action:@selector(hiddenView) forControlEvents:UIControlEventTouchUpInside];
        [_aboutView addSubview:cancel];
    }
    return _aboutView;
}

- (UIView *)clearView {
    if (_clearView == nil) {
        _clearView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _clearView.backgroundColor = [UIColor grayColor];
        _clearView.alpha = 0.98;
        
        _memoryLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, kScreenH / 2 - 35, kScreenW - 20, 30)];
        NSString *memoryString = [NSString stringWithFormat:@"当前缓存:  %.2f Mb",[[SDImageCache sharedImageCache] getSize] / 1024.f / 1024.f];
        _memoryLabel.text = memoryString;
        _memoryLabel.font = [UIFont systemFontOfSize:22];
        _memoryLabel.textAlignment = NSTextAlignmentCenter;
        [_clearView addSubview:_memoryLabel];
        
        UIButton *cancel = [[UIButton alloc]init];
        cancel.center = CGPointMake(kScreenW / 2 - 30, kScreenH - 30);
        cancel.bounds = CGRectMake(0, 0, 40, 40);
        [cancel setImage:[UIImage imageNamed:@"btn-cancel-1"] forState:UIControlStateNormal];
        [cancel setImage:[UIImage imageNamed:@"btn-cancel-2"] forState:UIControlStateHighlighted];
        [cancel addTarget:self action:@selector(hiddenView) forControlEvents:UIControlEventTouchUpInside];
        [_clearView addSubview:cancel];
        UIButton *clearBtn = [[UIButton alloc]init];
        clearBtn.center = CGPointMake(kScreenW / 2 + 30, kScreenH - 30);
        clearBtn.bounds = CGRectMake(0, 0, 50, 50);
        [clearBtn setImage:[UIImage imageNamed:@"btn-huancun-1"] forState:UIControlStateNormal];
        [clearBtn setImage:[UIImage imageNamed:@"btn-huancun-2"] forState:UIControlStateHighlighted];
        [clearBtn addTarget:self action:@selector(clearMemoryAddHiddenView) forControlEvents:UIControlEventTouchUpInside];
        [_clearView addSubview:clearBtn];
        
    }
    return _clearView;
}

#pragma mark - ButtonAction
- (void)clearAction {
    NSString *memoryString = [NSString stringWithFormat:@"当前缓存:  %.2f Mb",[[SDImageCache sharedImageCache] getSize] / 1024.f / 1024.f];
    _memoryLabel.text = memoryString;
    [self.view addSubview:self.clearView];
}
- (void)guideAction {
    AppDelegate * app = [UIApplication sharedApplication].delegate;
    [app setRootVC];
}

- (void)goodAction {
    //跳转到AppStore当前应用界面
    //当前应用的AppID
    int myAPPID = 1077987843;
    NSString *str = [NSString stringWithFormat:
                     @"itms-apps://itunes.apple.com/cn/app/encounter/id%d?mt=8",
                     myAPPID ];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (void)aboutAction {
    [self.view addSubview:self.aboutView];
}

- (void)hiddenView
{
    [self.aboutView removeFromSuperview];
    [self.clearView removeFromSuperview];
}

- (void)clearMemoryAddHiddenView
{
    //清除缓存
    [[SDImageCache sharedImageCache] clearDisk];
    [self hiddenView];
}

- (void)sendEmailToMe
{
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

@end
