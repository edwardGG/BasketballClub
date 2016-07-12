//
//  VideoModel.m
//  TRProject
//
//  Created by tarena on 16/2/28.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel

@end
@implementation VideoRootModel

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [VideoListModel class]};
}

@end


@implementation VideoListModel

@end


@implementation Video_IdModel

@end


