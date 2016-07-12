//
//  VideoViewController.m
//  TRProject
//
//  Created by tarena on 16/2/28.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "VideoViewController.h"
@import AVFoundation;
@import MediaPlayer;

#import "VideoViewModel.h"
#import <MJRefresh.h>
#import "VideoCell.h"
#import "NSObject+ViewModel.h"
#import "DetailViewController.h"
#import "UMSocial.h"
#import "AppDelegate.h"


@interface VideoViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UMSocialUIDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) VideoViewModel *videoVM;
@property (nonatomic) UIBarButtonItem *item;
@property (nonatomic) UIBarButtonItem *item2;
@property (nonatomic) NSString *str;
@property (nonatomic) NSString *url1;
@end

@implementation VideoViewController
#pragma mark - 方法 methods
- (void)share:(UIButton *)sender{
    NSInteger index= sender.tag;
    NSArray *snsNames = @[UMShareToQQ, UMShareToSms, UMShareToSina, UMShareToEmail, UMShareToTencent, UMShareToWechatTimeline, UMShareToWechatSession, UMShareToWechatFavorite];
       [UMSocialSnsService presentSnsIconSheetView:self appKey:kUmengSDK shareText:[NSString stringWithFormat:@"%@ %@", [self.videoVM urlForRow:index],[self.videoVM titleForRow:index]] shareImage:[UIImage imageNamed:@"icon.png"] shareToSnsNames:snsNames delegate:self];
}

- (void)reloadNowData:sender{
    [_collectionView addHeaderRefresh:^{
        [self.videoVM getDataWithRequestMode:RequestModeRefresh completionHanle:^(NSError *error) {
            [_collectionView reloadData];
            [_collectionView endHeaderRefresh];
        }];
    }];
    [_collectionView beginHeaderRefresh];
}

#pragma mark - UICollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    //激活设置
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    //iOS8以后被抛弃，被AV...player替换了
    MPMoviePlayerViewController *moviePlayerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:[self.videoVM urlForRow:indexPath.row]];
    [self presentViewController:moviePlayerVC animated:YES completion:nil];
    //手动调用播放
    [moviePlayerVC.moviePlayer play];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.videoVM.rowNumber;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    //给cell添加动画
        //设置Cell的动画效果为3D效果
        //设置x和y的初始值为0.1；
//        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    cell.layer.transform = CATransform3DMakeTranslation(M_PI/2, M_PI/2, M_PI);
        //x和y的最终值为1
        [UIView animateWithDuration:1 animations:^{
//            cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
            cell.layer.transform = CATransform3DMakeTranslation(0, 0, 0);
        }];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    VideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VideoCell" forIndexPath:indexPath];
    cell.titleLb.text = [self.videoVM titleForRow:indexPath.row];
    cell.readartsLb.text = [self.videoVM readartsForRow:indexPath.row];
    [cell.imgView setImageWithURL:[self.videoVM imgForRow:indexPath.row]];
    [cell.shareBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    cell.shareBtn.tag = indexPath.row;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectiopnViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (kScreenW - 20)/2;
    CGFloat height = width * 180 / 183;
    return CGSizeMake(width, height);
}

#pragma mark - 生命周期 Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [_collectionView registerNib:[UINib nibWithNibName:@"VideoCell" bundle:nil] forCellWithReuseIdentifier:@"VideoCell"];
    [_collectionView addHeaderRefresh:^{
        [self.videoVM getDataWithRequestMode:RequestModeRefresh completionHanle:^(NSError *error) {
            [_collectionView endHeaderRefresh];
            [_collectionView reloadData];
        }];
    }];
    [_collectionView addBackFooterRefresh:^{
        [self.videoVM getDataWithRequestMode:RequestModeMore completionHanle:^(NSError *error) {
            [_collectionView endFooterRefresh];
            [_collectionView reloadData];
        }];
    }];
    [_collectionView beginHeaderRefresh];
    self.navigationItem.leftBarButtonItem = self.item2;
       self.navigationItem.rightBarButtonItem = self.item;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)as:sender{
    [self.sideMenuViewController presentLeftMenuViewController];
}

#pragma mark - 懒加载 Lazy load
- (VideoViewModel *)videoVM {
	if(_videoVM == nil) {
		_videoVM = [[VideoViewModel alloc] init];
	}
	return _videoVM;
}

- (UIBarButtonItem *)item {
    if(_item == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"bm_maker_switch_camera"] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 22, 22);
        [btn addTarget:self action:@selector(reloadNowData:) forControlEvents:UIControlEventTouchUpInside];
        _item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
    return _item;
}

- (UIBarButtonItem *)item2 {
    if(_item2 == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"addorde_tabl_edit"] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 38, 38);
        [btn addTarget:self action:@selector(as:) forControlEvents:UIControlEventTouchUpInside];
        _item2 = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
    return _item2;
}

@end
