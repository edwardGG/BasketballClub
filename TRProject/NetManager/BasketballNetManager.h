//
//  BasketballNetManager.h
//  TRProject
//
//  Created by tarena on 16/2/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasketballModel.h"

typedef NS_ENUM(NSUInteger, basketballType){
      basketballTypeNBA,
      basketballTypeCBA,
};

@interface BasketballNetManager : NSObject

+ (id)getDataWithType:(basketballType)type page:(NSInteger)page completionHandler:kCompetionHandleBlock
@end
