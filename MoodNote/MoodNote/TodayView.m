//
//  TodayView.m
//  MoodNote
//
//  Created by 赛驰 on 16/5/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "TodayView.h"
#import "TodayModel.h"
#import "UIImageView+WebCache.h"
#import "UIImage+CompressForSize.h"
#import "Common.h"

@implementation TodayView

- (void)bandingTodayViewWithTodayModel:(TodayModel *)model {
    [self.headIcon sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:nil options:SDWebImageAvoidAutoSetImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.headIcon.image = [UIImage imageCompressForSize:image targetSize:CGSizeMake(kScreenW, kScreenW * 4 / 10)];
    }];
    self.story_titleLabel.text = model.story_title;
    self.story_authorLabel.text = model.user_name;
    self.storyLabel.text = model.story;
}

@end
