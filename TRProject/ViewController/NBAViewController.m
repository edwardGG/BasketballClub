//
//  NBAViewController.m
//  TRProject
//
//  Created by tarena on 16/2/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "NBAViewController.h"
#import "NBACell.h"
#import "NSObject+ViewModel.h"
#import <MJRefresh.h>
#import "DetailViewController.h"
#import "KSGuideManager.h"

#import "ZYTokenManager.h"
#import "PageViewController.h"

#define fontCOLOR [UIColor colorWithRed:163/255.0f green:163/255.0f blue:163/255.0f alpha:1]
@interface NBAViewController ()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation NBAViewController
- (IBAction)backBtn:(id)sender {
    [self.sideMenuViewController presentLeftMenuViewController];
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    DetailViewController *vc = [[DetailViewController alloc] initWithURL:[self.basketballVM urlForRow:row]];
    vc.title = [self.basketballVM titleForRow:row];
    vc.webURL = [self.basketballVM urlForRow:row];
    vc.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.basketballVM.rowNumber;
}

//给cell添加动画
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置Cell的动画效果为3D效果
    //设置x和y的初始值为0.1；
    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    //x和y的最终值为1
    [UIView animateWithDuration:1 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   NBACell *cell = [tableView dequeueReusableCellWithIdentifier:@"NBACell"];
    cell.titleLb.text = [self.basketballVM titleForRow:indexPath.row];
    cell.contentLb.text = [self.basketballVM contentForRow:indexPath.row];
    cell.authorLb.text = [self.basketballVM authorForRow:indexPath.row];
    cell.dateLb.text = [self.basketballVM dateForRow:indexPath.row];
    cell.readartsLb.text = [self.basketballVM readartsForRow:indexPath.row];
    [cell.Imglink setImageWithURL:[self.basketballVM imglinkForRow:indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 385;
}

#pragma mark - 生命周期 Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [_tableView registerNib:[UINib nibWithNibName:@"NBACell" bundle:nil] forCellReuseIdentifier:@"NBACell"];
    [_tableView addHeaderRefresh:^{
        [self.basketballVM getDataWithRequestMode:RequestModeRefresh completionHanle:^(NSError *error) {
            [_tableView reloadData];
            [_tableView endHeaderRefresh];
        }];
    }];
    [_tableView addBackFooterRefresh:^{
        [self.basketballVM getDataWithRequestMode:RequestModeMore completionHanle:^(NSError *error) {
            [_tableView reloadData];
            [_tableView endFooterRefresh];
        }];
    }];
    
    [_tableView beginHeaderRefresh];
    PageViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.tableView.tableHeaderView = vc.searchC.searchBar;
    NSMutableArray *paths = [NSMutableArray new];
    
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpg"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"2" ofType:@"jpg"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"3" ofType:@"jpg"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"4" ofType:@"jpg"]];
    [[KSGuideManager shared] showGuideViewWithImages:paths];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}

- (BasketballViewModel *)basketballVM {
	if(_basketballVM == nil) {
		_basketballVM = [[BasketballViewModel alloc] initWithType:self.type];
	}
	return _basketballVM;
}



@end
