//
//  MyNameViewController.m
//  TRProject
//
//  Created by tarena on 16/3/11.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "MyNameViewController.h"
#import <BmobSDK/Bmob.h>
#import "ReplyViewController.h"

@interface MyNameViewController ()
@property (weak, nonatomic) IBOutlet UITextField *pwTF;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@end

@implementation MyNameViewController
#pragma mark - 方法 methods

- (IBAction)login:(id)sender {
    [BmobUser loginInbackgroundWithAccount:self.nameTF.text andPassword:self.pwTF.text block:^(BmobUser *user, NSError *error) {
        if (user) {
            if(self.nameTF.text.length == 0){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意" message:@"账号不能为空" delegate:self cancelButtonTitle:@"重新填写" otherButtonTitles:nil];
                [alert show];
                return;
            }else{
            ReplyViewController *vc = [ReplyViewController new];
            [self.navigationController pushViewController:vc animated:YES];
            }
        } else {
            NSLog(@"%@",error);
        }
    }];
}

#pragma mark - 生命周期 Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];

    //获得当前用户
    if ([BmobUser getCurrentUser]) {
        
        ReplyViewController *vc = [ReplyViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
@end
