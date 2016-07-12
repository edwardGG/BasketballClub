//
//  SkillNetManager.m
//  TRProject
//
//  Created by tarena on 16/2/27.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "SkillNetManager.h"
#import "Factory.h"

@implementation SkillNetManager

+ (id)getSkillListPage:(NSInteger)page completionHandler:(void (^)(id, NSError *))completionHandle{
        NSString *str=@"%E6%8A%80%E5%B7%A7%E7%99%BE%E7%A7%91";
    NSString *str2=[NSString stringWithFormat:@"http://api.basketball.app887.com/api/Articles.action?keyword=&npc=%ld&opc=20&type=%@&uid=19148",page,str];
    
         return [self GET:str2 parameters:nil progress:nil completionHandle:^(id responseObj, NSError *error) {
        completionHandle([SkillModel parse:responseObj], error);
    }];
}
@end
