//
//  SongPlayer.h
//  ASimpleAudioPlayer
//
//  Created by qingyun on 15/12/14.
//  Copyright © 2015年 Sky-jay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SongPlayer : NSObject

+ (instancetype)sharedSongPlayer;

+ (void)playWithUrl:(NSString *)url;

+ (void)stop;

@end
