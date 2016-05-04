//
//  VideoModel.m
//  MoodNote
//
//  Created by 赛驰 on 16/5/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "VideoModel.h"
#import "NSString+DateFormater.h"

@implementation VideoModel

- (instancetype)initVideoModelWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        self.title = dict[@"title"];
        self.desc = dict[@"description"];
        NSString *durationStr = dict[@"duration"];
        self.duration = [NSString getFormateDateWithSecond:durationStr];
        self.playUrl = dict[@"playUrl"];
        self.rawWebUrl = dict[@"rawWebUrl"];
        self.coverForFeed = dict[@"coverForFeed"];
        self.coverBlurred = dict[@"coverBlurred"];
        self.coverForDetail = dict[@"coverForDetail"];
        NSString *categoryStr = dict[@"category"];
        self.category = [NSString stringWithFormat:@"#%@",categoryStr];
    }
    return self;
}

@end
