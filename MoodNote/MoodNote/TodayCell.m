//
//  TodayCell.m
//  MoodNote
//
//  Created by 赛驰 on 16/5/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "TodayCell.h"
#import "TodayModel.h"
#import "UIImageView+WebCache.h"
#import "UIImage+CompressForSize.h"
#import "Common.h"

@implementation TodayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)bandingTodayCellWithTodayModel:(TodayModel *)model {
    self.musicView.layer.cornerRadius = 5.f;
    self.musicView.clipsToBounds = YES;
    
    [self setupShaowStyleTwoWith:self.musicView];
    
    [self.headIcon sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:nil options:SDWebImageAvoidAutoSetImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.headIcon.image = [UIImage imageCompressForSize:image targetSize:CGSizeMake(kScreenW, kScreenW * 3 / 10)];
    }];
    self.story_titleLabel.text = model.story_title;
    self.story_authorLabel.text = model.user_name;
    self.storyLabel.text = model.story;
    
    //musicView
    CGFloat authorHeadIconW = (kScreenW * 3.f / 10.f) * 0.4f;
    self.authorHeadIcon.layer.cornerRadius = authorHeadIconW / 2;
    self.authorHeadIcon.clipsToBounds = YES;
    [self.authorHeadIcon sd_setImageWithURL:[NSURL URLWithString:model.web_urlStr] placeholderImage:nil];
    self.titleLabel.text = model.title;
    self.timeLabel.text = model.time;
    self.nameLabel.text = model.user_name;
    self.typeLabel.text = model.desc;
}


- (void)setupShaowStyleTwoWith:(UIView *)view
{
    view.layer.masksToBounds = NO;
    //shadowColor阴影颜色
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    //shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    view.layer.shadowOffset = CGSizeMake(0,0);
    //阴影透明度，默认0
    view.layer.shadowOpacity = 0.8;
    //阴影半径，默认3
    view.layer.shadowRadius = 5;
}

- (void)setupShaowStyleOneWith:(UIView *)view
{
    view.layer.masksToBounds = NO;
    view.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    view.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    view.layer.shadowOpacity = 0.7;//阴影透明度，默认0
    view.layer.shadowRadius = 3;//阴影半径，默认3
    
    //路径阴影
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float width = view.bounds.size.width;
    float height = view.bounds.size.height;
    float x = view.bounds.origin.x;
    float y = view.bounds.origin.y;
    float addWH = 1;
    
    CGPoint topLeft      = view.bounds.origin;
    CGPoint topMiddle = CGPointMake(x+(width/2),y-addWH);
    CGPoint topRight     = CGPointMake(x+width,y);
    
    CGPoint rightMiddle = CGPointMake(x+width+addWH,y+(height/2));
    
    CGPoint bottomRight  = CGPointMake(x+width,y+height);
    CGPoint bottomMiddle = CGPointMake(x+(width/2),y+height+addWH);
    CGPoint bottomLeft   = CGPointMake(x,y+height);
    
    
    CGPoint leftMiddle = CGPointMake(x-addWH,y+(height/2));
    
    [path moveToPoint:topLeft];
    //添加四个二元曲线
    [path addQuadCurveToPoint:topRight
                 controlPoint:topMiddle];
    [path addQuadCurveToPoint:bottomRight
                 controlPoint:rightMiddle];
    [path addQuadCurveToPoint:bottomLeft
                 controlPoint:bottomMiddle];
    [path addQuadCurveToPoint:topLeft
                 controlPoint:leftMiddle];  
    //设置阴影路径  
    view.layer.shadowPath = path.CGPath;
}


@end
