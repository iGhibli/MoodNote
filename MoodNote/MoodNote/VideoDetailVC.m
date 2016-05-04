//
//  VideoDetailVC.m
//  MoodNote
//
//  Created by 赛驰 on 16/5/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "VideoDetailVC.h"
#import "ZFPlayer.h"
#import "UIImageView+WebCache.h"
#import "UIImage+CompressForSize.h"
#import "Common.h"

@interface VideoDetailVC ()
@property (weak, nonatomic) IBOutlet ZFPlayerView *videoView;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *tilteLabel;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *sortLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bottomIcon;

@end

@implementation VideoDetailVC

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        self.view.backgroundColor = [UIColor whiteColor];
    }else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight || toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        self.view.backgroundColor = [UIColor blackColor];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupVideoView];
    [self setupSubViews];
}

- (void)setupSubViews
{
    [self.icon sd_setImageWithURL:[NSURL URLWithString:self.coverBlurred] placeholderImage:nil options:SDWebImageAvoidAutoSetImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.icon.image = [UIImage imageCompressForSize:image targetSize:CGSizeMake(kScreenW, CGRectGetHeight(self.icon.bounds))];
    }];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:self.coverBlurred] placeholderImage:nil];
    [self.bottomIcon sd_setImageWithURL:[NSURL URLWithString:self.coverForDetail] placeholderImage:nil];
    self.tilteLabel.text = self.titleText;
    self.desc.text = self.descText;
    self.sortLabel.text = self.sortText;
    self.timeLabel.text = self.timeText;
}

- (void)setupVideoView
{
    if (self.videoUrlStr != nil) {
        self.videoView.videoURL = [NSURL URLWithString:self.videoUrlStr];
    }
    __weak typeof(self) weakSelf = self;
    self.videoView.goBackBlock  = ^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
}

#pragma mark - ButtonAction
- (IBAction)backAction:(UIButton *)sender {
    [self.videoView resetPlayer];
    [self.videoView cancelAutoFadeOutControlBar];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 控制屏幕旋转
- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}


@end
