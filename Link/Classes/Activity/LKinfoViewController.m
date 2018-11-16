//
//  LKinfoViewController.m
//  Link
//
//  Created by Surdot on 2018/4/18.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "LKinfoViewController.h"

@interface LKinfoViewController ()

@end

@implementation LKinfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(245, 245, 245);
//    [self setMyNavigationBarShowOfImage];
    [self setNavigationCustomBarView];
}

//自定义导航栏
- (void)setNavigationCustomBarView {
    [self setMyNavigationBarClear];
    _navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, LK_iPhoneXNavHeight)];
    [self.view addSubview:_navigationView];
    _navigationView.backgroundColor = [UIColor purpleColor];
}

@end
