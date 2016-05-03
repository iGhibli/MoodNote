//
//  VideoCell.h
//  MoodNote
//
//  Created by 赛驰 on 16/5/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VideoModel;
@interface VideoCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *coverIcon;
@property (weak, nonatomic) IBOutlet UILabel *titleText;
@property (weak, nonatomic) IBOutlet UILabel *timeText;

- (void)bandingVideoCellWithModel:(VideoModel *)model;

@end
