//
//  NSString+Size.m
//  SJMicroBlog
//
//  Created by qingyun on 15/12/26.
//  Copyright © 2015年 iGhibli. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

/**
 *  计算文字显示的大小
 *
 *  @param font  字体大小
 *  @param width 文字显示的范围宽度
 *
 *  @return 计算得出的文字显示的大小
 */
- (CGSize)sizeWithFont:(UIFont *)font AndWidth:(CGFloat)width {
    //限制文字显示的区域大小
    CGSize size = CGSizeMake(width, MAXFLOAT);
    //设置文字显示的属性
    NSDictionary *params = @{NSFontAttributeName : font};
    //计算文字显示需要的大小
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:params context:nil];
    return rect.size;
}

@end
