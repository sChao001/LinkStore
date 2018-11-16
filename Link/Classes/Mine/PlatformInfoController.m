//
//  PlatformInfoController.m
//  Link
//
//  Created by Surdot on 2018/7/31.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "PlatformInfoController.h"
#import "LKUserAgreementController.h"

@interface PlatformInfoController ()
@property (nonatomic, strong) UIImageView *logoImgView;
@property (nonatomic, strong) UILabel *versionLb;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *userAgreement;
@property (nonatomic, strong) UILabel *checkVersionLb;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation PlatformInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ColorHex(@"f5f5f2");
    self.title = @"关于";
    [self setCommonLeftBarButtonItem];
    [self setMyNavigationBarShowOfImage];
    [self setLayoutOfView];
    [self requestCurrentVersion];
}

- (void)setLayoutOfView {
    _logoImgView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenW-75)/2, LK_iPhoneXNavHeight + kWidthScale(81), 75, 75)];
    [self.view addSubview:_logoImgView];
//    _logoImgView.backgroundColor = [UIColor redColor];
//    _logoImgView.layer.cornerRadius = 10;
//    _logoImgView.layer.masksToBounds = YES;
    _logoImgView.image = [UIImage imageNamed:@"AppIcon"];
    
    _versionLb = [[UILabel alloc] init];
    [self.view addSubview:_versionLb];
    [_versionLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImgView.mas_bottom).equalTo(10);
        make.centerX.equalTo(0);
    }];
    _versionLb.text = @"共享会员:1.0.0";
    _versionLb.textColor = ColorHex(@"acacac");
    _versionLb.font = [UIFont systemFontOfSize:12];
    
    _contentView = [[UIView alloc] init];
    [self.view addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(8);
        make.right.equalTo(-8);
        make.top.equalTo(self.logoImgView.mas_bottom).equalTo(kWidthScale(63));
        make.height.equalTo(100/2);
    }];
    _contentView.backgroundColor = [UIColor whiteColor];
    
    _lineView = [[UIView alloc] init];
    [_contentView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.right.equalTo(-10);
        make.top.equalTo(50);
        make.height.equalTo(1);
    }];
    _lineView.backgroundColor = ColorHex(@"dcdcdc");
    
    _userAgreement = [[UILabel alloc] init];
    [_contentView addSubview:_userAgreement];
    [_userAgreement mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(26);
        make.top.right.equalTo(0);
        make.height.equalTo(49);
    }];
    _userAgreement.text = @"用户协议";
    _userAgreement.textColor = ColorHex(@"666666");
    _userAgreement.font = [UIFont systemFontOfSize:13];
    UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userAgreementClicked)];
    [_userAgreement addGestureRecognizer:oneTap];
    _userAgreement.userInteractionEnabled = YES;
    
//    _checkVersionLb = [[UILabel alloc] init];
//    [_contentView addSubview:_checkVersionLb];
//    [_checkVersionLb mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(26);
//        make.top.equalTo(self.lineView.mas_bottom).equalTo(0);
////        make.height.equalTo(13);
//        make.bottom.right.equalTo(0);
//    }];
//    _checkVersionLb.text = @"检查新版本";
//    _checkVersionLb.textColor = ColorHex(@"666666");
//    _checkVersionLb.font = [UIFont systemFontOfSize:13];
//    UITapGestureRecognizer *twoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkVersionLbClicked)];
//    [_checkVersionLb addGestureRecognizer:twoTap];
//    _checkVersionLb.userInteractionEnabled = YES;
    
}

- (void)userAgreementClicked {
    LKUserAgreementController *vc = [[LKUserAgreementController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)checkVersionLbClicked {
    NSLog(@"6");
    [self requestVersion];
}
- (void)requestVersion {
    NSString *str = [NSString stringWithFormat:@"%@%@", BD_key, BD_secret];
    NSLog(@"%@", str.md5String);
    NSDictionary *paramet = @{@"sign" : str.md5String, @"type" : @"2"};
    [SCNetwork postWithURLString:BDUrl_c(@"version/checkVersion") parameters:paramet success:^(NSDictionary *dic) {
        NSLog(@"%@", dic);
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"%@", dic);
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            // app版本
            NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            if ([app_Version isEqualToString:@"1.1.3"]) {
                UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前是最新版本" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *actionSure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alertVc addAction:actionSure];
                [self presentViewController:alertVc animated:YES completion:nil];
                
            }else if (![dic[@"versionNumber"] isEqualToString:app_Version]) {
                UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"检查到新版本是否更新" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *actionSure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //跳转appstore
                    NSLog(@"该更新了");
                    NSString * url = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/linkmore/id1426260901?mt=8"];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
                    
                }];
                UIAlertAction *actionCancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alertVc addAction:actionSure];
                [alertVc addAction:actionCancle];
                
                [self presentViewController:alertVc animated:YES completion:nil];
            }
            
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
    
    
}
//获取app当前版本
- (void)requestCurrentVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    NSLog(@"%@", infoDictionary);
    
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"%@", app_Version);
    _versionLb.text = [NSString stringWithFormat:@"共享会员:%@", app_Version];
}







@end
