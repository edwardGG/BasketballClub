//
//  SearchViewController.h
//  TRProject
//
//  Created by tarena on 16/3/16.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasketballModel.h"
#import "SkillModel.h"
#import "VideoModel.h"

@interface SearchViewController : UITableViewController
@property (nonatomic) NSArray<BasketballListModel *> *basketballList;
@property (nonatomic) NSArray<SkillModel *> *skillList;
@property (nonatomic) NSArray<VideoModel *> *videoList;
@end
