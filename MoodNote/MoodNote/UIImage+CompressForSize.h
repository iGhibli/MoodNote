//
//  UIImage+CompressForSize.h
//  MoodNote
//
//  Created by 赛驰 on 16/5/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CompressForSize)

//按比例缩放,size 是你要把图显示到 多大区域 CGSizeMake(300, 140)
+ (UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;

@end
