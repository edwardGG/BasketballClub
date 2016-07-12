//
//  PageViewController.h
//  TRProject
//
//  Created by tarena on 16/2/27.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "WMPageController.h"
#import "BasketballViewModel.h"
@interface PageViewController : WMPageController
@property (nonatomic) basketballType type;
@property (nonatomic) UISearchController *searchC;
@end
