//
//  NSObject+AFNetworking.m
//  Day08_Beauty
//
//  Created by tarena on 16/2/4.
//  Copyright © 2016年 tarena. All rights reserved.
//                                 
#import "NSObject+AFNetworking.h"

@implementation NSObject (AFNetworking)
+ (id)GET:(NSString *)path parameters:(id)parameters progress:(void (^)(NSProgress *))downloadProgress completionHandle:(void (^)(id, NSError *))completionHandle{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json"]];
    manager.requestSerializer.timeoutInterval = 30;
    return [manager GET:path parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandle(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandle(nil, error);
        NSLog(@"error %@", error);
    }];
}

+ (id)POST:(NSString *)path parameters:(id)parameters progress:(void (^)(NSProgress *))downloadProgress completionHandle:(void (^)(id, NSError *))completionHandle{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json"]];
    manager.requestSerializer.timeoutInterval = 30;
    return [manager POST:path parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandle(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandle(nil, error);
        NSLog(@"error %@", error);
    }];
}

@end
