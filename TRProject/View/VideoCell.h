//
//  VideoCell.h
//  TRProject
//
//  Created by tarena on 16/2/28.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoCell : UICollectionViewCell 
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *readartsLb;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;


@end
