//
//  VideoNetManager.m
//  TRProject
//
//  Created by tarena on 16/2/28.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "VideoNetManager.h"

@implementation VideoNetManager
+ (id)getVideoPage:(NSInteger)page completionHandler:(void (^)(id, NSError *))completionHandle{
       NSString *str = @"%E8%A7%86%E9%A2%91%E9%9B%86%E9%94%A6&uid=19148";
    NSString *path = [NSString stringWithFormat:@"http://api.basketball.app887.com/api/Articles.action?keyword=&npc=%ld&opc=20&type=%@", page, str];
    return [self GET:path parameters:nil progress:nil completionHandle:^(id responseObj, NSError *error) {
        completionHandle([VideoModel parse:responseObj], error);
    }];
}
@end
//http://api.basketball.app887.com/api/Articles.action?keyword=&npc=0&opc=20&type=%E8%A7%86%E9%A2%91%E9%9B%86%E9%94%A6&uid=19148