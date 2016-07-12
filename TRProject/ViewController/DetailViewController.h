//
//  DetailViewController.h
//  TRProject
//
//  Created by tarena on 16/2/27.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
- (instancetype)initWithURL:(NSURL *)webURL;
@property (nonatomic) NSURL *webURL;
@property (nonatomic, copy) NSString *title;


@end
