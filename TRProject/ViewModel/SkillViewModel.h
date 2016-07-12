//
//  SkillViewModel.h
//  TRProject
//
//  Created by tarena on 16/2/27.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SkillModel.h"
#import "SkillNetManager.h"
@interface SkillViewModel : NSObject
@property (nonatomic) NSInteger rowNumber;
- (NSString *)titleForRow:(NSInteger)row;
- (NSURL *)imglinkForRow:(NSInteger)row;
- (NSString *)dateForRow:(NSInteger)row;
- (NSString *)readartsForRow:(NSInteger)row;
@property (nonatomic) NSMutableArray *mutliArr;

//@property (nonatomic) NSArray *imgArr;//存图片的数组
- (NSURL *)leftImgForRow:(NSInteger)row;
- (NSURL *)middleImgForRow:(NSInteger)row;
- (NSURL *)rightForRow:(NSInteger)row;

- (BOOL)hasThreeImage:(NSInteger)row;
- (BOOL)hasOneImage:(NSInteger)row;
- (BOOL)hasNoImage:(NSInteger)row;
@property (nonatomic) NSInteger page;
- (NSURL *)urlForRow:(NSInteger)row;
@end
