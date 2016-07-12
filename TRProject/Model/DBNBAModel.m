//
//  DBNBAModel.m
//  TRProject
//
//  Created by tarena on 16/3/15.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "DBNBAModel.h"

@implementation DBNBAModel
+ (DBNBAModel *)parse:(FMResultSet *)result
{
    DBNBAModel *model = [self new];
    model.title = [result stringForColumn:@"title"];
    model.thmurl = [result stringForColumn:@"thmurl"];
    return model;
}
@end
