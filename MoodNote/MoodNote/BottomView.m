//
//  BottomView.m
//  MoodNote
//
//  Created by qingyun on 16/1/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "BottomView.h"

@interface BottomView  ()
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;

@end
@implementation BottomView

+ (instancetype)bottomView {
    NSArray *views = [[NSBundle mainBundle]loadNibNamed:@"BottomView" owner:nil options:nil];
    return views[0];
}

- (IBAction)copyAction:(UIButton *)sender {
}
- (IBAction)shareAction:(UIButton *)sender {
}
- (IBAction)likeAction:(UIButton *)sender {
    _likeBtn.selected = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
