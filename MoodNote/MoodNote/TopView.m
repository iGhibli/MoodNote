//
//  TopView.m
//  MoodNote
//
//  Created by qingyun on 16/1/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "TopView.h"
#import "SettingVC.h"

@implementation TopView

+ (instancetype)topView {
    NSArray *views = [[NSBundle mainBundle]loadNibNamed:@"TopView" owner:nil options:nil];
    return views[0];
}
- (IBAction)mainAction:(UIButton *)sender {
}
- (IBAction)likeAction:(UIButton *)sender {
}
- (IBAction)setAction:(UIButton *)sender {
    SettingVC *VC = [[SettingVC alloc]init];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
