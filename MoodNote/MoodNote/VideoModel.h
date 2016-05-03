//
//  VideoModel.h
//  MoodNote
//
//  Created by 赛驰 on 16/5/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *playUrl;
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, strong) NSString *rawWebUrl;
@property (nonatomic, strong) NSString *coverForFeed;
@property (nonatomic, strong) NSString *coverBlurred;

- (instancetype)initVideoModelWithDictionary:(NSDictionary *)dict;

@end
