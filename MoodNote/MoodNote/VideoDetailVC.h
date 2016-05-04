//
//  VideoDetailVC.h
//  MoodNote
//
//  Created by 赛驰 on 16/5/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoDetailVC : UIViewController
@property (nonatomic, strong) NSString *videoUrlStr;
@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, strong) NSString *descText;
@property (nonatomic, strong) NSString *coverBlurred;
@property (nonatomic, strong) NSString *sortText;
@property (nonatomic, strong) NSString *timeText;
@property (nonatomic, strong) NSString *coverForDetail;
@end
