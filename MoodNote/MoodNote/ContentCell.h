//
//  ContentCell.h
//  MoodNote
//
//  Created by qingyun on 16/1/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContentModel;
@interface ContentCell : UITableViewCell

@property(nonatomic, strong)ContentModel *model;

- (void)bandingContentCellWithModel:(ContentModel *)model;

@end
