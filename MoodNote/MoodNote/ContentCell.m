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
#import "Common.h"

@interface ContentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *pic;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
@implementation ContentCell

- (void)bandingContentCellWithModel:(ContentModel *)model
{
    _model = model;
    _title.text = model.title;
    //使用SDWebImage加载网络图片数据
    NSString *imageURLStr = [ImageBaseURL stringByAppendingPathComponent:model.pic_url];
    [self.pic sd_setImageWithURL:[NSURL URLWithString:imageURLStr]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
