//
//  FavoriteCell.m
//  MoodNote
//
//  Created by qingyun on 16/1/22.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "FavoriteCell.h"
#import "ContentModel.h"
#import "UIImageView+WebCache.h"
#import "Common.h"
#import "NSString+Size.h"

@interface FavoriteCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIView *btnView;

@end

@implementation FavoriteCell

- (void)bandingFavoriteCellWithModel:(ContentModel *)model {

    _model = model;
    _title.text = model.title;
    //使用SDWebImage加载网络图片数据
    NSString *imageURLStr = [kImageBaseURL stringByAppendingPathComponent:model.pic_url];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:imageURLStr]];
}

+ (CGFloat)favoriteCellHeightWithModel:(ContentModel *)model {
    
    //图片的实际尺寸
    CGFloat realW = [model.picWidth floatValue];
    CGFloat realH = [model.picHeight floatValue];
    
    //图片显示的尺寸
    CGFloat displayH = realH * (kScreenW - 10 - 10) / realW;
    
    //文字显示的尺寸
    CGSize titleSize = [model.title sizeWithFont:[UIFont systemFontOfSize:17] AndWidth:kScreenW - 20];
    
    //btnView的尺寸
    CGFloat btnViewH = 40;
    
    //总尺寸
    CGFloat totalH = 10 + displayH + 20 + titleSize.height + 30 + btnViewH;

    return totalH;
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end