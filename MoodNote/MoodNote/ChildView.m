//
//  ContentView.m
//  MoodNote
//
//  Created by qingyun on 16/1/26.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ChildView.h"
#import "Common.h"
#import "ContentModel.h"
#import "NSString+Size.h"
#import "UIImageView+WebCache.h"

@implementation ChildView

- (void)bandingChildViewWithModel:(ContentModel *)model
{
    //重新布局
    
    //图片的实际尺寸
    CGFloat realW = [model.picWidth floatValue];
    CGFloat realH = [model.picHeight floatValue];
    
    //图片显示的尺寸
    CGFloat displayW = kScreenW - 10 - 10;
    CGFloat displayH = realH * (kScreenW - 10 - 10) / realW;
    
    //文字显示的尺寸
    CGSize titleSize = [model.title sizeWithFont:[UIFont systemFontOfSize:17] AndWidth:kScreenW - 20];
    
    //图片和文字及间隔的总尺寸
    CGFloat totalH = displayH + 10 + titleSize.height;
    
    //控件布局
    CGRect picFrame;
    CGRect titleFrame;
    if (totalH >= kScreenH) {
        CGFloat scale = (kScreenH - titleSize.height - 10 - 10 - 10) / displayH;
        CGFloat picW = displayW * scale;
        CGFloat picH = displayH * scale;
        
        picFrame = CGRectMake((kScreenW - picW) / 2, 10, picW, picH);
        titleFrame = CGRectMake(10, picFrame.origin.y + picH + 10, titleSize.width, titleSize.height);
    }else {
        picFrame = CGRectMake(10, (kScreenH - totalH) / 2, displayW, displayH);
        titleFrame = CGRectMake(10, picFrame.origin.y + displayH + 10, titleSize.width, titleSize.height);
    }
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:titleFrame];
    titleLabel.numberOfLines = 0;
    UIImageView *picView = [[UIImageView alloc]initWithFrame:picFrame];
    
    //使用SDWebImage加载网络图片数据
    NSString *imageURLStr = [kImageBaseURL stringByAppendingPathComponent:model.pic_url];
    [picView sd_setImageWithURL:[NSURL URLWithString:imageURLStr] placeholderImage:[UIImage imageNamed:@"set-about"]];
    titleLabel.text = model.title;
    [self addSubview:picView];
    [self addSubview:titleLabel];
    
}

@end
