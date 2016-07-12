//
//  DetailViewController.m
//  TRProject
//
//  Created by tarena on 16/2/27.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "DetailViewController.h"
#import <FMDB.h>

@interface DetailViewController ()<UIWebViewDelegate>
@property (nonatomic) UIWebView *webView;
@property (nonatomic) UIBarButtonItem *collectionItem;
@property (nonatomic) FMDatabase *db;
@property (nonatomic) FMDatabase *fmDB;
@end

@implementation DetailViewController
#pragma mark - UIWebView Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [webView showBusyHUD];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [webView hideBusyHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [webView showWarning:@"加载失败"];
    
}

#pragma mark - 生命周期 Life Circle
- (instancetype)initWithURL:(NSURL *)webURL{
    if (self = [super init]) {
        self.webURL = webURL;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Factory addBackItemToVC:self];
    [self collectionItem];
    //创建数据库
    _db = [FMDatabase databaseWithPath:[kDocPath stringByAppendingPathComponent:@"db.sqlite"]];
    [_db open];
    BOOL success = [_db executeUpdate:@"create table News (title text,thmurl text)"];
    NSLog(@"%@", success?@"创建表格成功":@"创建表格失败");
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.webURL]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - 懒加载 Lazy load
- (UIWebView *)webView {
	if(_webView == nil) {
		_webView = [[UIWebView alloc] init];
        [self.view addSubview:_webView];
        _webView.delegate = self;
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
	}
	return _webView;
}

- (UIBarButtonItem *)collectionItem {
    if(_collectionItem == nil) {
        _collectionItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks         target:self action:@selector(collectNews)];
        self.navigationItem.rightBarButtonItem = _collectionItem;
    }
    return _collectionItem;
}

- (void)collectNews
{
    BOOL success = [self.db executeUpdate:@"insert into News (title,thmurl) values (?,?)" values:@[self.title,[self.webURL absoluteString]] error:nil];
    
    if (success) {
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"收藏" message:@"收藏成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertV show];
    }else{
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"收藏" message:@"收藏失败,请重试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertV show];
        
    }
    NSLog(@"%@", success?@"插入数据成功":@"插入数据失败");
}

@end
