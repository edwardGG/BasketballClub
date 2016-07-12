//
//  DBNetManager.h
//  TRProject
//
//  Created by tarena on 16/3/15.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBNBAModel.h"
@interface DBNetManager : NSObject

//查询新闻列表
+ (void)getNewsListCompletionHandler:(void(^)(NSArray<DBNBAModel *> *newsList))completionHandler;

//删除新闻
+ (void)removeNews:(DBNBAModel *)news completionHandler:(void(^)(BOOL success))completionHandler;

@end
