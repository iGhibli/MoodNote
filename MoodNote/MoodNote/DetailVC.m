//
//  DetailVC.m
//  MoodNote
//
//  Created by qingyun on 16/3/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "DetailVC.h"
#import "DCPathButton.h"
#import "ContentModel.h"
#import "Common.h"
#import "UIImageView+WebCache.h"
#import "NSString+Size.h"
#import "UMSocial.h"
#import "DBEngine.h"

@interface DetailVC ()<DCPathButtonDelegate>
@property (nonatomic, strong) UIImageView *bg;
@property (strong, nonatomic) UIImageView *icon;
@property (strong, nonatomic) UILabel *detailLabel;
@property (nonatomic, strong) DCPathButton *dcPathButton;
@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutSubviews];
    [self configureDCPathButton];
}

- (void)layoutSubviews
{
    //重新布局
    [self layoutViewContent];
    self.detailLabel.text = self.model.title;
    
    //使用SDWebImage加载网络图片数据
    NSString *imageURLStr = [kImageBaseURL stringByAppendingPathComponent:self.model.pic_url];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:imageURLStr]];
}

- (void)layoutViewContent
{
    self.bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    self.bg.image = [UIImage imageNamed:@"BackGround6P"];
    [self.view addSubview:self.bg];
    self.icon = [[UIImageView alloc] init];
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.numberOfLines = 0;
    [self.view addSubview:self.icon];
    [self.view addSubview:self.detailLabel];
    //图片的实际尺寸
    CGFloat realW = [self.model.picWidth floatValue];
    CGFloat realH = [self.model.picHeight floatValue];
    
    //图片显示的尺寸
    CGFloat displayW = kScreenW - 10 - 10;
    CGFloat displayH = realH * (kScreenW - 10 - 10) / realW;
    
    //文字显示的尺寸
    CGSize titleSize = [self.model.title sizeWithFont:[UIFont systemFontOfSize:17] AndWidth:kScreenW - 20];
    
    //图片和文字及间隔的总尺寸
    CGFloat totalH = displayH + 10 + titleSize.height;
    
    //控件布局
    if (totalH >= kScreenH) {
        CGFloat scale = (kScreenH - titleSize.height - 10 - 10 - 10) / displayH;
        CGFloat picW = displayW * scale;
        CGFloat picH = displayH * scale;
        
        self.icon.frame = CGRectMake((kScreenW - picW) / 2, 10, picW, picH);
        self.detailLabel.frame = CGRectMake(10, self.icon.frame.origin.y + picH + 10, titleSize.width, titleSize.height);
    }else {
        self.icon.frame = CGRectMake(10, (kScreenH - totalH) / 2, displayW, displayH);
        self.detailLabel.frame = CGRectMake(10, self.icon.frame.origin.y + displayH + 10, titleSize.width, titleSize.height);
    }
}


#pragma mark <DCPathButtonDelegate>

- (void)pathButton:(DCPathButton *)dcPathButton clickItemButtonAtIndex:(NSUInteger)itemButtonIndex {
    switch (itemButtonIndex) {
        case 0:
            [self likeAction];
            break;
        case 1:
            [self shareAction];
            break;
        case 2:
            [self copyAction];
            break;
        case 3:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureDCPathButton
{
    self.dcPathButton = [[DCPathButton alloc]initWithCenterImage:[UIImage imageNamed:@"chooser-button-tab"]
                                                         highlightedImage:[UIImage imageNamed:@"chooser-button-tab-highlighted"]];
    self.dcPathButton.delegate = self;
    
    // Configure item buttons
    DCPathItemButton *itemButton_1 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"DC-delete"]
                                                           highlightedImage:[UIImage imageNamed:@"DC-delete-h"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    DCPathItemButton *itemButton_2 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"DC-share"]
                                                           highlightedImage:[UIImage imageNamed:@"DC-share-h"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    DCPathItemButton *itemButton_3 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"DC-save"]
                                                           highlightedImage:[UIImage imageNamed:@"DC-save-h"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    DCPathItemButton *itemButton_4 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"DC-back"]
                                                           highlightedImage:[UIImage imageNamed:@"DC-back-h"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    // Add the item button into the center button
    //
    [self.dcPathButton addPathItems:@[itemButton_1,
                                 itemButton_2,
                                 itemButton_3,
                                 itemButton_4,
                                 ]];
    // Change the bloom radius, default is 105.0f
    //
    self.dcPathButton.bloomRadius = 150.0f;
    self.dcPathButton.bloomAngel = 70.0f;
    // Change the DCButton's center
    //
    self.dcPathButton.dcButtonCenter = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height - 25.5f);
    
    // Setting the DCButton appearance
    
    self.dcPathButton.allowSounds = YES;
    self.dcPathButton.allowCenterButtonRotation = YES;
    
    self.dcPathButton.bottomViewColor = [UIColor grayColor];
    
    self.dcPathButton.bloomDirection = kDCPathButtonBloomDirectionBottomLeft;
    self.dcPathButton.dcButtonCenter = CGPointMake(self.view.frame.size.width - 50, 50);
    
    [self.view addSubview:self.dcPathButton];
}

#pragma mark - ButtonAction
- (void)copyAction {
    //获取剪切板
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    //将内容赋值给剪切板
    pasteBoard.string = self.model.title;
#pragma mark - 截屏
    self.dcPathButton.hidden = YES;
    CGSize imageSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    //1.开启图片上下文
    UIGraphicsBeginImageContextWithOptions(imageSize, YES, 0.0);
    //2.获取当前上下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    //3.绘制
    [self.view.layer renderInContext:ctx];
    //4.取出图片，
    UIImage *currentImage=UIGraphicsGetImageFromCurrentImageContext();
    NSData *imageData=UIImagePNGRepresentation(currentImage);
    //.关闭图形上下文
    UIGraphicsEndImageContext();
    self.dcPathButton.hidden = NO;
#pragma mark - 将图片保存到相册
    UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:imageData], self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *message;
    if (!error) {
        message = @"已复制美图美句到本地";
        
    }else
    {
        message = @"保存到本地失败";
    }
    UILabel *popLabel = [[UILabel alloc]init];
    popLabel.textAlignment = NSTextAlignmentCenter;
    popLabel.font = [UIFont systemFontOfSize:12];
    popLabel.text = message;
    popLabel.layer.cornerRadius = 10;
    popLabel.clipsToBounds = YES;
    popLabel.backgroundColor = [UIColor orangeColor];
    popLabel.frame = CGRectMake(75, kScreenH * 5 / 6 - 40, kScreenW - 150, 20);
    [self.view addSubview:popLabel];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:popLabel selector:@selector(removeFromSuperview) userInfo:nil repeats:NO];
}

- (void)shareAction {
#pragma mark - 截屏
    self.dcPathButton.hidden = YES;
    CGSize imageSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    //1.开启图片上下文
    UIGraphicsBeginImageContextWithOptions(imageSize, YES, 0.0);
    //2.获取当前上下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    //3.绘制
    [self.view.layer renderInContext:ctx];
    //4.取出图片，
    UIImage *currentImage=UIGraphicsGetImageFromCurrentImageContext();
    NSData *imageData=UIImagePNGRepresentation(currentImage);
    //.关闭图形上下文
    UIGraphicsEndImageContext();
    self.dcPathButton.hidden = NO;
#pragma mark - UM分享
    UIImage *shareImage = [UIImage imageWithData:imageData];
    NSString *shareText = self.model.title;
    NSInteger length = [shareText length];
    if (length > 120) {
        shareText = [shareText substringToIndex:120];
        shareText = [shareText stringByAppendingString:@"……"];
    }
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"56a3781a67e58e9bf7002cac"
                                      shareText:[shareText stringByAppendingString:@"      --来自遇见，心中的小美好。"]
                                     shareImage:shareImage
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,
                                                 UMShareToWechatFavorite,UMShareToSina, UMShareToTencent,UMShareToRenren, UMShareToEmail,    UMShareToSms,nil]
                                       delegate:nil];
}

- (void)likeAction {
    //删除数据库内容
    [DBEngine deleteDataWithID:self.model.ID];
    
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
    [self dismissViewControllerAnimated:YES completion:nil];
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
