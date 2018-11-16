//
//  AppDelegate+UMSocial.m
//  Link
//
//  Created by Surdot on 2018/8/3.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "AppDelegate+UMSocial.h"
//#import <UserNotifications/UserNotifications.h>
//#import "MerchantsReceiveController.h"
#import "MerchantsReceiveOfNotifiController.h"
#import "ShareMerchantsThreeController.h"
#import "MerchantsReceiveTwoController.h"



@implementation AppDelegate (UMSocial)
- (void)configUMSocial {
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:UM_appKey];
    //设置分享平台
    [self configUSharePlatforms];
//    NSLog(@"", [UMSocialManager]);
//    [UMSocialGlobal umSocialSDKVersion];
    NSLog(@"%@", [UMSocialGlobal umSocialSDKVersion]);
}

- (void)configUSharePlatforms {
    //微信平台
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxc14fc2456db18d30" appSecret:@"Surdotweixinzhifu201899999888888" redirectURL:nil];
    
    //微博
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3106103201" appSecret:@"b9dee962f4283d482c543005f17d9fd4" redirectURL:nil];
    
    //QQ
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1107606447" appSecret:nil redirectURL:nil];
}

//极光推送
- (void)configJPUshSetting:(NSDictionary *)launchOptions {
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:@"d5bbff3a9320578d2ad6e783"
                          channel:@"App Store"
                 apsForProduction:NO
            advertisingIdentifier:nil];
    //设置别名推送
    [JPUSHService setAlias:[UserInfo sharedInstance].getAccount completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSLog(@"%ld", (long)iResCode);
    } seq:10];
    
    
}

#pragma mark- JPUSHRegisterDelegate
//前台收到通知的代理方法
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    NSLog(@"%@", userInfo);
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}
//后台处理代理通知的方法
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    NSLog(@"%@", userInfo);
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    }
    completionHandler();  // 系统要求执行这个方法
//    MerchantsReceiveOfNotifiController *vc = [[MerchantsReceiveOfNotifiController alloc] init];
//    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
//    [self.window.rootViewController presentViewController:navi animated:YES completion:nil];
    if ([userInfo[@"type"] isEqualToString:@"2"]) {
        [UserDefault setBool:YES forKey:@"isMerchantHuoDong"];
        [UserDefault synchronize];
        ShareMerchantsThreeController *vc = [[ShareMerchantsThreeController alloc] init];
        UINavigationController *navi2 = [[UINavigationController alloc] initWithRootViewController:vc];
        vc.loadUrlStr = userInfo[@"url"];
        [self.window.rootViewController presentViewController:navi2 animated:YES completion:nil];
    }
    if ([userInfo[@"type"] isEqualToString:@"1"]) {
        [UserDefault setBool:YES forKey:@"isReceiveMoney"];
        [UserDefault synchronize];
        MerchantsReceiveTwoController *vc1 = [[MerchantsReceiveTwoController alloc] init];
        UINavigationController *navi1 = [[UINavigationController alloc] initWithRootViewController:vc1];
        [self.window.rootViewController presentViewController:navi1 animated:YES completion:nil];
    }

    
}














@end
