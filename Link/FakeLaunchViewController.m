//
//  FakeLaunchViewController.m
//  Link
//
//  Created by Surdot on 2018/6/6.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "FakeLaunchViewController.h"

@interface FakeLaunchViewController ()
@property (nonatomic, strong) RCUserInfo *currentUserInfo;
@end

@implementation FakeLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self getRCIMLogin];
}

//第二次自动登录
- (void)getRCIMLogin {
    NSLog(@"rcId %@", [UserInfo sharedInstance].getRCtoken);
    RCIMToken_environment;
    [[RCIM sharedRCIM] connectWithToken:[UserInfo sharedInstance].getRCtoken success:^(NSString *userId) {
        NSLog(@"用户 %@登录成功", userId); //userId 001
        //设置当前用户自己的名字和头像
        self.currentUserInfo = [RCUserInfo new];
        self.currentUserInfo.name = userId;
        self.currentUserInfo.portraitUri = BDUrl_([UserInfo sharedInstance].getHeadImgUrl);
        [[RCIM sharedRCIM] refreshUserInfoCache:self.currentUserInfo withUserId:[UserInfo sharedInstance].getUserid];
        
        dispatch_async(dispatch_get_main_queue(), ^{
//            LKTabBarController *tabbar = [[LKTabBarController alloc] init];
            LKMyTabBarController *tabbar = [[LKMyTabBarController alloc] init];
            [UIApplication sharedApplication].keyWindow.rootViewController = tabbar;
        });
        
    } error:^(RCConnectErrorCode status) {
        NSLog(@"错误状态 %ld", (long)status);
    } tokenIncorrect:^{
        NSLog(@"token错误");
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
