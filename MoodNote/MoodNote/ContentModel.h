//
//  ContentModel.h
//  MoodNote
//
//  Created by qingyun on 16/1/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContentModel : NSObject

@property (nonatomic, strong) NSString *ID;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *pic_url;
@property (nonatomic, strong) NSString *picHeight;
@property (nonatomic, strong) NSString *picWidth;

- (instancetype)initContentModelWithDictionary:(NSDictionary *)dict;

@end
