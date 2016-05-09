//
//  HomeVC.h
//  MoodNote
//
//  Created by qingyun on 16/1/26.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeVC : UIViewController

// 设置本地通知
+ (void)registerLocalNotification:(NSInteger)alertTime;
+ (void)cancelLocalNotificationWithKey:(NSString *)key;

@end
