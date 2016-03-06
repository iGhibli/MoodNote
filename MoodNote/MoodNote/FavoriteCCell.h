//
//  FavoriteCCell.h
//  MoodNote
//
//  Created by qingyun on 16/3/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContentModel;
@interface FavoriteCCell : UICollectionViewCell
@property (nonatomic, strong) ContentModel *model;

- (void)bandingFavoriteCCellWithModel:(ContentModel *)model;

@end
