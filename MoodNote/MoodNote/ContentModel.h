//
//  ContentModel.h
//  MoodNote
//
//  Created by qingyun on 16/1/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContentModel : NSObject

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *pic_url;

- (instancetype)initContentModelWithDictionary:(NSDictionary *)dict;

@end
