//
//  Common.h
//  MoodNote
//
//  Created by qingyun on 16/1/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#ifndef Common_h
#define Common_h

/*  Size  */
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

/*  URL  */
#define kImageBaseURL    @"http://common.nineton.cn/CommonProject/uploadfiles/sentences_images"
#define kBaseURL         @"http://common.nineton.cn/CommonProject/sign/api/v1/sentence"

#define kVideoBaseURL    @"http://baobab.wandoujia.com/api/v1/feed?num=10&date=19921010&vc=403&u=e97100124566b8131dc411a89ff43861ec90022e&v=1.12.1&f=ipad"

/*  FileName  */
#define kSQLiteName     @"Favorites.db"
#define kTableName      @"Favorites"

/*  ReName  */
#define kTitle          @"title"
#define kPicURL         @"picUrl"
#define kPicHeight      @"picHeight"
#define kPicWidth       @"picWidth"

/* Others */
#define kAppVersion     @"kAppversion"

#endif /* Common_h */
