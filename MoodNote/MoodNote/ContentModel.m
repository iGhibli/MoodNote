//
//  ContentModel.m
//  MoodNote
//
//  Created by qingyun on 16/1/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ContentModel.h"

@implementation ContentModel

- (instancetype)initContentModelWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        self.title = dict[@"title"];
        self.pic_url = dict[@"pic"];
    }
    return self;
}


@end
