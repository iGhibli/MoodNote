//
//  SJPlayer.m
//  MoodNote
//
//  Created by 赛驰 on 16/5/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "SJPlayerManager.h"

@interface SJPlayerManager ()
@property (nonatomic, strong) NSMutableDictionary *SJPlayers;
@end

static SJPlayerManager *_instance = nil;

@implementation SJPlayerManager

+ (instancetype)defaultManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (instancetype)init
{
    __block SJPlayerManager *temp = self;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ((temp = [super init]) != nil) {
            _SJPlayers = [NSMutableDictionary dictionary];
        }
    });
    self = temp;
    return self;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

//播放音乐
- (AVPlayer *)playingMusic:(NSString *)urlStr
{
    if (urlStr == nil || urlStr.length == 0)  return nil;
    
    AVPlayer *player = self.SJPlayers[urlStr];      //先查询对象是否缓存了
    
    if (!player) {
        NSURL *url = [NSURL URLWithString:urlStr];
        
        if (!url)  return nil;
        
        player = [[AVPlayer alloc] initWithURL:url];
        
        self.SJPlayers[urlStr] = player;            //对象是最新创建的，那么对它进行一次缓存
    }

    [player play];

    return player;
}

- (void)pauseMusic:(NSString *)urlStr
{
    if (urlStr == nil || urlStr.length == 0)  return;
    
    AVPlayer *player = self.SJPlayers[urlStr];
    
    [player pause];
}

@end
