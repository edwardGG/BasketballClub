//
//  ReplyViewController.m
//  TRProject
//
//  Created by tarena on 16/3/14.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ReplyViewController.h"
#import "ReplyCell.h"
#import <BmobSDK/Bmob.h>
#import "SendViewController.h"
#import "SetTableViewController.h"
#import <SDWebImage/SDWebImageDownloaderOperation.h>
@interface ReplyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) UITableView *tableView;
@property (nonatomic, strong)NSArray *questions;
@property (nonatomic) NSArray *names;

@end

@implementation ReplyViewController
#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.questions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReplyCell" forIndexPath:indexPath];
    BmobObject *question = self.questions[indexPath.row];
    cell.sendContent.text = [question objectForKey:@"title"];
    NSString *imagePath = [question objectForKey:@"image"];
    if (imagePath) {
//        [[NSOperationQueue new] addOperationWithBlock:^{
//             NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imagePath]];
//            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                cell.sendImage.image = [UIImage imageWithData:data];
//            }];
//        }];
//        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imagePath]];
        [cell.sendImage setImageWithURL:[NSURL URLWithString:imagePath]];
        BmobObject *name = self.names[indexPath.row];
        cell.usename.text = [name objectForKey:@"username"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 270;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 生命周期 Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction)];
    self.navigationItem.rightBarButtonItem = addItem;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadQuestions];
 
}

- (void)loadQuestions{
    BmobQuery *query = [BmobQuery queryWithClassName:@"Questions"];
    //    [query whereKey:@"user" equalTo:[BmobUser getCurrentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        self.questions = array;
        [self.tableView reloadData];
    }];
    
    BmobQuery *name = [BmobQuery queryWithClassName:@"_User"];
    [name findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        self.names = array;
        [self.tableView reloadData];
    }];
}

- (void)addAction{
    SendViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SendViewController"];
       [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载 Lazy load
- (UITableView *)tableView {
	if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"ReplyCell" bundle:nil] forCellReuseIdentifier:@"ReplyCell"];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 64)];
        _tableView.tableHeaderView = view;
    }
	return _tableView;
}
@end
