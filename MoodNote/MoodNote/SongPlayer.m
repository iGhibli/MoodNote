//
//  SongPlayer.m
//  ASimpleAudioPlayer
//
//  Created by qingyun on 15/12/14.
//  Copyright © 2015年 Sky-jay. All rights reserved.
//

#import "SongPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface SongPlayer ()
@property (nonatomic, strong) AVPlayer *player;
@end

@implementation SongPlayer

+ (instancetype)sharedSongPlayer {
    static SongPlayer *songPlayer;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        songPlayer = [[SongPlayer alloc]init];
    });
    return songPlayer;
}

+ (void)playWithUrl:(NSString *)url
{
    [SongPlayer sharedSongPlayer].player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:url]];
    [[SongPlayer sharedSongPlayer].player play];
}

+ (void)stop
{
    [[SongPlayer sharedSongPlayer].player pause];
}

@end
