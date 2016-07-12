//
//  iCarouselDisplay.h
//  TRProject
//
//  Created by tarena on 16/3/17.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iCarouselDisplay : NSObject
@property (nonatomic) NSString *img;
@property (nonatomic) NSString *title;

+ (instancetype)initWithImg:(NSString *)img title:(NSString *)title;

+ (NSArray *)iCarouselDisplayList;
@end
