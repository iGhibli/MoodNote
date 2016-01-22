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
    UIImageView *shareImage = [[UIImageView alloc]init];
    shareImage.bounds = CGRectMake(0, 0, kScreenW / 2, kScreenH / 2);
    shareImage.center = CGPointMake(kScreenW / 2, (kScreenH - (kScreenW / 3 - 40) * 2) / 2);
    //获取Tempora目录下存储的截屏文件路径
    NSString *tempPath = NSTemporaryDirectory();
    NSString *imageDataPath = [tempPath stringByAppendingPathComponent:@"CurrentScreenData"];
    shareImage.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:imageDataPath]];
    [self.view addSubview:shareImage];
    
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
            [self CutShareAction];
            break;
        
            
        default:
            break;
    }
}

- (void)shareAction
{


}

- (void)CutShareAction
{
    //获取Tempora目录下存储的截屏文件路径
    NSString *tempPath = NSTemporaryDirectory();
    NSString *imageDataPath = [tempPath stringByAppendingPathComponent:@"CurrentScreenData"];
    //将截屏文件保存到本地相册，完成后执行是否保存成功判断方法
    UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:[NSData dataWithContentsOfFile:imageDataPath]], self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}

//    实现imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:方法
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (!error) {
        //保存到相册成功
        UILabel *popLabel = [[UILabel alloc]init];
        popLabel.textAlignment = NSTextAlignmentCenter;
        popLabel.font = [UIFont systemFontOfSize:12];
        popLabel.text = @"保存到相册成功";
        popLabel.layer.cornerRadius = 10;
        popLabel.clipsToBounds = YES;
        popLabel.backgroundColor = [UIColor orangeColor];
        popLabel.frame = CGRectMake(75, kScreenH - ((kScreenW / 3 - 40) * 2 + 40), kScreenW - 150, 20);
        [self.view addSubview:popLabel];
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:popLabel selector:@selector(removeFromSuperview) userInfo:nil repeats:NO];
    }else {
        //保存到相册失败
        UILabel *popLabel = [[UILabel alloc]init];
        popLabel.textAlignment = NSTextAlignmentCenter;
        popLabel.font = [UIFont systemFontOfSize:12];
        popLabel.text = @"保存到相册失败";
        popLabel.layer.cornerRadius = 10;
        popLabel.clipsToBounds = YES;
        popLabel.backgroundColor = [UIColor orangeColor];
        popLabel.frame = CGRectMake(75, kScreenH - ((kScreenW / 3 - 40) * 2 + 40), kScreenW - 150, 20);
        [self.view addSubview:popLabel];
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:popLabel selector:@selector(removeFromSuperview) userInfo:nil repeats:NO];
        //输出失败Error信息
        NSLog(@"message is %@",[error description]);
    }
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
