//
//  TodayModel.h
//  MoodNote
//
//  Created by 赛驰 on 16/5/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodayModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *story_title;
@property (nonatomic, strong) NSString *story;
@property (nonatomic, strong) NSString *lyric;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, strong) NSString *music_id;
@property (nonatomic, strong) NSString *charge_edt;
@property (nonatomic, strong) NSString *web_url;
@property (nonatomic, strong) NSString *user_name;
@property (nonatomic, strong) NSString *web_urlStr;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *time;

- (instancetype)initTodayModelWithDict:(NSDictionary *)dict;

@end
