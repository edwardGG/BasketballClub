//
//  SearchViewController.m
//  TRProject
//
//  Created by tarena on 16/3/16.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "SearchViewController.h"
#import "DetailViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)setBasketballList:(NSArray<BasketballListModel *> *)basketballList {
    _basketballList = basketballList;
    [self.tableView reloadData];
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.basketballList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    BasketballListModel *basketball = _basketballList[indexPath.row];
    cell.textLabel.text = basketball.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BasketballListModel *basketball = self.basketballList[indexPath.row];
    DetailViewController *vc = [[DetailViewController alloc] initWithURL:[NSURL URLWithString:basketball.url]];
//    UINavigationController *navi=[[UINavigationController alloc]initWithRootViewController:self];
//    [navi pushViewController:vc animated:YES];
//    [self.navigationController presentViewController:vc animated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, kScreenW, 44);
    self.tableView.tableHeaderView = view;
    UIView *view1 = [UIView new];
    self.tableView.tableFooterView = view1;
//    [Factory addBackDismissItemToVC:self];
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
