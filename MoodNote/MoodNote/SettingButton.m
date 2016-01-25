//
//  SettingButton.m
//  MoodNote
//
//  Created by qingyun on 16/1/25.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "SettingButton.h"

@implementation SettingButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//布局子视图
-(void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(15, 0, 70, 70);
    self.titleLabel.frame = CGRectMake(0, 70, 100, 30);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}


@end
