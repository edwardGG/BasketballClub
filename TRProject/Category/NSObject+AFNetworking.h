//
//  NSObject+AFNetworking.h
//  Day08_Beauty
//
//  Created by tarena on 16/2/4.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

#define kCompetionHandleBlock (void(^)(id model, NSError *error))completionHandle;
//定义了一个block类型
typedef void(^CompetionHandleBlock)(id model, NSError *error);

@interface NSObject (AFNetworking)

+ (id)GET:(NSString *)path parameters:(id)parameters progress:(void(^)(NSProgress *downloadProgress))downloadProgress completionHandle:(void(^)(id responseObj, NSError *error))completionHandle;;;

+ (id)POST:(NSString *)path parameters:(id)parameters progress:(void(^)(NSProgress *downloadProgress))downloadProgress completionHandle:(void(^)(id responseObj, NSError *error))completionHandle;

@end











