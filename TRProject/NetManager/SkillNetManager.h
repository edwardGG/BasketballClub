//
//  SkillNetManager.h
//  TRProject
//
//  Created by tarena on 16/2/27.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SkillModel.h"
@interface SkillNetManager : NSObject

+ (id)getSkillListPage:(NSInteger)page completionHandler:kCompetionHandleBlock

@end
