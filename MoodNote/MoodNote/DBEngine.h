//
//  FavoriteEngine.h
//  MoodNote
//
//  Created by qingyun on 16/1/22.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ContentModel;
@interface DBEngine : NSObject

+ (void)saveToLocalWithModel:(ContentModel *)model;

+ (NSArray *)getFavoritesFromLocal;

+ (void)deleteDataWithID:(NSString *)ID;

@end
