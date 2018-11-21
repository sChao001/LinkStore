//
//  AppDelegate.m
//  Link
//
//  Created by Surdot on 2018/4/17.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+UMSocial.h"
#import "AppDelegate+LogIn.h"
#import "LKMessageListController.h"
#import "ViewController.h"
#import "LKTabBarController.h"
#import "IMDataSource.h"
#import "LoginViewController.h"
#import "QRImmageViewController.h"
#import "GroupListModel.h"
#import "FakeLaunchViewController.h"
#import "LKSessionViewController.h"
#import "WXApiManager.h"
//#import <UMCommon/UMCommon.h>
#import "MerchantsReceiveController.h"



@interface AppDelegate () /// <RCIMUserInfoDataSource, RCIMGroupInfoDataSource, RCIMConnectionStatusDelegate>
@property (nonatomic, strong) RCUserInfo *currentUserInfo;
//@property (nonatomic, strong) ViewController *VC;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSString *starTimeStr;
@property (nonatomic, strong) NSString *endTimeStr;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyWindow];

    NSLog(@"%@", Un_LogInSign.md5String);
    [self configLogInSettings];
    

    /**
     * 推送处理1
     */
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //注册推送, 用于iOS8以及iOS8之后的系统
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)
                                                categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    /**
     * 统计推送打开率1
     */
    [[RCIMClient sharedRCIMClient] recordLaunchOptionsEvent:launchOptions];
    /**
     * 获取融云推送服务扩展字段1
     */
    NSDictionary *pushServiceData = [[RCIMClient sharedRCIMClient] getPushExtraFromLaunchOptions:launchOptions];
    if (pushServiceData) {
        NSLog(@"该启动事件包含来自融云的推送服务");
        for (id key in [pushServiceData allKeys]) {
            NSLog(@"%@", pushServiceData[key]);
        }
    } else {
        NSLog(@"该启动事件不包含来自融云的推送服务");
    }
    NSLog(@"%@", BD_MD5Sign.md5String);
    
    NSLog(@"%@", [UserInfo sharedInstance].getUserid);
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    NSLog(@"%@", timeSp);
    
    //微信支付,向微信注册
    [WXApi registerApp:@"wxc14fc2456db18d30" enableMTA:YES];
    //友盟分享
    [self configUMSocial];
    
    //极光推送
    [self configJPUshSetting:launchOptions];
//    NSDictionary *remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
//    NSLog(@"%@", remoteNotification);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveRedBadgeValue" object:nil];
    NSLog(@"%d", [[RCIMClient sharedRCIMClient] getTotalUnreadCount]);
    
    [AMapServices sharedServices].apiKey = @"8f815186225f1b1441f42f41f8d75122";

    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time = [date timeIntervalSince1970];
    NSLog(@"%.3f", time);
    
    _starTimeStr = [NSString stringWithFormat:@"%.0f", time*1000];
    
    return YES;
}

//推送处理2
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveRedBadgeValue" object:nil];
}
//推送处理3
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""]
                        stringByReplacingOccurrencesOfString:@">"
                        withString:@""] stringByReplacingOccurrencesOfString:@" "
                       withString:@""];
    NSLog(@"%@", token);
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveRedBadgeValue" object:nil];
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
#if TARGET_IPHONE_SIMULATOR
    // 模拟器不能使用远程推送
#else
    
    NSLog(@"获取DeviceToken失败！！！");
    NSLog(@"ERROR：%@", error);
#endif
    
}

//推送处理4
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    /**
     * 统计推送打开率2
     */
    [[RCIMClient sharedRCIMClient] recordRemoteNotificationEvent:userInfo];
    /**
     * 获取融云推送服务扩展字段2
     */
    NSDictionary *pushServiceData = [[RCIMClient sharedRCIMClient] getPushExtraFromRemoteNotification:userInfo];
    if (pushServiceData) {
        NSLog(@"该远程推送包含来自融云的推送服务");
        for (id key in [pushServiceData allKeys]) {
            NSLog(@"key = %@, value = %@", key, pushServiceData[key]);
        }
    } else {
        NSLog(@"该远程推送不包含来自融云的推送服务");
    }
    
    
//    //应用图标上的
//    UIUserNotificationSettings *settings = [UIUserNotificationSettings
//
//                                            settingsForTypes:UIUserNotificationTypeBadge categories:nil];
//
//    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
//    [UIApplication sharedApplication].applicationIconBadgeNumber += 1;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
//    //统计推送打开率3
//    [[RCIMClient sharedRCIMClient] recordRemoteNotificationEvent:notification];
    NSLog(@"123456");
//    LKSessionViewController *vc = [[LKSessionViewController alloc] init];
//    UINavigationController *navi = [[UINavigationController alloc] init];
//    [navi pushViewController:vc animated:YES];
}

#pragma mark AliPay
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];

        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url options:annotation];
    if (result) {
        return result;
    }

    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result1 = %@",resultDic);
            if (self.appDelegate && [self.appDelegate respondsToSelector:@selector(successDinDanView:)]) {
                [self.appDelegate successDinDanView:resultDic];
            }
        }];

        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result2 = %@",resultDic);
            if (self.appDelegate && [self.appDelegate respondsToSelector:@selector(successDinDanView:)]) {
                [self.appDelegate successDinDanView:resultDic];
            }
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }

    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url options:options];
    if (result) {
        return result;
    }

    //微信支付完成后，点返回商家走这个方法
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    
}
#pragma mark WeChatPay
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//    设置微信WXApi的代理是当前控制器
//    return [WXApi handleOpenURL:url delegate:self];
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}
// 进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application {
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"itemClickLoad" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"forcedUpdate" object:nil];
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time = [date timeIntervalSince1970];
    NSLog(@"%.3f", time);
    _starTimeStr = [NSString stringWithFormat:@"%.0f", time*1000];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time = [date timeIntervalSince1970];
    NSLog(@"%.3f", time);
    _endTimeStr = [NSString stringWithFormat:@"%.0f", time*1000];
    
    [self requestUserStayTimeInApp];
}

- (void)requestUserStayTimeInApp {
//    NSLog(@"%@==%@", _starTimeStr, _endTimeStr);
    if (![CommentTool isBlankString:[UserInfo sharedInstance].getUserid]) {
        NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"startTime" : _starTimeStr, @"endTime" : _endTimeStr};
        [SCNetwork postWithURLString:BDUrl_s(@"log/recordLog") parameters:paramet success:^(NSDictionary *dic) {
            
        } failure:^(NSError *error) {
            [SVProgressHUD showWithStatus:@"网络请求失败"];
            [SVProgressHUD dismissWithDelay:0.7];
        }];
    }
    
    
}

- (void)getLocalTimeStamp {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time = [date timeIntervalSince1970];
    NSLog(@"%.0f", time);
}

@end
