//
//  NSString+DateFormater.m
//  MoodNote
//
//  Created by 赛驰 on 16/5/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "NSString+DateFormater.h"

@implementation NSString (DateFormater)

+ (NSString *)getFormateDateWithSecond:(NSString *)second {
    int time = [second intValue];
    int minuteSub = time/60;
    int secondSub = time%60;
    NSString *value = [NSString stringWithFormat:@"%d'%d\"",minuteSub,secondSub];
    return value;
}

@end
