//
//  SkillViewController.m
//  TRProject
//
//  Created by tarena on 16/2/27.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "SkillViewController.h"
#import "iCarousel.h"
#import "iCarouselDisplay.h"
#import "SkillViewModel.h"
#import "SkillImgCell.h"
#import "SkillNoImgCell.h"
#import <MJRefresh.h>
#import "NSObject+ViewModel.h"
#import "NoImageCell.h"
#import "DetailViewController.h"
#import "LeftViewController.h"

@interface SkillViewController ()<UITableViewDelegate,UITableViewDataSource,iCarouselDelegate, iCarouselDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) SkillViewModel *skillVM;
@property (nonatomic) UIBarButtonItem *item;
@property (nonatomic) UIBarButtonItem *item2;

@property (nonatomic) iCarousel *ic;
@property (nonatomic) NSArray *icVM;
@property (nonatomic) UIPageControl *pc;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) UILabel *titleLb;
@end

@implementation SkillViewController
#pragma mark - iCarousel Delegate
- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    _pc.currentPage = carousel.currentItemIndex;
    iCarouselDisplay *item = self.icVM[carousel.currentItemIndex];
    _titleLb.text = item.title;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    if (option == iCarouselOptionWrap) {
        return YES;
    }
    return value;
}

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return self.icVM.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:carousel.frame];
        UIImageView *iv = [UIImageView new];
        [view addSubview:iv];
        
        
        iv.contentMode = UIViewContentModeScaleAspectFill;
        
        //切除多余部分
        iv.clipsToBounds = YES;
        iv.tag = 1000;
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(0);
            make.bottom.equalTo(-30);
        }];
    }
    iCarouselDisplay *item = self.icVM[index];
    UIImageView *iv = [view viewWithTag:1000];

    iv.image = [UIImage imageNamed:item.img];
    return view;
}



#pragma mark - 方法 methods
- (void)reloadNowData:sender{
    [_tableView addHeaderRefresh:^{
        [self.skillVM getDataWithRequestMode:RequestModeRefresh completionHanle:^(NSError *error) {
            [_tableView reloadData];
            [_tableView endHeaderRefresh];
        }];
    }];
    [_tableView beginHeaderRefresh];
}

- (void)as:sender{
    [self.sideMenuViewController presentLeftMenuViewController];
}


#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.skillVM.rowNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.skillVM hasThreeImage:indexPath.row]) {
        SkillImgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SkillImgCell"];
        cell.titleLb.text = [self.skillVM titleForRow:indexPath.row];
        cell.dateLb.text = [self.skillVM dateForRow:indexPath.row];
        cell.readartsLb.text = [self.skillVM readartsForRow:indexPath.row];
        [cell.leftImage setImageWithURL:[self.skillVM leftImgForRow:indexPath.row]];
        [cell.middleImg setImageWithURL:[self.skillVM middleImgForRow:indexPath.row]];
        [cell.rightImage setImageWithURL:[self.skillVM rightForRow:indexPath.row]];
        return cell;
    }
   else if ([self.skillVM hasOneImage:indexPath.row]) {
        SkillNoImgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SkillNoImgCell"];
        cell.titleLb.text = [self.skillVM titleForRow:indexPath.row];
        cell.dateLb.text = [self.skillVM dateForRow:indexPath.row];
        cell.readartsLb.text = [self.skillVM readartsForRow:indexPath.row];
        [cell.imgView setImageWithURL:[self.skillVM imglinkForRow:indexPath.row]];
        return cell;
    }else{
        NoImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoImageCell"];
        cell.titleLb.text = [self.skillVM titleForRow:indexPath.row];
        cell.dateLb.text = [self.skillVM dateForRow:indexPath.row];
        cell.readartsLb.text = [self.skillVM readartsForRow:indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.skillVM hasThreeImage:indexPath.row]) {
        return 180;
    }
   else if ([self.skillVM hasOneImage:indexPath.row]) {
       return 130;
    }else{
        return 90;
    }
  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *vc = [[DetailViewController alloc] initWithURL:[self.skillVM urlForRow:indexPath.row]];
    vc.title = [self.skillVM titleForRow:indexPath.row];
    vc.webURL = [self.skillVM urlForRow:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 生命周期 Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.item2;
    [_tableView registerNib:[UINib nibWithNibName:@"SkillNoImgCell" bundle:nil] forCellReuseIdentifier:@"SkillNoImgCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"SkillImgCell" bundle:nil] forCellReuseIdentifier:@"SkillImgCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"NoImageCell" bundle:nil] forCellReuseIdentifier:@"NoImageCell"];
    [_tableView addHeaderRefresh:^{
        [self.skillVM getDataWithRequestMode:RequestModeRefresh completionHanle:^(NSError *error) {
            [_tableView reloadData];
            [_tableView endHeaderRefresh];
        }];
    }];
    [_tableView addBackFooterRefresh:^{
        [self.skillVM getDataWithRequestMode:RequestModeMore completionHanle:^(NSError *error) {
            [_tableView reloadData];
            [_tableView endFooterRefresh];
        }];
    }];
    [_tableView beginHeaderRefresh];
    
    self.navigationItem.rightBarButtonItem = self.item;
    self.tableView.tableHeaderView = self.ic;
    self.pc.numberOfPages = self.icVM.count;
    [self carouselCurrentItemIndexDidChange:self.ic];
    _timer = [NSTimer bk_scheduledTimerWithTimeInterval:4 block:^(NSTimer *timer) {
        [_ic scrollToItemAtIndex:_ic.currentItemIndex+1 animated:YES];
#pragma 在定时器里调用动画效果
        CATransition *transtion = [CATransition animation];
        //            [transtion setStartProgress:0.5];
        //            [transtion setEndProgress:0.6];
        transtion.duration = 2;
        [transtion setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        [transtion setType:@"cube"];
        [transtion setSubtype:kCATransitionFromTop];
        [_ic.layer addAnimation:transtion forKey:@"transtionKey"];
        
    } repeats:YES];
}

//给cell添加动画
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置Cell的动画效果为3D效果
    //设置x和y的初始值为0.1；
//    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1);
    cell.layer.transform = CATransform3DMakeRotation(M_PI /2, 0.1, 0.1, 0.1);
//    cell.layer.transform = CATransform3DMakeTranslation(0, 0, 1);
    
    //x和y的最终值为1
    [UIView animateWithDuration:1 animations:^{
//        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
         cell.layer.transform = CATransform3DMakeRotation(0, 1, 1, 1);
//        cell.layer.transform = CATransform3DMakeTranslation(0.5, 0.5, 0.5);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (SkillViewModel *)skillVM {
	if(_skillVM == nil) {
		_skillVM = [[SkillViewModel alloc] init];
	}
	return _skillVM;
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



- (iCarousel *)ic {
    if(_ic == nil) {
        //370 * 750
        _ic = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenW * 370 / 750  + 30)];
        _ic.delegate = self;
        _ic.dataSource = self;
        //滚动图片的下方白色条
        UIView *lineView = [UIView new];
        lineView.backgroundColor = kRGBA(235, 235, 235, 1);
        [_ic addSubview:lineView];
        _ic.scrollSpeed = 0.1;
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(0);
            make.height.equalTo(30);
        }];
        //翻页控件
        _pc = [UIPageControl new];
        [lineView addSubview:_pc];
        [_pc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.right.equalTo(-8);
        }];
        _pc.userInteractionEnabled = NO;
        _pc.pageIndicatorTintColor = [UIColor grayColor];
        _pc.currentPageIndicatorTintColor = [UIColor blackColor];
        
        _titleLb = [UILabel new];
        [lineView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(8);
            make.right.equalTo(_pc.mas_left).equalTo(8);
        }];
        _titleLb.font = [UIFont systemFontOfSize:14];
    }
    return _ic;
}

- (NSArray *)icVM {
	if(_icVM == nil) {
		_icVM = [iCarouselDisplay iCarouselDisplayList];
	}
	return _icVM;
}

@end
