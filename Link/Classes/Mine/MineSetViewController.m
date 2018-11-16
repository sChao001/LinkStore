//
//  MineSetViewController.m
//  Link
//
//  Created by Surdot on 2018/7/31.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "MineSetViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"

@interface MineSetViewController ()
@property (nonatomic, strong) RImagButton *clearBtn;
@property (nonatomic, strong) UILabel *cacheLb;
@property (nonatomic, strong) RImagButton *changeBtn;
@property (nonatomic, strong) RImagButton *logoutBtn;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, copy) NSString * clearCacheName;
@end

@implementation MineSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.clearCacheName = @"0.0K";
    self.view.backgroundColor = ColorHex(@"f5f5f2");
    [self setCommonLeftBarButtonItem];
    [self setMyNavigationBarShowOfImage];
    [self setLayoutOfView];
    [self folderSize];
}

- (void)setLayoutOfView {
    _clearBtn = [[RImagButton alloc] init];
    [self.view addSubview:_clearBtn];
    [_clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(8);
        make.top.equalTo(13 + LK_iPhoneXNavHeight);
        make.right.equalTo(-8);
        make.height.equalTo(45);
    }];
    _clearBtn.backgroundColor = [UIColor whiteColor];
    _clearBtn.titleRect = CGRectMake(26, 16, 60, 13);
    _clearBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_clearBtn setTitle:@"清除缓存" forState:UIControlStateNormal];
    _clearBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_clearBtn setTitleColor:ColorHex(@"666666") forState:UIControlStateNormal];
    [_clearBtn addTarget:self action:@selector(clearTmpPics) forControlEvents:UIControlEventTouchUpInside];
    
    _cacheLb = [[UILabel alloc] init];
    [_clearBtn addSubview:_cacheLb];
    [_cacheLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(0);
        make.width.equalTo(60);
    }];
//    _cacheLb.backgroundColor = [UIColor redColor];
    _cacheLb.text = _clearCacheName;
    _cacheLb.textColor = RGB(102, 102, 102);
    _cacheLb.font = [UIFont systemFontOfSize:12];
    _cacheLb.textAlignment = NSTextAlignmentCenter;
    
    _changeBtn = [[RImagButton alloc] init];
    [self.view addSubview:_changeBtn];
    [_changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(8);
        make.top.equalTo(self.clearBtn.mas_bottom).equalTo(13);
        make.right.equalTo(-8);
        make.height.equalTo(45);
    }];
    _changeBtn.backgroundColor = [UIColor whiteColor];
    _changeBtn.titleRect = CGRectMake(26, 16, 60, 13);
    _changeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_changeBtn setTitle:@"切换身份" forState:UIControlStateNormal];
    _changeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_changeBtn setTitleColor:ColorHex(@"666666") forState:UIControlStateNormal];
    [_changeBtn addTarget:self action:@selector(requestMerchantsTureOrflase) forControlEvents:UIControlEventTouchUpInside];
    
    _logoutBtn = [[RImagButton alloc] init];
    [self.view addSubview:_logoutBtn];
    [_logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(8);
        make.top.equalTo(self.changeBtn.mas_bottom);
        make.right.equalTo(-8);
        make.height.equalTo(45);
    }];
    _logoutBtn.backgroundColor = [UIColor whiteColor];
    _logoutBtn.titleRect = CGRectMake(26, 16, 60, 13);
    _logoutBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    _logoutBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_logoutBtn setTitleColor:ColorHex(@"666666") forState:UIControlStateNormal];
    [_logoutBtn addTarget:self action:@selector(logoutClicked) forControlEvents:UIControlEventTouchUpInside];
    
    _lineView = [[UIView alloc] init];
    [_changeBtn addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.right.equalTo(-10);
        make.height.equalTo(1);
        make.bottom.equalTo(0);
    }];
    _lineView.backgroundColor = ColorHex(@"dcdcdc");
}

- (void)logoutClicked {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出登录吗" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [UserDefault setBool:NO forKey:@"SecondLogin"];
        [UserDefault setBool:NO forKey:@"isMerchants"];
        [UserDefault removeObjectForKey:k_id];
        [UserDefault removeObjectForKey:k_token];
        
        [UserDefault synchronize];
        [[RCIM sharedRCIM] disconnect]; //融云退出登录
        //LoginViewController
//        UINavigationController *naviLogin = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
//        ((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController = naviLogin;
        ((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController = [[LKTabBarController alloc] init];
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertVC addAction:sureAction];
    [alertVC addAction:cancleAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}
- (void)clicked {
    NSLog(@"123");
}

- (void)folderSize
{
    //计算检查缓存大小
    float tmpSize = [[SDImageCache sharedImageCache] getSize]/ 1024 /1024;
    NSLog(@"%f",tmpSize);
    self.clearCacheName = tmpSize >= 1?[NSString stringWithFormat:@"%.1fM",tmpSize]:
    [NSString stringWithFormat:@"%.1fK",tmpSize * 1024];
    _cacheLb.text = self.clearCacheName;
}
//清除缓存
- (void)clearTmpPics {
    KweakSelf
    NSString * message = [NSString stringWithFormat:@"您将要清空(%@)缓存文件",self.clearCacheName];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        [SVProgressHUD show];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"itemClickLoad" object:nil];
        [[SDImageCache sharedImageCache] clearMemory];
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            [weakSelf folderSize];
//            [weakSelf.tableView reloadData];
            [SVProgressHUD dismiss];
        }];
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [alert addAction:action];
    [alert addAction:cancel];
    [self showDetailViewController:alert sender:nil];
}
//切换客户端
- (void)changeBtnClicked {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要切换客户端吗" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UserDefault boolForKey:@"isMerchants"]) {
            [UserDefault setBool:NO forKey:@"isMerchants"];
            [UserDefault synchronize];
            NSLog(@"切换到用户端");
            LKTabBarController *tabbar = [[LKTabBarController alloc] init];
            [UIApplication sharedApplication].keyWindow.rootViewController = tabbar;
        }else {
            [UserDefault setBool:YES forKey:@"isMerchants"];
            [UserDefault synchronize];
            NSLog(@"切换到商家端");
            LKTabBarController *tabbar = [[LKTabBarController alloc] init];
            [UIApplication sharedApplication].keyWindow.rootViewController = tabbar;
        }
    }];
    UIAlertAction *cancleVC = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:sureAction];
    [alertVC addAction:cancleVC];
    [self presentViewController:alertVC animated:YES completion:nil];
    
}
//调用接口判断是否注册为商家
- (void)requestMerchantsTureOrflase {
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid};
    [SCNetwork postWithURLString:BDUrl_s(@"shop/getShopByUserId") parameters:paramet success:^(NSDictionary *dic) {
        NSLog(@"%@", dic);
        if ([dic[@"code"] integerValue] < 0) {
            NSLog(@"123");
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:dic[@"result"] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertVc addAction:sure];
            [self presentViewController:alertVc animated:YES completion:nil];
        }else {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要切换客户端吗" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if ([UserDefault boolForKey:@"isMerchants"]) {
                    [UserDefault setBool:NO forKey:@"isMerchants"];
                    [UserDefault synchronize];
                    NSLog(@"切换到用户端");
//                    LKTabBarController *tabbar = [[LKTabBarController alloc] init];
                    LKMyTabBarController *tabbar = [[LKMyTabBarController alloc] init];
                    [UIApplication sharedApplication].keyWindow.rootViewController = tabbar;
                }else {
                    [UserDefault setBool:YES forKey:@"isMerchants"];
                    [UserDefault synchronize];
                    NSLog(@"切换到商家端");
//                    LKTabBarController *tabbar = [[LKTabBarController alloc] init];
                    LKMyTabBarController *tabbar = [[LKMyTabBarController alloc] init];
                    [UIApplication sharedApplication].keyWindow.rootViewController = tabbar;
                }
            }];
            UIAlertAction *cancleVC = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertVC addAction:sureAction];
            [alertVC addAction:cancleVC];
            [self presentViewController:alertVC animated:YES completion:nil];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败"];
        [SVProgressHUD dismissWithDelay:0.6];
    }];
}







@end
