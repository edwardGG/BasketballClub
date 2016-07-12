//
//  SendViewController.m
//  TRProject
//
//  Created by tarena on 16/3/14.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "SendViewController.h"
#import <BmobSDK/Bmob.h>
@interface SendViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textTF;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) NSData *imageData;
@end

@implementation SendViewController
#pragma mark - 方法 methods
- (IBAction)chooseImage:(id)sender {
    UIImagePickerController *vc = [[UIImagePickerController alloc]init];
    //数据源类型 3中类型 1.照相机
    //    2.相册
    //    3.文件夹
    vc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    vc.delegate = self;
    //允许编辑
    vc.allowsEditing = YES;
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)send:(id)sender {
    if (self.imageData) {
        [BmobFile filesUploadBatchWithDataArray:@[@{@"filename":@"hehe.jpg",@"data":self.imageData}] progressBlock:^(int index, float progress) {
            NSLog(@"%f",progress);
        } resultBlock:^(NSArray *array, BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                NSLog(@"%@",array);
                BmobFile *file = [array firstObject];
                BmobObject *questionObj = [[BmobObject alloc]initWithClassName:@"Questions"];
                [questionObj setObject:self.textTF.text    forKey:@"title"];
                //把图片的网站保存到问题对象里面
                [questionObj setObject:file.url forKey:@"image"];
                [questionObj setObject:[BmobUser getCurrentUser] forKey:@"user"];
                [questionObj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    if (isSuccessful) {
                        NSLog(@"上传成功");
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                }];
            }
        }];
    }else{
        BmobObject *questionObj = [[BmobObject alloc]initWithClassName:@"Questions"];
        [questionObj setObject:self.textTF.text    forKey:@"title"];
        [questionObj setObject:[BmobUser getCurrentUser] forKey:@"user"];
        [questionObj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                NSLog(@"上传成功");
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
}
#pragma mark - 生命周期 Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    self.imageView.image = image;
    NSURL *url = info[UIImagePickerControllerReferenceURL];
    if ([url.description hasSuffix:@"PNG"]) {
        _imageData = UIImagePNGRepresentation(image);
    }else{
        _imageData = UIImageJPEGRepresentation(image, .5);
    }
   [self dismissViewControllerAnimated:YES completion:nil];
}

@end
