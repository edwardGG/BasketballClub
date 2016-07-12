//
//  NBAViewController.h
//  TRProject
//
//  Created by tarena on 16/2/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasketballNetManager.h"
#import "BasketballViewModel.h"

@interface NBAViewController : UIViewController
@property (nonatomic) basketballType type;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) BasketballViewModel *basketballVM;
@end
