//
//  TodayCell.h
//  MoodNote
//
//  Created by 赛驰 on 16/5/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TodayModel;
@interface TodayCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *story_titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *story_authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *storyLabel;
//musicView
@property (weak, nonatomic) IBOutlet UIView *musicView;
@property (weak, nonatomic) IBOutlet UIImageView *authorHeadIcon;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;


- (void)bandingTodayCellWithTodayModel:(TodayModel *)model;

@end
