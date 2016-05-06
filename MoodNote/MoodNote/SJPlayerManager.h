//
//  SJPlayer.h
//  MoodNote
//
//  Created by 赛驰 on 16/5/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface SJPlayerManager : NSObject

+ (instancetype)defaultManager;

+ (instancetype)allocWithZone:(struct _NSZone *)zone;

//播放音乐
- (AVPlayer *)playingMusic:(NSString *)urlStr;

- (void)pauseMusic:(NSString *)urlStr;

@end
