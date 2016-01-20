//
//  ContentModel.m
//  MoodNote
//
//  Created by qingyun on 16/1/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ContentModel.h"

@implementation ContentModel

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)ContentModelWithDictionary:(NSDictionary *)dict {
    return [[self alloc]initWithDictionary:dict];
}

@end
