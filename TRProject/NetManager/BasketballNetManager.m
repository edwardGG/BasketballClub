//
//  BasketballNetManager.m
//  TRProject
//
//  Created by tarena on 16/2/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BasketballNetManager.h"

@implementation BasketballNetManager
+ (id)getDataWithType:(basketballType)type page:(NSInteger)page completionHandler:(void (^)(id, NSError *))completionHandle{
    NSString *path = nil;
    switch (type) {
        case basketballTypeNBA:{
            path = [NSString stringWithFormat:@"http://api.basketball.app887.com/api/Articles.action?keyword=&npc=%ld&opc=20&type=NBA&uid=19148", page];
            break;
        }
            
        case basketballTypeCBA:{
            path = [NSString stringWithFormat:@"http://api.basketball.app887.com/api/Articles.action?keyword=&npc=%ld&opc=20&type=CBA&uid=19154", page];
            break;
        }
    }
    return [self GET:path parameters:nil progress:nil completionHandle:^(id responseObj, NSError *error) {
        completionHandle([BasketballModel parse:responseObj], error);
    }];
}
@end
