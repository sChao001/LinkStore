//
//  AppDelegate+UMSocial.h
//  Link
//
//  Created by Surdot on 2018/8/3.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "AppDelegate.h"
#import <JPUSHService.h>
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate (UMSocial) <JPUSHRegisterDelegate>
//分享
- (void)configUMSocial;
//极光推送
- (void)configJPUshSetting:(NSDictionary *)launchOptions;
@end
