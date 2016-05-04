//
//  TodayView.h
//  MoodNote
//
//  Created by 赛驰 on 16/5/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TodayModel;
@interface TodayView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *story_titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *story_authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *storyLabel;

- (void)bandingTodayViewWithTodayModel:(TodayModel *)model;

@end
