//
//  VideoCell.m
//  MoodNote
//
//  Created by 赛驰 on 16/5/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "VideoCell.h"
#import "VideoModel.h"
#import "UIImageView+WebCache.h"
#import "UIImage+CompressForSize.h"
#import "Common.h"

@implementation VideoCell

- (void)bandingVideoCellWithModel:(VideoModel *)model {
    UIView *coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH/3)];
    coverView.backgroundColor = [UIColor blackColor];
    coverView.alpha = 5.f/100.f;
    [self.coverIcon addSubview:coverView];
    [self.coverIcon sd_setImageWithURL:[NSURL URLWithString:model.coverForFeed] placeholderImage:nil options:SDWebImageAvoidAutoSetImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.coverIcon.image = [UIImage imageCompressForSize:image targetSize:CGSizeMake(kScreenW, kScreenH/3)];
    }];
    self.titleText.text = model.title;
    NSString *detailStr = [NSString stringWithFormat:@"%@ / %@",model.category ,model.duration];
    self.timeText.text = detailStr;
}

@end
