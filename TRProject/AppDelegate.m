//
//  AppDelegate.m
//  TRProject
//
//  Created by jiyingxin on 16/2/4.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "AppDelegate.h"
#import "BasketballNetManager.h"
#import "VideoNetManager.h"
#import <MLTransition.h>
#import "SkillNetManager.h"
#import "UMSocial.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import <BmobSDK/Bmob.h>
#import "KSGuideManager.h"
//微信
#define kWeChatAppId @"wx945b58aef3a271f0"
#define kWeChatSecret @"0ae78dd42761fd9681b04833c79a857b"

//QQ -- URL schema QQ41D5F108
#define kQQAppId @"1104539912"
#define kQQAppKey @"eFVgRits2fqf36Jf"

//新浪微博
#define kSinaAppKey @"1428551890"
#define kSinaAppSecret @"a49f35268e165bf244c3c3c617c3a65a"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskLandscape];
    [UMSocialData setAppKey:kUmengSDK];
    //由于苹果审核政策需求，建议大家对未安装客户端平台进行隐藏，在设置QQ、微信AppID之后调用下面的方法。
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]];
    
    [UMSocialWechatHandler setWXAppId:kWeChatAppId appSecret:kWeChatSecret url:@"http://www.umeng.com/social"];
    [UMSocialQQHandler setQQWithAppId:kQQAppId appKey:kQQAppKey url:@"http://www.umeng.com/social"];
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:kSinaAppKey
                                              secret:kSinaAppSecret
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
     
    [MLTransition validatePanPackWithMLTransitionGestureRecognizerType:MLTransitionGestureRecognizerTypeScreenEdgePan];
    [BasketballNetManager getDataWithType:basketballTypeCBA page:1 completionHandler:^(id model, NSError *error) {
       
    }];
    
    [SkillNetManager getSkillListPage:0 completionHandler:^(id model, NSError *error) {
        NSLog(@"asd");
    }];
    [VideoNetManager getVideoPage:0 completionHandler:^(id model, NSError *error) {
        
    }];
    [[UINavigationBar appearance] setBarTintColor:[UIColor yellowColor]];
    
    
    //bmob初始化操作
    [Bmob registerWithAppKey:@"afe03d7ba11c0909214c756ecdce82c5"];
    
  
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
