//
//  TodayModel.m
//  MoodNote
//
//  Created by 赛驰 on 16/5/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "TodayModel.h"

@implementation TodayModel

- (instancetype)initTodayModelWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.title = dict[@"title"];
        self.cover = dict[@"cover"];
        self.story_title = dict[@"story_title"];
        self.story = dict[@"story"];
        self.lyric = dict[@"lyric"];
        self.info = dict[@"info"];
        self.music_id = dict[@"music_id"];
        self.charge_edt = dict[@"charge_edt"];
        self.web_url = dict[@"web_url"];
        NSDictionary *authorDict = dict[@"author"];
        self.user_name = authorDict[@"user_name"];
        self.web_urlStr = authorDict[@"web_url"];
        self.desc = authorDict[@"desc"];
    }
    return self;
}

@end
