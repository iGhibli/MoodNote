//
//  ContentCell.m
//  MoodNote
//
//  Created by qingyun on 16/1/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ContentCell.h"
#import "ContentModel.h"
#import "UIImageView+WebCache.h"
#import "NSString+Size.h"
#import "Common.h"

@interface ContentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *pic;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
@implementation ContentCell

- (void)bandingContentCellWithModel:(ContentModel *)model
{
    //重新布局
    [self layoutCellContentWithModel:model];
    _model = model;
    _title.text = model.title;

    //使用SDWebImage加载网络图片数据
    NSString *imageURLStr = [kImageBaseURL stringByAppendingPathComponent:model.pic_url];
    [self.pic sd_setImageWithURL:[NSURL URLWithString:imageURLStr]];
    
    
}

- (void)layoutCellContentWithModel:(ContentModel *)model
{
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
    if (totalH >= kScreenH) {
        CGFloat scale = (kScreenH - titleSize.height - 10 - 10 - 10) / displayH;
        CGFloat picW = displayW * scale;
        CGFloat picH = displayH * scale;

        self.pic.frame = CGRectMake((kScreenW - picW) / 2, 10, picW, picH);
        self.title.frame = CGRectMake(10, self.pic.frame.origin.y + picH + 10, titleSize.width, titleSize.height);
    }else {
        self.pic.frame = CGRectMake(10, (kScreenH - totalH) / 2, displayW, displayH);
        self.title.frame = CGRectMake(10, self.pic.frame.origin.y + displayH + 10, titleSize.width, titleSize.height);
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
