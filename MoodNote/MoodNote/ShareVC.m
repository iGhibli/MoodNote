//
//  ShareVC.m
//  MoodNote
//
//  Created by qingyun on 16/1/21.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ShareVC.h"
#import "Common.h"

@interface ShareVC ()

@end

@implementation ShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
}


- (void)setupSubViews
{
    //设置self.view
    self.view.backgroundColor = [UIColor grayColor];
//    self.view.alpha = 0.5;
    UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidden)];
    [self.view addGestureRecognizer:click];
    
    //布局ShareView & Button
    CGFloat btnW = kScreenW / 3 - 40;
    CGFloat btnH = btnW;
    CGFloat shareViewH = btnH * 2;
    //ShareView
    UIView *shareView = [[UIView alloc]init];
    shareView.frame = CGRectMake(0, kScreenH - shareViewH, kScreenW, shareViewH);
    shareView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:shareView];
    //Button
    NSArray *btnNormalImage = @[@"UMS_wechat_icon" ,@"UMS_wechat_timeline_icon" ,@"UMS_sina_icon" ,@"UMS_qq_icon" ,@"UMS_qzone_icon" ,@"UMS_cut_icon"];
    NSArray *btnHighlightedImage = @[@"UMS_wechat_off" ,@"UMS_wechat_timeline_off" ,@"UMS_sina_off" ,@"UMS_qq_off" ,@"UMS_qzone_off" ,@"UMS_cut_off"];
    CGFloat spaceX = 40;
    CGFloat spaceY = 0;
    CGFloat marginX = 20;
    CGFloat marginY = 0;
    
    for (int i = 0; i < 6; i++) {
        CGFloat btnX = i % 3 * (btnW + spaceX) + marginX;
        CGFloat btnY = i / 3 * (btnH + spaceY) + marginY;
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
        [btn setImage:[UIImage imageNamed:btnNormalImage[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:btnHighlightedImage[i]] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(shareBtnActionWithTag:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 50 + i;
        [shareView addSubview:btn];
    }
    
}

- (void)shareBtnActionWithTag:(UIButton *)sender
{
    switch (sender.tag) {
        case 50:
            [self shareAction];
            break;
        case 51:
            [self shareAction];
            break;
        case 52:
            [self shareAction];
            break;
        case 53:
            [self shareAction];
            break;
        case 54:
            [self shareAction];
            break;
        case 55:
            [self shareAction];
            break;
        
            
        default:
            break;
    }
}

- (void)shareAction
{
    NSLog(@"Share");
    //1.开启图片上下文
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, NO, 1);
    
    //2.获取当前上下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    //3.绘制
    [self.view.layer renderInContext:ctx];
    
    //4.取出图片，
    UIImage *currentImage=UIGraphicsGetImageFromCurrentImageContext();
    NSData *imageData=UIImagePNGRepresentation(currentImage);
    [imageData writeToFile:@"/Users/qingyun/Desktop/Screen.png" atomically:YES];
    
    //.关闭图形上下文
    UIGraphicsEndImageContext();

}

- (void)hidden
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
