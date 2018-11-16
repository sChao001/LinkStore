//
//  MsgloginViewController.m
//  Link
//
//  Created by Surdot on 2018/5/17.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "MsgloginViewController.h"

@interface MsgloginViewController ()
{
    int count;
}
@property (nonatomic, strong) RCUserInfo *currentUserInfo;
@property (nonatomic, strong) UIImageView *bavkgroundImg;
@property (nonatomic, strong) UIView *lineViewOne;
@property (nonatomic, strong) UITextField *mobile;
@property (nonatomic, strong) UIView *lineViewTwo;
@property (nonatomic, strong) UITextField *password;
@property (nonatomic, strong) UITextField *messageTextField;
@property (nonatomic, strong) UIButton *sendMessageBtn;
@property (nonatomic, strong) UIButton *signUpBtn;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIButton *nextBtn;
@end

@implementation MsgloginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configLayoutOfView];
    [self creatMyAlertlabel];
    count = 0;
    [self setCommonLeftBarButtonItem];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_timer invalidate];
    _timer = nil;
}

- (void)configLayoutOfView {
    _bavkgroundImg = [[UIImageView alloc] init];
    [self.view addSubview:_bavkgroundImg];
    self.bavkgroundImg.frame = self.view.bounds;
    _bavkgroundImg.image = [UIImage imageNamed:@"loginBackgrounds"];
    
    _lineViewOne = [[UIView alloc] init];
    [self.view addSubview:_lineViewOne];
    [_lineViewOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kHeightScale(189));
        make.left.mas_equalTo(kWidthScale(45));
        make.right.mas_equalTo(kWidthScale(-45));
        make.height.mas_equalTo(1);
    }];
    _lineViewOne.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    
    _mobile = [[UITextField alloc] init];
    [self.view addSubview:_mobile];
    [_mobile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lineViewOne.mas_left).mas_equalTo(5);
        make.right.mas_equalTo(self.lineViewOne.mas_right);
        make.height.mas_equalTo(kWidthScale(32));
        make.bottom.mas_equalTo(self.lineViewOne.mas_top);
    }];
    _mobile.font = [UIFont systemFontOfSize:17];
    // 设置placeholder的字体颜色和大小
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入您的手机号" attributes:
                                      @{NSForegroundColorAttributeName:RGBA(255, 255, 255, 0.6),
                                        NSFontAttributeName:_mobile.font
                                        }];
    _mobile.attributedPlaceholder = attrString;
    _mobile.keyboardType = UIKeyboardTypeNumberPad;
    _mobile.textColor = [UIColor whiteColor];
    
    _lineViewTwo = [[UIView alloc] init];
    [self.view addSubview:_lineViewTwo];
    [_lineViewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineViewOne.mas_bottom).mas_equalTo(kWidthScale(62));
        make.left.mas_equalTo(self.lineViewOne.mas_left);
        make.right.mas_equalTo(self.lineViewOne.mas_right);
        make.height.mas_equalTo(1);
    }];
    _lineViewTwo.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    
    _sendMessageBtn = [[UIButton alloc] init];
    [self.view addSubview:_sendMessageBtn];
    [_sendMessageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.lineViewTwo.mas_right);
        make.height.mas_equalTo(kWidthScale(28));
        make.width.mas_equalTo(kWidthScale(78));
        make.bottom.mas_equalTo(self.lineViewTwo.mas_top).mas_equalTo(-2);
    }];
    _sendMessageBtn.titleLabel.font = [UIFont systemFontOfSize:kWidthScale(14)];
    [_sendMessageBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_sendMessageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _sendMessageBtn.backgroundColor = RGB(3, 163, 219);
    _sendMessageBtn.layer.cornerRadius = 2;
    _sendMessageBtn.layer.masksToBounds = YES;
    [_sendMessageBtn addTarget:self action:@selector(sendMessageBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    _messageTextField = [[UITextField alloc] init];
    [self.view addSubview:_messageTextField];
    [_messageTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lineViewTwo.mas_left).mas_equalTo(5);
        make.right.mas_equalTo(self.sendMessageBtn.mas_left);
        make.height.mas_equalTo(kWidthScale(32));
        make.bottom.mas_equalTo(self.lineViewTwo.mas_top);
    }];
    _messageTextField.font = [UIFont systemFontOfSize:17];
    // 设置placeholder的字体颜色和大小
    NSAttributedString *attrStringMess = [[NSAttributedString alloc] initWithString:@"请填入验证码" attributes:
                                          @{NSForegroundColorAttributeName:RGBA(255, 255, 255, 0.6),
                                            NSFontAttributeName:_messageTextField.font
                                            }];
    _messageTextField.attributedPlaceholder = attrStringMess;
    _messageTextField.keyboardType = UIKeyboardTypeNumberPad;
    _messageTextField.textColor = [UIColor whiteColor];
    
    _nextBtn = [[UIButton alloc] init];
    [self.view addSubview:_nextBtn];
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthScale(45));
        make.right.mas_equalTo(kWidthScale(-45));
        make.bottom.mas_equalTo(kWidthScale(-123));
        make.height.mas_equalTo(kWidthScale(54));
    }];
    [_nextBtn setTitle:@"快捷登录" forState:UIControlStateNormal];
    [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:kWidthScale(21)];
    _nextBtn.backgroundColor = ColorHex(@"f5b840");
    [_nextBtn addTarget:self action:@selector(nextBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _nextBtn.layer.cornerRadius = kWidthScale(27);
    _nextBtn.layer.masksToBounds = YES;
}

//点击发送验证码按钮
- (void)sendMessageBtnClicked:(UIButton *)sender {
    NSLog(@"%@", _mobile.text);
    if (_mobile.text.length != 11) {
        [self alertShowWithTitle:@"请输入正确手机号"];
    }else {
        if (count < 1) {
            count = 60;
            NSLog(@"%@", _mobile.text);
            NSDictionary *paramet = @{@"mobile" : _mobile.text, @"sign" : BD_SIGN};
            [SCNetwork postWithURLString:BDUrl_c(@"sendSms/send") parameters:paramet success:^(NSDictionary *dic) {
                if ([dic[@"code"] integerValue] > 0) {
                    NSLog(@"请求成功%@, result: %@", dic[@"code"], dic[@"ressult"]);
                    sender.userInteractionEnabled = NO;
                    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timekeeping) userInfo:nil repeats:YES];
                    [self alertShowWithTitle: dic[@"result"]];
                }else {
                    [self alertShowWithTitle:@"发送验证码失败"];
                }
            } failure:^(NSError *error) {
                [self alertShowWithTitle:@"网络连接失败，请检查网络"];
            }];
        }
    }
}

- (void)timekeeping {
    count--;
    if (count <= 0) {
        self.sendMessageBtn.userInteractionEnabled = YES;
        [_timer invalidate];
        _timer = nil;
        [self.sendMessageBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.sendMessageBtn.backgroundColor = RGB(3, 163, 219);
    }else {
        [self.sendMessageBtn setTitle:[NSString stringWithFormat:@"%ds后获取",count] forState:UIControlStateNormal];
        self.sendMessageBtn.backgroundColor = RGB(200, 200, 200);
    }
}
- (void)nextBtnClicked:(UIButton *)sender {
    NSLog(@"%@___%@", _mobile.text, _messageTextField.text);
    NSDictionary *paramet = @{@"account" : _mobile.text, @"mobileCode" : _messageTextField.text, @"sign" : BD_SIGN};
    [SCNetwork postWithURLString:BDUrl_c(@"login/quicklogin") parameters:paramet success:^(NSDictionary *dic) {
        [self alertShowWithTitle:@"登录中..."];
        NSLog(@"%@", dic);
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"dic:%@", dic);
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

#pragma mark - 保存用户信息，上传token
- (void)saveUser:(NSDictionary *)user {
    NSLog(@"用户登录信息%@", user);
    [[UserInfo sharedInstance] initUserInfo:user];
    
    [self getRCIMLogin];
}

- (void)getRCIMLogin {
    [SVProgressHUD show];
    NSLog(@"rcId %@", [UserInfo sharedInstance].getRCtoken);
//    [[RCIM sharedRCIM] initWithAppKey:@"pwe86ga5pv916"];//开发环境
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
            LKTabBarController *tabbar = [[LKTabBarController alloc] init];
            [UIApplication sharedApplication].keyWindow.rootViewController = tabbar;
            [SVProgressHUD dismiss];
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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
