//
//  CalculateSize.m
//  HYN_Project
//
//  Created by  候艳宁 on 16/3/5.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "CalculateSize.h"

@implementation CalculateSize

+ (NSString *)getCacheSize
{
    //缓存大小
    long long sumSize = 0;
    //获取缓存路径
    NSString *cacheFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/default/com.hackemist.SDWebImageCache.default"];
    NSLog(@" filePath %@",cacheFilePath);
    //创建文件管理对象
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //获取当前缓存路径下的所有子路径
    NSArray *subPaths = [fileManager subpathsOfDirectoryAtPath:cacheFilePath error:nil];
    
    //遍历所有子文件夹
    for (NSString * subPath in subPaths) {
        //拼接完整路径
        NSString *filePath = [cacheFilePath stringByAppendingFormat:@"/%@",subPath];
        //计算文件大小
        long long fileSize = [[fileManager attributesOfItemAtPath:filePath error:nil] fileSize];
        //加到总文件大小
        sumSize += fileSize;
    }
    float size_m = sumSize/(1024 * 1024);
    return [NSString stringWithFormat:@"%.2fM",size_m];
}

@end
