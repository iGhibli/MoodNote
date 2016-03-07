//
//  FavoriteCCell.m
//  MoodNote
//
//  Created by qingyun on 16/3/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "FavoriteCCell.h"

@interface FavoriteCCell ()
@end
@implementation FavoriteCCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *bg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"BackGround6P"]];
        bg.frame = frame;
        self.backgroundView = bg;
        self.icon = [[UIImageView alloc]init];
        [self addSubview:self.icon];
        self.title = [[UILabel alloc]init];
        [self addSubview:self.title];
    }
    return self;
}

@end
