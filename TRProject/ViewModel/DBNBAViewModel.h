//
//  DBNBAViewModel.h
//  TRProject
//
//  Created by tarena on 16/3/15.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBNBAModel.h"
#import "DBNetManager.h"
@interface DBNBAViewModel : NSObject
//趣闻
@property (nonatomic) NSInteger newNumber;
@property (nonatomic) NSArray<DBNBAModel *> *newsList;

- (NSString *)titleForRow:(NSInteger)row;
- (NSURL *)detailURLForRow:(NSInteger)row;
- (void)removenews:(DBNBAModel *)news completionHandler:(void(^)())completionHandler;

- (void)getNewsListCompletionHandler:(void(^)())completionHandler;
@end
