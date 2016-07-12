//
//  CollectViewController.m
//  TRProject
//
//  Created by tarena on 16/3/15.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "CollectViewController.h"
#import <FMDB.h>
#import "DBNBAViewModel.h"
#import "DetailViewController.h"
@interface CollectViewController ()
@property (nonatomic) FMDatabase *fmDB;
@property (nonatomic) DBNBAViewModel *dbNBAVM;
@property (nonatomic) NSIndexPath *indexPath;
@end

@implementation CollectViewController
#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dbNBAVM.newNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [self.dbNBAVM titleForRow:indexPath.row];
    
    /*---------去掉分割线左边的空白----------*/
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
    /*---------去掉分割线左边的空白----------*/
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *vc = [[DetailViewController alloc] initWithURL:[self.dbNBAVM detailURLForRow:indexPath.row]];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"不想收藏了?长按可删除";
}
#pragma mark - 生命周期 Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    UILongPressGestureRecognizer *glPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(gestureLongPress:)];
    glPress.minimumPressDuration = 1;
    [self.tableView addGestureRecognizer:glPress];
    [Factory addBackItemToVC:self];
    
    WK(weakSelf);
    [weakSelf.tableView addHeaderRefresh:^{
        [_dbNBAVM getNewsListCompletionHandler:^{
            [weakSelf.tableView reloadData];
        }];
        [weakSelf.tableView endHeaderRefresh];
    }];
    [weakSelf.tableView beginHeaderRefresh];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - 方法 Methods
- (void)gestureLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    CGPoint tmpPointTouch = [gestureRecognizer locationInView:self.tableView];
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        self.indexPath = [self.tableView indexPathForRowAtPoint:tmpPointTouch];
        if (_indexPath == nil) {
            NSLog(@"no tableView");
        }else{
            UIAlertView *alverView = [[UIAlertView alloc] initWithTitle:@"删除收藏" message:@"确定要删除收藏的内容?" delegate:self cancelButtonTitle:@"取消,还要留着" otherButtonTitles:@"不要了,确定删除", nil];
            [alverView show];
        }
    }
}
#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self.dbNBAVM removenews:self.dbNBAVM.newsList[_indexPath.row] completionHandler:^{
            [self.dbNBAVM getNewsListCompletionHandler:^{
                [self.tableView reloadData];
            }];
        }];
    }
}

#pragma mark - 懒加载 Lazy load
- (DBNBAViewModel *)dbNBAVM {
	if(_dbNBAVM == nil) {
		_dbNBAVM = [[DBNBAViewModel alloc] init];
	}
	return _dbNBAVM;
}

@end
