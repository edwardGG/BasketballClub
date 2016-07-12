//
//  DBNetManager.m
//  TRProject
//
//  Created by tarena on 16/3/15.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "DBNetManager.h"

@implementation DBNetManager
+ (FMDatabase *)sharedDB
{
    FMDatabase *db = [FMDatabase databaseWithPath:[kDocPath stringByAppendingPathComponent:@"db.sqlite"]];
    [db open];
    return db;
}

//查询新闻列表
+ (void)getNewsListCompletionHandler:(void(^)(NSArray<DBNBAModel *> *newsList))completionHandler
{
    //查询是耗时操作,放在多线程中查寻
    FMDatabase *db = [self sharedDB];
    
    [[NSOperationQueue new] addOperationWithBlock:^{
        
        FMResultSet *resultSet = [db executeQuery:@"select * from News"];
        
        NSMutableArray *tmpArr = [NSMutableArray new];
        
        while ([resultSet next]) {
            [tmpArr addObject:[DBNBAModel parse:resultSet]];
        }
        NSLog(@"tmpArr %@",tmpArr);
        [db close];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completionHandler(tmpArr);
        }];
    }];
}

//删除新闻
+ (void)removeNews:(DBNBAModel *)news completionHandler:(void(^)(BOOL success))completionHandler
{
    FMDatabase *db = [self sharedDB];
    [[NSOperationQueue new] addOperationWithBlock:^{
        BOOL success = [db executeUpdateWithFormat:@"delete from News where title = %@", news.title];
        NSLog(@"%@",success ? @"删除成功":@"删除失败");
        [db close];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completionHandler(success);
        }];
    }];
}
@end
