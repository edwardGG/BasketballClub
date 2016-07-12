//
//  VideoViewModel.h
//  TRProject
//
//  Created by tarena on 16/2/28.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoModel.h"
@interface VideoViewModel : NSObject
@property (nonatomic) NSInteger rowNumber;
- (NSString *)titleForRow:(NSInteger)row;
- (NSString *)readartsForRow:(NSInteger)row;
- (NSString *)dateForRow:(NSInteger)row;
- (NSURL *)imgForRow:(NSInteger)row;
@property (nonatomic) NSMutableArray *multiArr;
@property (nonatomic) NSInteger page;
- (NSURL *)urlForRow:(NSInteger)row;
@end
