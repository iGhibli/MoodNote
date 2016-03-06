//
//  FavoriteCCell.m
//  MoodNote
//
//  Created by qingyun on 16/3/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "FavoriteCCell.h"
#import "ContentModel.h"
#import "UIImageView+WebCache.h"
#import "Common.h"
#import "NSString+Size.h"
#import "DCPathButton.h"

@interface FavoriteCCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
@implementation FavoriteCCell

- (void)bandingFavoriteCCellWithModel:(ContentModel *)model {
    [self layoutCCellContentWithModel:model];
    _model = model;
    _title.text = model.title;
    //使用SDWebImage加载网络图片数据
    NSString *imageURLStr = [kImageBaseURL stringByAppendingPathComponent:model.pic_url];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:imageURLStr]];
}

- (void)layoutCCellContentWithModel:(ContentModel *)model
{
    //图片的实际尺寸
    CGFloat realW = [model.picWidth floatValue];
    CGFloat realH = [model.picHeight floatValue];
    
    //图片显示的尺寸
    CGFloat displayW = kScreenW / 2.0 - 10 - 10;
    CGFloat displayH = realH * (kScreenW / 2.0 - 10 - 10) / realW;
    
    //文字显示的尺寸
    CGSize titleSize = [model.title sizeWithFont:[UIFont systemFontOfSize:10] AndWidth:kScreenW / 2.0 - 20];
    
    //图片和文字及间隔的总尺寸
    CGFloat totalH = displayH + 10 + titleSize.height;
    
    //控件布局
    if (totalH >= kScreenH / 2.0) {
        CGFloat scale = (kScreenH / 2.0 - titleSize.height - 10 - 10 - 10) / displayH;
        CGFloat picW = displayW * scale;
        CGFloat picH = displayH * scale;
        
        self.icon.frame = CGRectMake((kScreenW / 2.0 - picW) / 2, 10, picW, picH);
        self.title.frame = CGRectMake(10, self.icon.frame.origin.y + picH + 10, titleSize.width, titleSize.height);
    }else {
        self.icon.frame = CGRectMake(10, (kScreenH / 2.0 - totalH) / 2, displayW, displayH);
        self.title.frame = CGRectMake(10, self.icon.frame.origin.y + displayH + 10, titleSize.width, titleSize.height);
    }
}



@end
