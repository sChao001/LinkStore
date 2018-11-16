//
//  LoginViewController.m
//  Link
//
//  Created by Surdot on 2018/4/27.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "LoginViewController.h"
#import <CoreImage/CoreImage.h>
#import "SCQRCodeScanningController.h"
#import "SignUpViewController.h"
#import "FindPasswordViewController.h"
#import "MsgloginViewController.h"
#import "UIImage+CustomColor.h"


#define iPhone5 (ScreenW == 320.f ? 2 : 0)
@interface LoginViewController () ///<RCIMUserInfoDataSource, RCIMGroupInfoDataSource>
@property (nonatomic, strong) RCUserInfo *currentUserInfo;
@property (nonatomic, strong) UIImageView *mainImgView;
@property (nonatomic, strong) UIView *mobileLine;
@property (nonatomic, strong) UIView *passwordLine;
@property (nonatomic, strong) UITextField *nickName;
@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UITextField *accout;
@property (nonatomic, strong) UIImageView *passwordImg;
@property (nonatomic, strong) UITextField *password;
@property (nonatomic, strong) UIButton *signInBtn;
@property (nonatomic, strong) UIButton *signUpBtn;
@property (nonatomic, strong) UIButton *messageLoginBtn;
@property (nonatomic, strong) UIButton *missPasswordBtn;
@property (nonatomic, strong) SignUpViewController *signVC;
@property (nonatomic, strong) FindPasswordViewController *findVC;
@property (nonatomic, strong) MsgloginViewController *msgloginVC;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(167, 167, 255);
    [self setMyNavigationBarClear];
    [self configLayout];
    [self creatMyAlertlabel];
    [self setCommonLeftBarButtonItem];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"传回来的值：%@", self.accountText);
    //注册完的账号传回登录界面
    self.accout.text = self.accountText;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}
- (void)configLayout {
    _mainImgView = [[UIImageView alloc] init];
    [self.view addSubview:_mainImgView];
    _mainImgView.frame = self.view.bounds;
    _mainImgView.backgroundColor = RGB(20, 110, 185);
    _mainImgView.image = [UIImage imageNamed:@"loginBackgrounds"];
    
    _mobileLine = [[UIView alloc] init];
    [self.view addSubview:_mobileLine];
    [_mobileLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kHeightScale(190));
        make.left.mas_equalTo(kWidthScale(45));
        make.right.mas_equalTo(kWidthScale(-45));
        make.height.mas_equalTo(1);
    }];
    _mobileLine.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    
    _iconImg = [[UIImageView alloc] init];
    [self.view addSubview:_iconImg];
    [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mobileLine.mas_left).mas_equalTo(kWidthScale(5));
        make.size.mas_equalTo(CGSizeMake(kWidthScale(15) + (iPhone5), kWidthScale(15) + (iPhone5)));
        make.bottom.mas_equalTo(self.mobileLine.mas_top).mas_equalTo(kWidthScale(-9));
    }];
    _iconImg.image = [UIImage imageNamed:@"account"];
//    UIImage *image = [UIImage imageNamed:@"account"];
//    _iconImg.image = [image imageWithColor:[UIColor blackColor]];
    
    
    
    _accout = [[UITextField alloc] init];
    [self.view addSubview:_accout];
    [_accout mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mobileLine.mas_top);
        make.right.mas_equalTo(self.mobileLine.mas_right);
        make.left.mas_equalTo(self.iconImg.mas_right).mas_equalTo(kWidthScale(10));
        make.height.mas_equalTo(kWidthScale(32));
    }];
    _accout.font = [UIFont systemFontOfSize:17];
    // 设置placeholder的字体颜色和大小
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入您的账号" attributes:
                                      @{NSForegroundColorAttributeName:RGBA(255, 255, 255, 0.6),
                                        NSFontAttributeName:_accout.font
                                        }];
    _accout.attributedPlaceholder = attrString;
    _accout.keyboardType = UIKeyboardTypeNumberPad;
    _accout.textColor = [UIColor whiteColor];
    
    _passwordLine = [[UIView alloc] init];
    [self.view addSubview:_passwordLine];
    [_passwordLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mobileLine.mas_bottom).mas_equalTo(kWidthScale(62));
        make.left.mas_equalTo(kWidthScale(45));
        make.right.mas_equalTo(kWidthScale(-45));
        make.height.mas_equalTo(1);
    }];
    _passwordLine.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    
    _passwordImg = [[UIImageView alloc] init];
    [self.view addSubview:_passwordImg];
    [_passwordImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.passwordLine.mas_left).mas_equalTo(kWidthScale(7));
        make.size.mas_equalTo(CGSizeMake(kWidthScale(12) + iPhone5, kWidthScale(17) + iPhone5));
        make.bottom.mas_equalTo(self.passwordLine.mas_top).mas_equalTo(kWidthScale(-9));
    }];
    _passwordImg.image = [UIImage imageNamed:@"loginKey"];
    
    _password = [[UITextField alloc] init];
    [self.view addSubview:_password];
    [_password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.passwordLine.mas_top);
        make.right.mas_equalTo(self.passwordLine.mas_right);
        make.left.mas_equalTo(self.passwordImg.mas_right).mas_equalTo(kWidthScale(10));
        make.height.mas_equalTo(kWidthScale(32));
    }];
    _password.font = [UIFont systemFontOfSize:17];//kw14
    _password.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName: [[UIColor whiteColor] colorWithAlphaComponent:0.6], NSFontAttributeName:_password.font}];
    [_password setSecureTextEntry:YES];
    _password.textColor = [UIColor whiteColor];
    
    _signInBtn = [[UIButton alloc] init];
    [self.view addSubview:_signInBtn];
    [_signInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordLine.mas_bottom).mas_equalTo(kWidthScale(193));
        make.left.mas_equalTo(kWidthScale(45));
        make.right.mas_equalTo(kWidthScale(-45));
        make.height.mas_equalTo(kWidthScale(54));
    }];
//    _signInBtn.backgroundColor = RGB(3, 163, 219);
    _signInBtn.backgroundColor = ColorHex(@"f5b840");
    [_signInBtn setTitle:@"登 录" forState:UIControlStateNormal];
    [_signInBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _signInBtn.titleLabel.font = [UIFont systemFontOfSize:kWidthScale(21)];
    [_signInBtn addTarget:self action:@selector(signInBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _signInBtn.layer.cornerRadius = kWidthScale(27);
    _signInBtn.layer.masksToBounds = YES;

    _signUpBtn = [[UIButton alloc] init];
    [self.view addSubview:_signUpBtn];
    [_signUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.signInBtn.mas_bottom).mas_equalTo(kWidthScale(17));
        make.height.mas_equalTo(kWidthScale(54));
        make.left.mas_equalTo(kWidthScale(45));
        make.right.mas_equalTo(kWidthScale(-45));
    }];
    [_signUpBtn setTitle:@"注 册" forState:UIControlStateNormal];
    [_signUpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _signUpBtn.titleLabel.font = [UIFont systemFontOfSize:kWidthScale(21)];
    _signUpBtn.layer.borderWidth = 1;
    _signUpBtn.layer.borderColor = ColorHex(@"f5b840").CGColor;
    [_signUpBtn addTarget:self action:@selector(pushToRegisterView:) forControlEvents:UIControlEventTouchUpInside];
    _signUpBtn.layer.cornerRadius = kWidthScale(27);
    _signUpBtn.layer.masksToBounds = YES;
    
    
    _messageLoginBtn = [[UIButton alloc] init];
    [self.view addSubview:_messageLoginBtn];
    [_messageLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthScale(54));
        make.top.mas_equalTo(self.passwordLine.mas_bottom).mas_equalTo(kWidthScale(20));
        make.height.mas_equalTo(kWidthScale(12));
        make.width.mas_greaterThanOrEqualTo(kWidthScale(10));
    }];
    [_messageLoginBtn setTitle:@"快捷登录" forState:UIControlStateNormal];
    [_messageLoginBtn setTitleColor:RGBA(255, 255, 255, 0.6) forState:UIControlStateNormal];
    _messageLoginBtn.titleLabel.font = [UIFont systemFontOfSize:14];//kw12
    [_messageLoginBtn addTarget:self action:@selector(messageLoginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    _missPasswordBtn = [[UIButton alloc] init];
    [self.view addSubview:_missPasswordBtn];
    [_missPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(kWidthScale(-45));
        make.top.mas_equalTo(self.passwordLine.mas_bottom).mas_equalTo(kWidthScale(20));
        make.height.mas_equalTo(kWidthScale(12));
        make.width.mas_greaterThanOrEqualTo(10);
    }];
    [_missPasswordBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [_missPasswordBtn setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.6] forState:UIControlStateNormal];
    _missPasswordBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_missPasswordBtn addTarget:self action:@selector(missBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    

}
//注册
- (void)pushToRegisterView:(UIButton *)sender {
    _signVC = [[SignUpViewController alloc] init];
    _signVC.loginVC = self;
    [self.navigationController pushViewController:_signVC animated:YES];
}
//点击登录按钮
- (void)signInBtnClicked:(UIButton *)sender {
//    [SVProgressHUD show];
    NSDictionary *paramet = @{@"account" : _accout.text, @"password" : _password.text, @"sign" : BD_SIGN};
    [SCNetwork postWithURLString:BDUrl_c(@"login/login") parameters:paramet success:^(NSDictionary *dic) {
//        [SVProgressHUD dismiss];
        [self alertShowWithTitle:@"登录中..."];
        if ([dic[@"code"] integerValue] > 0) {
//            [self alertShowWithTitle:@"登录成功"];
            NSDictionary *userList = dic[@"user"];
            [self saveUser:userList];
            [UserDefault setObject:userList[@"id"] forKey:@"mainId"];
            [UserDefault setObject:dic[@"token"] forKey:@"jmToken"]; //加密token
            [UserDefault synchronize];

        }else {
            [self alertShowWithTitle:dic[@"result"]];
        }
    } failure:^(NSError *error) {
        [self alertShowWithTitle:@"网络连接失败，请检查网络"];
    }];
}
//快捷登录
- (void)messageLoginBtnClicked:(UIButton *)sender {
    _msgloginVC = [[MsgloginViewController alloc] init];
    [self.navigationController pushViewController:_msgloginVC animated:YES];
}
- (void)missBtnClicked:(UIButton *)sender {
    self.findVC = [[FindPasswordViewController alloc] init];
    [self.navigationController pushViewController:_findVC animated:YES];
}

//点击空白处收起键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - 保存用户信息，上传token
- (void)saveUser:(NSDictionary *)user {
    NSLog(@"用户登录信息%@", user);
    [[UserInfo sharedInstance] initUserInfo:user];
//    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setBool:YES forKey:@"SecondLogin"];
//    [defaults synchronize];
    
    [self getRCIMLogin];
}

- (void)getRCIMLogin {
    NSLog(@"rcId %@", [UserInfo sharedInstance].getRCtoken);
//    [[RCIM sharedRCIM] initWithAppKey:@"pwe86ga5pv916"]; //开发环境
//    [[RCIM sharedRCIM] initWithAppKey:@"4z3hlwrv4o5ct"]; //生产环境
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
            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            [defaults setBool:YES forKey:@"SecondLogin"];
            [defaults synchronize];
        });
        
    } error:^(RCConnectErrorCode status) {
        NSLog(@"错误状态 %ld", (long)status);
    } tokenIncorrect:^{
        NSLog(@"token错误");
    }];
    
}

//接收消息的代理方法
//- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left {
//    NSLog(@"message:%@", message);
//}


- (void)touchDownLogin {
    //http://192.168.3.9:8080/sendSms/send 验证码url
//    NSLog(@"%@, %@, %@, %@, %@", _nickName.text, _accout.text, _message.text, _password.text, _surePassword.text);
//
//    NSDictionary *paramet = @{@"nickName" : _nickName.text, @"mobile" : _accout.text, @"mobileCode" : _message.text, @"password" : _password.text, @"repassword" : _surePassword.text};
//    //注册url
//    [SCNetwork postWithURLString:@"http://192.168.3.9:8080/register/register" parameters:paramet success:^(NSDictionary *dic) {
//        if ([dic[@"code"] integerValue] > 0) {
//            NSLog(@"请求成功%@, result:%@", dic[@"code"], dic[@"result"]);
//        }else {
//            NSLog(@"请求失败%@, result:%@", dic[@"code"], dic[@"result"]);
//        }
//
//    } failure:^(NSError *error) {
//        NSLog(@"请求失败");
//    }];
    
    //登录
    NSDictionary *paramet = @{@"account" : _accout.text, @"password" : _password.text};
    [SCNetwork postWithURLString:@"http://192.168.3.9:8080/login/login" parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"请求登录成功%@, result:%@", dic[@"code"], dic[@"result"]);
        }else {
            NSLog(@"请求登录失败%@, result:%@", dic[@"code"], dic[@"result"]);
        }
    } failure:^(NSError *error) {
        NSLog(@"请求失败%@", error);
    }];
}

- (void)sendMessage {
    NSDictionary *paramet = @{@"mobile" : _accout.text};
    [SCNetwork postWithURLString:@"http://192.168.3.9:8080/sendSms/send" parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"请求成功%@, result: %@", dic[@"code"], dic[@"ressult"]);
        }else {
            NSLog(@"请求失败%@, result:%@", dic[@"code"], dic[@"result"]);
        }
        
    } failure:^(NSError *error) {
        NSLog(@"请求失败");
    }];
}
//生成二维码
//- (void)makeQRCode {
//    //创建过滤器
//    CIFilter *filter = [CIFilter filterWithName:@"CIQCodeGenerator"];
//    //恢复默认
//    [filter setDefaults];
//    //给过滤器添加数据
//    NSString *dataString = @"https://www.baidu.com";
//    NSData *data = [dataString dataUsingEncoding:NSUnicodeStringEncoding];
//    //通过KVO设置滤镜inputMessage
//    [filter setValue:data forKeyPath:@"inputMessage"];
//    NSLog(@"%@", filter);
//    //获取二维码输出
//    CIImage *outputImage = [filter outputImage];
//    //将CIImage转换成UIImage，并放大显示
//
//    self.QRImageView.image = [UIImage imageWithCIImage:outputImage scale:20.0 orientation:UIImageOrientationUp];
//}

#pragma mark - 扫一扫加好友
- (void)jumpToQRCodeVC {
    SCQRCodeScanningController *vc = [[SCQRCodeScanningController alloc] init];
    [self QRCodeScanVC:vc];
    
}
#pragma mark - 开始扫一扫时打开相机
- (void)QRCodeScanVC:(UIViewController *)scanVC {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (status) {
            case AVAuthorizationStatusNotDetermined: {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if (granted) {
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [self.navigationController pushViewController:scanVC animated:YES];
                        });
                        NSLog(@"用户第一次同意了访问相机权限 - - %@", [NSThread currentThread]);
                    } else {
                        NSLog(@"用户第一次拒绝了访问相机权限 - - %@", [NSThread currentThread]);
                    }
                }];
                break;
            }
            case AVAuthorizationStatusAuthorized: {
                [self.navigationController pushViewController:scanVC animated:YES];
                break;
            }
            case AVAuthorizationStatusDenied: {
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请去-> [设置 - 隐私 - 相机 - SGQRCodeExample] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alertC addAction:alertA];
                [self presentViewController:alertC animated:YES completion:nil];
                break;
            }
            case AVAuthorizationStatusRestricted: {
                NSLog(@"因为系统原因, 无法访问相册");
                break;
            }
                
            default:
                break;
        }
        return;
    }
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertC addAction:alertA];
    [self presentViewController:alertC animated:YES completion:nil];
}

+ (UIImage *)generateWithDefaultQRCodeData:(NSString *)data imageViewWidth:(CGFloat)imageViewWidth {
    // 1、创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 恢复滤镜的默认属性
    [filter setDefaults];
    
    // 2、设置数据
    NSString *info = data;
    // 将字符串转换成
    NSData *infoData = [info dataUsingEncoding:NSUTF8StringEncoding];
    
    // 通过KVC设置滤镜inputMessage数据
    [filter setValue:infoData forKeyPath:@"inputMessage"];
    
    // 3、获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    
    return [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:imageViewWidth];
}

/** 根据CIImage生成指定大小的UIImage */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)signUp {
    
    _accout = [[UITextField alloc] initWithFrame:CGRectMake(80, 220, 250, 50)];
    [self.view addSubview:_accout];
    _accout.backgroundColor = [UIColor cyanColor];
    _accout.placeholder = @"请输入手机号";
    
    _password = [[UITextField alloc] initWithFrame:CGRectMake(80, 350, 250, 50)];
    [self.view addSubview:_password];
    _password.backgroundColor = [UIColor redColor];
    _password.placeholder = @"请输入密码";
    
    
}

@end
