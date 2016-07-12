//
//  SetTableViewController.m
//  TRProject
//
//  Created by tarena on 16/3/4.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "SetTableViewController.h"
#import "CalculateSize.h"
#import "MapViewController.h"
@interface SetTableViewController ()
@property (weak, nonatomic) IBOutlet UITableViewCell *clear;

@end

@implementation SetTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.tableView.tableFooterView = view;
     
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.clear.detailTextLabel.text = [CalculateSize getCacheSize];
}

#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://695477919@qq.com"]];
    }
    if (indexPath.row == 3) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认清除？" message:@"清除后无法恢复" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
        [alert show];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *cacheFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/default/com.hackemist.SDWebImageCache.default"];
        [fileManager removeItemAtPath:cacheFilePath error:nil];
        self.clear.detailTextLabel.text = [CalculateSize getCacheSize];
    }
}
@end
