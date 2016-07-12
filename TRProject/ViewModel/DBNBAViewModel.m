//
//  DBNBAViewModel.m
//  TRProject
//
//  Created by tarena on 16/3/15.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "DBNBAViewModel.h"

@implementation DBNBAViewModel
- (NSInteger)newNumber
{
    return self.newsList.count;
}

- (NSArray<DBNBAModel *> *)newsList {
    if(_newsList == nil) {
        _newsList = [[NSArray<DBNBAModel *> alloc] init];
    }
    return _newsList;
}

- (DBNBAModel *)dataForRow:(NSInteger)row
{
    return self.newsList[row];
}

- (NSString *)titleForRow:(NSInteger)row
{
    return [self dataForRow:row].title;
}

-(NSURL *)detailURLForRow:(NSInteger)row
{
    return [NSURL URLWithString:[self dataForRow:row].thmurl];
}

- (void)getNewsListCompletionHandler:(void (^)())completionHandler
{
    [DBNetManager getNewsListCompletionHandler:^(NSArray<DBNBAModel *> *newsList) {
        self.newsList = newsList;
        NSLog(@"newsList %@",self.newsList);
        completionHandler();
    }];
}

- (void)removenews:(DBNBAModel *)news completionHandler:(void (^)())completionHandler
{
    [DBNetManager removeNews:news completionHandler:^(BOOL success) {
        completionHandler();
    }];
}

@end
