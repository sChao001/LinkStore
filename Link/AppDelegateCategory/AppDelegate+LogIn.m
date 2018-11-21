//
//  AppDelegate+LogIn.m
//  Link
//
//  Created by Surdot on 2018/8/6.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "AppDelegate+LogIn.h"
#import "LoginViewController.h"
#import "FakeLaunchViewController.h"
#import "GroupListModel.h"
#import "LKTabBarController.h"
#import "GuideViewController.h"
#import "LaunchADViewController.h"


@implementation AppDelegate (LogIn)

- (void)configLogInSettings {
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [RCIM sharedRCIM].userInfoDataSource = self;
    [RCIM sharedRCIM].groupInfoDataSource = self;
    
    
    //设置会话列表头像和会话页面头像
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
    [self Login];
    
//    [self requestGroupData:nil infoString:nil]; //获取群组列表所有信息
    
}

- (void)Login {
    if (![UserDefault boolForKey:@"welcomeViewDismiss"]) {
        self.window.rootViewController = [[GuideViewController alloc] init];
        [self.window makeKeyAndVisible];
    }else {
        self.window.rootViewController = [[LaunchADViewController alloc] init];
        [self.window makeKeyAndVisible];
    }
    
}

//用户信息提供者
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion {
    NSLog(@"用户信息提供者userId:%@", userId);
    RCUserInfo *user = [RCUserInfo new];
    
//    [self requestData:userId infoString:^(NSString *name, NSString *headerUrl) {
//        user.name = name;
//        user.portraitUri = headerUrl;
//        NSLog(@"666%@", headerUrl);
//    }];
    completion(user);
}
//群组信息提供者
- (void)getGroupInfoWithGroupId:(NSString *)groupId completion:(void (^)(RCGroup *))completion {
    NSLog(@"群组信息提供者groupId:%@", groupId);
    RCGroup *group = [[RCGroup alloc] init];
    
    for (int i = 0; i < self.dataArray.count; i++) {
        GroupListModel *model = self.dataArray[i];
        
        if ([groupId isEqualToString:[model.groupid stringValue]]) {
            group.groupName = model.name;
            group.portraitUri = BDUrl_(model.imageUrl);
        }
        completion(group);
    }
    
}

- (void)requestData:(NSString *)idString infoString:(void (^)(NSString *name, NSString *headerUrl))infoString{
    NSString *jmString = [NSString stringWithFormat:@"%@%@%@", BD_key, BD_secret, [UserInfo sharedInstance].getjmToken];
    //    NSString *jmToken = jmString.md5String;
    NSLog(@"%@", jmString.md5String);
    NSLog(@"哈%@", BD_MD5Sign.md5String);
    NSDictionary *paramet = @{@"userId" : [UserInfo sharedInstance].getUserid, @"selectId" : idString, @"sign" : jmString.md5String};
    [SCNetwork postWithURLString:BDUrl_s(@"user/getUser") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"个人信息请求成功dic:%@", dic);
            NSDictionary *userDic = dic[@"user"];
            infoString(userDic[@"nickName"], BDUrl_(userDic[@"headUrl"]));
        }else {
            [SVProgressHUD showWithStatus:@"请求失败"];
            [SVProgressHUD dismissWithDelay:0.7];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}
- (void)requestGroupData:(NSString *)groupId infoString:(void (^)(NSString *name, NSString *headerUrl))infoString {
    NSString *string = @"";
    if (![CommentTool isBlankString:[UserInfo sharedInstance].getUserid]) {
        string = [UserInfo sharedInstance].getUserid;
    }
    NSLog(@"%@", string);
    NSString *jmString = [NSString stringWithFormat:@"%@%@%@", BD_key, BD_secret, [UserInfo sharedInstance].getjmToken];
    NSDictionary *paramet = @{@"userId" : string, @"sign" : jmString.md5String};
    [SCNetwork postWithURLString:BDUrl_s(@"group/get") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"群组信息请求成功dic:%@", dic);
            NSArray *groupArr = dic[@"groups"];
            for (NSDictionary *groupList in groupArr) {
                GroupListModel *model = [GroupListModel alloc];
                [model setValuesForKeysWithDictionary:groupList];
                //                if ([groupId isEqualToString:[model.groupid stringValue]]) {
                //                    infoString(model.name, BDUrl_(model.imageUrl));
                //                }
                [self.dataArray addObject:model];
                //                infoString(model.name, BDUrl_(model.imageUrl));
            }
        }else {
            //            [SVProgressHUD showWithStatus:@"网络请求错误"];
            //            [SVProgressHUD dismissWithDelay:0.7];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}

/**获取系统语言*/
- (void)getSystemLanguage {
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    NSLog(@"Preferred Language:%@", preferredLang);
}

#pragma mark - RCIMConnectionStatusDelegate
//连接融云的状态
- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    NSLog(@"连接融云状态：%ld", (long)status);
    if (status == 6) {
        NSLog(@"你的账号已在其它端登录，请重新登录");
        UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        alertWindow.rootViewController = [[UIViewController alloc] init];
        alertWindow.windowLevel = UIWindowLevelAlert + 1;
        [alertWindow makeKeyAndVisible];
//
//
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"您的账号已在其它设备登录，请重新登录" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        }];
        [alertVc addAction:action];
        //显示弹框
        [alertWindow.rootViewController presentViewController:alertVc animated:YES completion:nil];

        
        [UserDefault setBool:NO forKey:@"SecondLogin"];
        [UserDefault removeObjectForKey:k_id];
        [UserDefault removeObjectForKey:k_token];
        [UserDefault synchronize];
        [[RCIM sharedRCIM] disconnect]; //融云退出登录
        ((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController = [[LKTabBarController alloc] init];
    }
}

@end
