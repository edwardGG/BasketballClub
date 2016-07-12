//
//  VideoNetManager.h
//  TRProject
//
//  Created by tarena on 16/2/28.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoModel.h"

@interface VideoNetManager : NSObject
+ (id)getVideoPage:(NSInteger)page completionHandler:kCompetionHandleBlock;
@end
