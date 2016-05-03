//
//  NSString+DateFormater.h
//  MoodNote
//
//  Created by 赛驰 on 16/5/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DateFormater)

/**
 *  将秒数转化为0'00''
 *
 *  @param second 秒数
 *
 *  @return 0'00''格式的时间
 */
+ (NSString *)getFormateDateWithSecond:(NSString *)second;

@end
