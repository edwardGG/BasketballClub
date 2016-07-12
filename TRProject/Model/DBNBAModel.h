//
//  DBNBAModel.h
//  TRProject
//
//  Created by tarena on 16/3/15.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBNBAModel : NSObject
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *thmurl;
+ (DBNBAModel *)parse:(FMResultSet *)result;
@end
