//
//  BasketballViewModel.h
//  TRProject
//
//  Created by tarena on 16/2/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasketballModel.h"
#import "BasketballNetManager.h"


@interface BasketballViewModel : NSObject
@property (nonatomic) NSInteger rowNumber;
- (NSURL *)imglinkForRow:(NSInteger)row;
- (NSString *)titleForRow:(NSInteger)row;
- (NSString *)contentForRow:(NSInteger)row;
- (NSString *)readartsForRow:(NSInteger)row;
- (NSString *)dateForRow:(NSInteger)row;
- (NSString *)authorForRow:(NSInteger)row;
@property (nonatomic) NSMutableArray *multiArr;
@property (nonatomic) basketballType type;
- (instancetype)initWithType:(basketballType)type;
@property (nonatomic) NSInteger page;
- (NSURL *)urlForRow:(NSInteger)row;

@end
