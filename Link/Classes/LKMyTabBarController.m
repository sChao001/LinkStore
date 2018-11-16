//
//  LKMyTabBarController.m
//  Link
//
//  Created by Surdot on 2018/9/7.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "LKMyTabBarController.h"
#import "LKMessageListController.h"
#import "LKinfoViewController.h"
#import "LKConnecterViewController.h"
#import "LKMineViewController.h"
#import "FrendsListViewController.h"
#import "mmmmmViewController.h"
#import "PageViewController.h"
#import "LKSharedMerchantsController.h"
#import "PersonOfLabelController.h"
#import "RCDChatListViewController.h"

#import "PersonOfHomeController.h"
#import "PrepareLoginViewController.h"
#import "SomeOneToLogInController.h"
#import "StoreingViewController.h"


@interface LKMyTabBarController () <UITabBarControllerDelegate>
@property (nonatomic, strong) LKConnecterViewController *connectVC;
@property (nonatomic, strong) PageViewController *pageVC;
@property (nonatomic, strong) LKMineViewController *mineVC;
@property (nonatomic, strong) mmmmmViewController *mmVC;
@property (nonatomic, strong) LKSharedMerchantsController *merchantsVC;
@property (nonatomic, strong) PersonOfHomeController *someOneHomeVC;
@property (nonatomic, strong) PrepareLoginViewController *prepareVC;
@property (nonatomic, strong) SomeOneToLogInController *someTologVC;
@property (nonatomic, strong) StoreingViewController *storeVC;
@end

@implementation LKMyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationController *naviHuiY = [[UINavigationController alloc] initWithRootViewController:self.merchantsVC];
    UINavigationController *naviSomeone = [[UINavigationController alloc] initWithRootViewController:self.someOneHomeVC];
    UINavigationController *naviFour = [[UINavigationController alloc] initWithRootViewController:self.mineVC];
    UINavigationController *naviMM = [[UINavigationController alloc] initWithRootViewController:self.mmVC];
    UINavigationController *naviStore = [[UINavigationController alloc] initWithRootViewController:self.storeVC];
//    UINavigationController *naaaa = [[UINavigationController alloc] initWithRootViewController:self.pageVC];
    UINavigationController *navConnectVC = [[UINavigationController alloc] initWithRootViewController:self.connectVC];
    
    self.viewControllers = @[naviHuiY, navConnectVC, naviStore, naviFour];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName : [UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor greenColor], NSFontAttributeName : [UIFont systemFontOfSize:13]} forState:UIControlStateSelected];
    [self setSelectedTitleColor:[UIColor blackColor]];
    self.delegate = self;
    //未读消息红点
    if ([[RCIMClient sharedRCIMClient] getTotalUnreadCount] > 0) {
        naviMM.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", [[RCIMClient sharedRCIMClient] getTotalUnreadCount]];
    }else {
        naviMM.tabBarItem.badgeValue = nil;
    }
    
    if ([UserDefault boolForKey:@"SecondLogin"]) {
        //监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveRedBadgeValue:) name:@"receiveRedBadgeValue" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkoutUpdateViseron) name:@"forcedUpdate" object:nil];
    }
    
    [self checkoutUpdateViseron];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self checkoutUpdateViseron];
    

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

}
- (mmmmmViewController *)mmVC {
    if (!_mmVC) {
        _mmVC = [[mmmmmViewController alloc] init];
        _mmVC.title = @"消息";
        //tabbarOne
        _mmVC.tabBarItem.image = [[UIImage imageNamed:@"t_message"]    imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _mmVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"t_messageS"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _mmVC;
}
- (PrepareLoginViewController *)prepareVC {
    if (!_prepareVC) {
        _prepareVC = [[PrepareLoginViewController alloc] init];
        _prepareVC.title = @"消息";
        _prepareVC.tabBarItem.image = [[UIImage imageNamed:@"t_message"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _prepareVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"t_messageS"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
    }
    return _prepareVC;
}
- (LKSharedMerchantsController *)merchantsVC {
    if (!_merchantsVC) {
        _merchantsVC = [[LKSharedMerchantsController alloc] init];
        _merchantsVC.title = @"活动";
        _merchantsVC.tabBarItem.image = [[UIImage imageNamed:@"t_huodong"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _merchantsVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"t_huodongS"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
    }
    return _merchantsVC;
}
- (PersonOfHomeController *)someOneHomeVC {
    if (!_someOneHomeVC) {
        _someOneHomeVC = [[PersonOfHomeController alloc] init];
        _someOneHomeVC.title = @"有人";
        _someOneHomeVC.tabBarItem.image = [[UIImage imageNamed:@"t_youren"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _someOneHomeVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"t_yourenS"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _someOneHomeVC;
}
- (SomeOneToLogInController *)someTologVC {
    if (!_someTologVC) {
        _someTologVC = [[SomeOneToLogInController alloc] init];
        _someTologVC.title = @"有人";
        _someTologVC.tabBarItem.image = [[UIImage imageNamed:@"t_youren"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _someTologVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"t_yourenS"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _someTologVC;
}

- (LKConnecterViewController *)connectVC {
    if (!_connectVC) {
        _connectVC = [[LKConnecterViewController alloc] init];
        _connectVC.title = @"知道";
        _connectVC.tabBarItem.image = [[UIImage imageNamed:@"t_zhidao"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _connectVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"t_zhidaoS"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _connectVC;
}

- (PageViewController *)pageVC {
    if (!_pageVC) {
        _pageVC = [[PageViewController alloc] init];
        _pageVC.title = @"知道";
        _pageVC.tabBarItem.image = [[UIImage imageNamed:@"t_zhidao"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _pageVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"t_zhidaoS"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _pageVC;
}

- (LKMineViewController *)mineVC {
    if (!_mineVC) {
        _mineVC = [[LKMineViewController alloc] init];
        _mineVC.title = @"我";
        _mineVC.tabBarItem.image = [[UIImage imageNamed:@"t_me"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _mineVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"t_meS"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _mineVC;
}

- (StoreingViewController *)storeVC {
    if (!_storeVC) {
        _storeVC = [[StoreingViewController alloc] init];
        _storeVC.title = @"商城";
        _storeVC.tabBarItem.image = [[UIImage imageNamed:@"T_storeing"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _storeVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"T_storeingS"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _storeVC;
}
- (void)reciveRedBadgeValue:(NSNotification *)notification {
//    NSDictionary *dic = notification.userInfo;
//    NSLog(@"%@", dic);
//    UIViewController *redVC = [self.viewControllers objectAtIndex:2];
//    [[RCIMClient sharedRCIMClient] getTotalUnreadCount];
//    NSLog(@"红点%d", [[RCIMClient sharedRCIMClient] getTotalUnreadCount]);
//    if ([[RCIMClient sharedRCIMClient] getTotalUnreadCount] == 0) {
//        redVC.tabBarItem.badgeValue = nil;
//    }else {
//        redVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", [[RCIMClient sharedRCIMClient] getTotalUnreadCount]];
//    }
}

- (void)setSelectedTitleColor:(UIColor *)color {
    //选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : color} forState:UIControlStateSelected];
}

#pragma mark - UITabarControllerDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSLog(@"%@", item.title);
    if ([item.title isEqualToString:@"活动"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"itemClickAddTime" object:nil];
    }
    if ([item.title isEqualToString:@"有人"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"threeItemClickLoad" object:nil];
    }
}
// 是否强制更新
- (void)checkoutUpdateViseron {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //    NSLog(@"%@", infoDictionary);
    
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"%@", app_Version);
    
    NSString *string = [NSString stringWithFormat:@"%@%@", BD_key, BD_secret].md5String;
    NSLog(@"%@", string);
    NSDictionary *paramet = @{@"sign" : string, @"type" : @"2"};
    [SCNetwork postWithURLString:BDUrl_c(@"version/checkVersion") parameters:paramet success:^(NSDictionary *dic) {
        NSDictionary *listDic = dic[@"version"];
        NSLog(@"%@", listDic[@"versionNumber"]);
        if (![listDic[@"versionNumber"] isEqualToString:app_Version] && [listDic[@"updateFlag"] integerValue] == 1) {
            UIAlertController *alettVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前版本存在漏洞, 为了不影响您的使用请您更新" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSString * url = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/linkmore/id1426260901?mt=8"];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
            }];
            [alettVC addAction:sure];
            [self presentViewController:alettVC animated:YES completion:nil];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
