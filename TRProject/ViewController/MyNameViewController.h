//
//  MyNameViewController.h
//  TRProject
//
//  Created by tarena on 16/3/11.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyNameViewController;

@protocol MyNameDelegate <NSObject>

- (void)vcFrom:(MyNameViewController *)vc name:(NSString *)name;

@end
@interface MyNameViewController : UITableViewController
@property (nonatomic) id<MyNameDelegate> delegate;
@end
