//
//  SomeOneToLogInController.m
//  Link
//
//  Created by Surdot on 2018/9/7.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "SomeOneToLogInController.h"
#import "LoginViewController.h"

@interface SomeOneToLogInController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *describeLb;
@property (nonatomic, strong) UIButton *LoginAndRegister;
@end

@implementation SomeOneToLogInController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setMyNavigationBarShowOfImage];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configLayoutOfView];
}

- (void)configLayoutOfView {
    _imageView = [[UIImageView alloc] init];
    [self.view addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(kHeightScale(230));
        make.size.equalTo(CGSizeMake(kWidthScale(80), kWidthScale(80)));
    }];
//    _imageView.backgroundColor = [UIColor blueColor];
    _imageView.layer.cornerRadius = kWidthScale(40);
    _imageView.layer.masksToBounds = YES;
    _imageView.image = [UIImage imageNamed:@"y_toLogIn"];
    
    _describeLb = [[UILabel alloc] init];
    [self.view addSubview:_describeLb];
    [_describeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
//        make.width.greaterThanOrEqualTo(10);
        make.left.equalTo(15);
        make.right.equalTo(-15);
        make.top.equalTo(self.imageView.mas_bottom).equalTo(40);
    }];
    _describeLb.text = @"您还没有登录，请登录后查看该模块帖子和发帖";
    _describeLb.textColor = ColorHex(@"989898");
    _describeLb.font = [UIFont systemFontOfSize:kWidthScale(17)];
    _describeLb.numberOfLines = 0;
    _describeLb.textAlignment = NSTextAlignmentCenter;
    
    _LoginAndRegister = [[UIButton alloc] init];
    [self.view addSubview:_LoginAndRegister];
    [_LoginAndRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(self.describeLb.mas_bottom).equalTo(80);
        make.width.equalTo(100);
        make.height.equalTo(35);
    }];
    _LoginAndRegister.backgroundColor = ColorHex(@"fac345");
    [_LoginAndRegister setTitle:@"登录/注册" forState:UIControlStateNormal];
    [_LoginAndRegister setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _LoginAndRegister.titleLabel.font = [UIFont systemFontOfSize:kWidthScale(20)];
    [_LoginAndRegister addTarget:self action:@selector(LoginAndRegisterClicked) forControlEvents:UIControlEventTouchUpInside];
}
- (void)LoginAndRegisterClicked {
    LoginViewController *vc = [[LoginViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    //    [self presentViewController:vc animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
