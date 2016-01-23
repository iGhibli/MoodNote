//
//  FavoriteCell.h
//  MoodNote
//
//  Created by qingyun on 16/1/22.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContentModel;
@interface FavoriteCell : UITableViewCell
@property (nonatomic, strong) ContentModel *model;

- (void)bandingFavoriteCellWithModel:(ContentModel *)model;

+ (CGFloat)favoriteCellHeightWithModel:(ContentModel *)model;

@end
