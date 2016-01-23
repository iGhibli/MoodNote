//
//  FavoriteEngine.m
//  MoodNote
//
//  Created by qingyun on 16/1/22.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "DBEngine.h"
#import "ContentModel.h"
#import "FMDB.h"
#import "Common.h"

@implementation DBEngine


+ (void)initialize {
    if (self == [DBEngine self]) {
        //将数据库文件copy到Documents路径下
        [DBEngine copyDataBaseFileToDocumentsWithDBName:kSQLiteName];
    }
}

+ (NSString *)getSQLiteFilePath
{
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [documentPath stringByAppendingPathComponent:kSQLiteName];
    return filePath;
}

+ (void)copyDataBaseFileToDocumentsWithDBName:(NSString *)DBName
{
    NSString *source = [[NSBundle mainBundle] pathForResource:kSQLiteName ofType:nil];
    NSString *toPath = [DBEngine getSQLiteFilePath];
    NSError *error;
    if ([[NSFileManager defaultManager] fileExistsAtPath:toPath]) {
        //如果toPath路径下有数据表文件则无需Copy直接返回
        return;
    }
    [[NSFileManager defaultManager] copyItemAtPath:source toPath:toPath error:&error];
    if (error) {
        NSLog(@"!!!!!!%@",error);
    }
}

+ (void)saveToLocalWithModel:(ContentModel *)model
{
    //插入操作，首先创建db，写sql语句，执行操作
    //使用队列时不需要自己创建db,队列会创建
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[DBEngine getSQLiteFilePath]];
    [queue inDatabase:^(FMDatabase *db) {
        
        //创建SQL语句
        NSString *SQLString = [NSString stringWithFormat:@"insert into Favorites(id ,title ,pic ,picWidth ,picHeight) values(%d ,'%@' ,'%@' ,%d ,%d);",[model.ID intValue] ,model.title ,model.pic_url ,[model.picWidth intValue] ,[model.picHeight intValue]];
        
            BOOL result = [db executeUpdate:SQLString];
            NSLog(@"%d>>>>%@",result, SQLString);
        
    }];
}

+ (NSArray *)getFavoritesFromLocal
{
    //创建数据库
    FMDatabase *db = [FMDatabase databaseWithPath:[DBEngine getSQLiteFilePath]];
    //打开数据库
    [db open];
    //查询语句
    NSString *SQLString = @"select * from Favorites";
    //查询并输出结果
    FMResultSet *result = [db executeQuery:SQLString];
    NSMutableArray *models = [NSMutableArray array];
    while ([result next]) {
        //将一条记录转化为一个字典
        NSDictionary *dict = [result resultDictionary];
//        NSMutableDictionary *muDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        
        //将字典转化为模型
        ContentModel *model = [[ContentModel alloc]initContentModelWithDictionary:dict];
        [models addObject:model];
    }
    //释放资源
    [db close];
    return models;
}


@end
