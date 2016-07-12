//
//  LoginController.m
//  TRProject
//
//  Created by Edward on 16/4/3.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "LoginController.h"
#import <BmobSDK/Bmob.h>
@interface LoginController ()
@property (weak, nonatomic) IBOutlet UITextField *ID;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation LoginController
#pragma mark - 方法 methods
- (IBAction)login:(id)sender {
    BmobUser *bUser = [[BmobUser alloc] init];
    bUser.username = self.ID.text;
    [bUser setPassword:self.password.text];
    //添加自定义字段
    //    [bUser setObject:@18 forKey:@"age"];
    
    //注册
    [bUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
        if (isSuccessful){
            if (_ID.text.length == 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意" message:@"起个昵称吧" delegate:self cancelButtonTitle:@"重新填写" otherButtonTitles:nil];
                [alert show];
            }else{
//                UIAlertView *AlertView = [[UIAlertView alloc]initWithTitle:@"注册成功" message:@"点击返回" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil];
                [UIAlertView bk_showAlertViewWithTitle:@"注册成功" message:@"点击返回" cancelButtonTitle:@"返回" otherButtonTitles:nil handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                    if (buttonIndex == 0) {
                         [self.navigationController popViewControllerAnimated:YES] ;
                    }
                   
                }];
//                [AlertView show];
            }
            NSLog(@"chengogn");
        } else {
            NSLog(@"%@",error);
        }
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
