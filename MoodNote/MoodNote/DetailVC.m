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

@interface DetailVC ()<DCPathButtonDelegate>
@property (nonatomic, strong) UIImageView *bg;
@property (strong, nonatomic) UIImageView *icon;
@property (strong, nonatomic) UILabel *detailLabel;

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
            
            break;
        case 1:
            
            break;
        case 2:
            
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
    DCPathButton *dcPathButton = [[DCPathButton alloc]initWithCenterImage:[UIImage imageNamed:@"chooser-button-tab"]
                                                         highlightedImage:[UIImage imageNamed:@"chooser-button-tab-highlighted"]];
    dcPathButton.delegate = self;
    
    // Configure item buttons
    DCPathItemButton *itemButton_1 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-music"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-music-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    DCPathItemButton *itemButton_2 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-place"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-place-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    DCPathItemButton *itemButton_3 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-camera"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-camera-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    DCPathItemButton *itemButton_4 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-thought"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-thought-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    // Add the item button into the center button
    //
    [dcPathButton addPathItems:@[itemButton_1,
                                 itemButton_2,
                                 itemButton_3,
                                 itemButton_4,
                                 ]];
    // Change the bloom radius, default is 105.0f
    //
    dcPathButton.bloomRadius = 150.0f;
    dcPathButton.bloomAngel = 70.0f;
    // Change the DCButton's center
    //
    dcPathButton.dcButtonCenter = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height - 25.5f);
    
    // Setting the DCButton appearance
    
    dcPathButton.allowSounds = YES;
    dcPathButton.allowCenterButtonRotation = YES;
    
    dcPathButton.bottomViewColor = [UIColor grayColor];
    
    dcPathButton.bloomDirection = kDCPathButtonBloomDirectionBottomLeft;
    dcPathButton.dcButtonCenter = CGPointMake(self.view.frame.size.width - 50, 50);
    
    [self.view addSubview:dcPathButton];
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
