//
//  LKTabBarController.m
//  Link
//
//  Created by Surdot on 2018/4/18.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "LKTabBarController.h"
#import "LKMessageListController.h"
#import "LKinfoViewController.h"
#import "LKConnecterViewController.h"
#import "LKMineViewController.h"

@interface LKTabBarController ()
@property (nonatomic, strong) LKMessageListController *sessionVC;
@property (nonatomic, strong) LKinfoViewController *infoVC;
@property (nonatomic, strong) LKConnecterViewController *connectVC;
@property (nonatomic, strong) LKMineViewController *mineVC;

@end

@implementation LKTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationController *naviOne = [[UINavigationController alloc] initWithRootViewController:self.sessionVC];
    UINavigationController *naviTwo = [[UINavigationController alloc] initWithRootViewController:self.infoVC];
    UINavigationController *naviThree = [[UINavigationController alloc] initWithRootViewController:self.connectVC];
    UINavigationController *naviFour = [[UINavigationController alloc] initWithRootViewController:self.mineVC];
    self.viewControllers = @[naviOne, naviTwo, naviThree, naviFour];
                                      
}

- (LKMessageListController *)sessionVC {
    if (!_sessionVC) {
        _sessionVC = [[LKMessageListController alloc] init];
        _sessionVC.title = @"会话";
//        [_sessionVC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObject:[[CYTabBarConfig shared] textColor] forKey:NSForegroundColorAttributeName] forState:UIControlStateNormal];
//
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                           [UIColor redColor], NSForegroundColorAttributeName,
//                                                           nil] forState:UIControlStateNormal];
    }
    return _sessionVC;
}

- (LKinfoViewController *)infoVC {
    if (!_infoVC) {
        _infoVC = [[LKinfoViewController alloc] init];
        _infoVC.title = @"资讯";
        
    }
    return _infoVC;
}

- (LKConnecterViewController *)connectVC {
    if (!_connectVC) {
        _connectVC = [[LKConnecterViewController alloc] init];
        _connectVC.title = @"位置";
    }
    return _connectVC;
}

- (LKMineViewController *)mineVC {
    if (!_mineVC) {
        _mineVC = [[LKMineViewController alloc] init];
        _mineVC.title = @"我";
    }
    return _mineVC;
}

- (void)setTabBarItems {
    [self.viewControllers
     enumerateObjectsUsingBlock:^(__kindof UIViewController *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
         if ([obj isKindOfClass:[LKMessageListController class]]) {
             obj.tabBarItem.title = @"会话";
             obj.tabBarItem.image =
             [[UIImage imageNamed:@"icon_chat"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
             obj.tabBarItem.selectedImage =
             [[UIImage imageNamed:@"icon_chat_hover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
         } else if ([obj isKindOfClass:[LKinfoViewController class]]) {
             obj.tabBarItem.title = @"通讯录";
             obj.tabBarItem.image =
             [[UIImage imageNamed:@"contact_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
             obj.tabBarItem.selectedImage = [[UIImage imageNamed:@"contact_icon_hover"]
                                             imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
         } else if ([obj isKindOfClass:[LKConnecterViewController class]]) {
             obj.tabBarItem.title = @"发现";
             obj.tabBarItem.image =
             [[UIImage imageNamed:@"square"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
             obj.tabBarItem.selectedImage =
             [[UIImage imageNamed:@"square_hover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
         } else if ([obj isKindOfClass:[LKMineViewController class]]) {
             obj.tabBarItem.title = @"我";
             obj.tabBarItem.image =
             [[UIImage imageNamed:@"icon_me"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
             obj.tabBarItem.selectedImage =
             [[UIImage imageNamed:@"icon_me_hover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
         } else {
             NSLog(@"Unknown TabBarController");
         }
     }];
}








@end
