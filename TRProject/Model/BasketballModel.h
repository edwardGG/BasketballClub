//
//  BasketballModel.h
//  TRProject
//
//  Created by tarena on 16/2/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BasketballRootModel,BasketballListModel,Basketball_IdModel;
@interface BasketballModel : NSObject

@property (nonatomic, strong) BasketballRootModel *root;

@end
@interface BasketballRootModel : NSObject

@property (nonatomic, copy) NSString *count;

@property (nonatomic, strong) NSArray<BasketballListModel *> *list;

@end

@interface BasketballListModel : NSObject

@property (nonatomic, assign) NSInteger TYPESETTING;

@property (nonatomic, assign) NSInteger liked;

@property (nonatomic, strong) NSArray *talks;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) BOOL PUBLISH;

@property (nonatomic, copy) NSString *duration;

@property (nonatomic, copy) NSString *CTIME;

@property (nonatomic, copy) NSString *imglink;

@property (nonatomic, assign) NSInteger talkcount;

@property (nonatomic, assign) NSInteger readarts;

@property (nonatomic, strong) Basketball_IdModel *_id;

@property (nonatomic, assign) BOOL DELFLAG;

@property (nonatomic, copy) NSString *sourcename;

@property (nonatomic, assign) NSInteger likecount;

@property (nonatomic, assign) NSInteger SORT;

@property (nonatomic, assign) BOOL OPENSOURCE;

@property (nonatomic, assign) NSInteger recommond;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *content168;

@property (nonatomic, assign) NSInteger faved;

@property (nonatomic, copy) NSString *TYPE;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *videolink;

@property (nonatomic, copy) NSString *author;

@property (nonatomic, copy) NSString *titlespelling;

@end

@interface Basketball_IdModel : NSObject

@property (nonatomic, assign) BOOL new;

@property (nonatomic, assign) NSInteger timeSecond;

@property (nonatomic, assign) NSInteger inc;

@property (nonatomic, assign) NSInteger machine;

@property (nonatomic, assign) long long time;

@end

