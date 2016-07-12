//
//  PageViewController.m
//  TRProject
//
//  Created by tarena on 16/2/27.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "PageViewController.h"
#import "NBAViewController.h"
#import "NSObject+ViewModel.h"
#import "NBAViewController.h"
#import "SearchViewController.h"
#import "BasketballViewModel.h"
@interface PageViewController ()<UISearchResultsUpdating,UISearchBarDelegate>
@property (nonatomic) UIBarButtonItem *item2;


@property (nonatomic) NSArray *basketList;
@end

@implementation PageViewController

#pragma mark - UISearchBar Delegate
//当scope发生变化时
//- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope{
//    [self updateSearchResultsForSearchController:self.searchC];
//}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *text = searchController.searchBar.text;
    NSMutableArray *tmpArr = [NSMutableArray new];
    for (BasketballListModel *basketball in self.basketList) {
        if ([basketball.title containsString:text]) {
            [tmpArr addObject:basketball];
        }
    }
    SearchViewController *vc = (SearchViewController *)searchController.searchResultsController;
    vc.basketballList = tmpArr;
}
#pragma mark - 方法 methods
- (void)reloadNowData{
     NBAViewController *vc = [NBAViewController new];
     [vc.tableView addHeaderRefresh:^{
        [vc.basketballVM getDataWithRequestMode:RequestModeRefresh completionHanle:^(NSError *error) {
            [vc.tableView reloadData];
            [vc.tableView endHeaderRefresh];
        }];
    }];
    [vc.tableView beginHeaderRefresh];
}

- (void)as:sender{
    [self.sideMenuViewController presentLeftMenuViewController];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.showOnNavigationBar = NO;
        self.menuHeight = 64;
        self.menuItemWidth = kScreenW / 2;
        self.menuBGColor = [UIColor yellowColor];
        self.menuViewStyle = WMMenuViewStyleLine;
    }
    return self;
}
- (NSArray *)titles{
    return @[@"NBA", @"CBA"];
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.titles.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
    return self.titles[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    NBAViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NBAViewController"];
    vc.type = index;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // self.navigationItem.leftBarButtonItem = self.item2;
//    NBAViewController *vc = [NBAViewController new];
    
    
//    NBAViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NBAViewController"];
//    vc.tableView.tableHeaderView = self.searchC.searchBar;
//        self.tableView.tableHeaderView = vc.searchC.searchBar;
//    [vc.tableView addHeaderRefresh:^{
//        [vc.basketballVM getDataWithRequestMode:RequestModeRefresh completionHanle:^(NSError *error) {
//            [vc.tableView reloadData];
//            [vc.tableView endHeaderRefresh];
//        }];
//    }];
//    [vc.tableView addBackFooterRefresh:^{
//        [vc.basketballVM getDataWithRequestMode:RequestModeMore completionHanle:^(NSError *error) {
//            [vc.tableView reloadData];
//            [vc.tableView endFooterRefresh];
//        }];
//    }];
    self.definesPresentationContext = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
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

#pragma mark - 懒加载 Lazy load

//- (UISearchController *)searchC {
//    if(_searchC == nil) {
//        _searchC = [[UISearchController alloc] initWithSearchResultsController:[SearchViewController new]];
//        //设置搜索结果发生变化时，代理由谁负责
//        _searchC.searchResultsUpdater = self;
//        //应对scope修改后的监听问题
//        _searchC.searchBar.delegate = self;
//    }
//    return _searchC;
//}

- (NSArray *)basketList {
    if(_basketList == nil) {
        NBAViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NBAViewController"];
        _basketList = [vc.basketballVM.multiArr copy];
    }
    return _basketList;
}

//- (BasketballViewModel *)basketballVM {
//    if(_basketballVM == nil) {
//        _basketballVM = [[BasketballViewModel alloc] initWithType:self.type];
//    }
//    return _basketballVM;
//}

@end
