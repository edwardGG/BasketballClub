//
//  iCarouselDisplay.m
//  TRProject
//
//  Created by tarena on 16/3/17.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "iCarouselDisplay.h"

@implementation iCarouselDisplay
+ (instancetype)initWithImg:(NSString *)img title:(NSString *)title{
    iCarouselDisplay *ic = [self new];
    ic.img = img;
    ic.title = title;
    return ic;
}

+ (NSArray *)iCarouselDisplayList{
    iCarouselDisplay *i0 = [iCarouselDisplay initWithImg:@"5.jpg" title:@"跟着艾佛森学突破"];
    iCarouselDisplay *i1 = [iCarouselDisplay initWithImg:@"6.jpg" title:@"看巅峰韦德无解后仰"];
    iCarouselDisplay *i2 = [iCarouselDisplay initWithImg:@"7.jpg" title:@"记得那年能上天的卡特"];
    return @[i0, i1, i2];
}
@end
