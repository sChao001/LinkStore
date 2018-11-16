//
//  FindPasswordViewController.m
//  Link
//
//  Created by Surdot on 2018/5/8.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "FindPasswordViewController.h"

@interface FindPasswordViewController ()
//{
//    int count;
//}
//@property (nonatomic, strong) UIImageView *mobileImg;
//@property (nonatomic, strong) UITextField *mobile;
//@property (nonatomic, strong) UIView *lineViewTwo;
//@property (nonatomic, strong) UIImageView *passwordImg;
//@property (nonatomic, strong) UITextField *password;
//@property (nonatomic, strong) UIView *lineThree;
//@property (nonatomic, strong) UIView *lineFour;
//@property (nonatomic, strong) UIImageView *surePasswordImg;
//@property (nonatomic, strong) UITextField *surePassword;
//@property (nonatomic, strong) UIView *lineFive;
//@property (nonatomic, strong) UIImageView *messageImg;
//@property (nonatomic, strong) UITextField *messageTextField;
//@property (nonatomic, strong) UIButton *sendMessageBtn;
//@property (nonatomic, strong) UIButton *completionBtn;
//@property (nonatomic, strong) NSTimer *timer;
{
    int count;
    //    NSTimer *_timer;
}
@property (nonatomic, strong) UIImageView *bavkgroundImg;
@property (nonatomic, strong) UIView *lineViewOne;
@property (nonatomic, strong) UITextField *mobile;
@property (nonatomic, strong) UIView *lineViewTwo;
@property (nonatomic, strong) UITextField *password;
@property (nonatomic, strong) UITextField *messageTextField;
@property (nonatomic, strong) UIButton *sendMessageBtn;
@property (nonatomic, strong) UIButton *signUpBtn;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UIView *lineViewThree;
@property (nonatomic, strong) UIButton *nextBtn;
@end

@implementation FindPasswordViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.view.backgroundColor = RGB(20, 110, 185);
//    [self configLayoutFindPasswordView];
//    [self creatMyAlertlabel];
//}

//- (void)configLayoutFindPasswordView {
//    _lineViewTwo = [[UIView alloc] init];
//    [self.view addSubview:_lineViewTwo];
//    [_lineViewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(kWidthScale(150));
//        make.centerX.mas_equalTo(0);
//        make.width.mas_equalTo(kWidthScale(250));
//        make.height.mas_equalTo(1);
//    }];
//    _lineViewTwo.backgroundColor = [UIColor whiteColor];
//    
//    _mobileImg = [[UIImageView alloc] init];
//    [self.view addSubview:_mobileImg];
//    [_mobileImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.lineViewTwo.mas_left).mas_equalTo(5);
//        make.size.mas_equalTo(CGSizeMake(kWidthScale(30), kWidthScale(30)));
//        make.bottom.mas_equalTo(self.lineViewTwo.mas_top).mas_equalTo(-10);
//    }];
//    _mobileImg.backgroundColor = [UIColor brownColor];
//    
//    _mobile = [[UITextField alloc] init];
//    [self.view addSubview:_mobile];
//    [_mobile mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(kWidthScale(200), kWidthScale(40)));
//        make.right.mas_equalTo(self.lineViewTwo.mas_right);
//        make.bottom.mas_equalTo(self.lineViewTwo.mas_top);
//    }];
//    _mobile.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
//    _mobile.keyboardType = UIKeyboardTypeNumberPad;
//    
//    _lineThree = [[UIView alloc] init];
//    [self.view addSubview:_lineThree];
//    [_lineThree mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.lineViewTwo.mas_bottom).mas_equalTo(kWidthScale(75));
//        make.centerX.mas_equalTo(0);
//        make.width.mas_equalTo(kWidthScale(250));
//        make.height.mas_equalTo(1);
//    }];
//    _lineThree.backgroundColor = [UIColor whiteColor];
//    
//    _passwordImg = [[UIImageView alloc] init];
//    [self.view addSubview:_passwordImg];
//    [_passwordImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.lineThree.mas_left).mas_equalTo(5);
//        make.size.mas_equalTo(CGSizeMake(kWidthScale(30), kWidthScale(30)));
//        make.bottom.mas_equalTo(self.lineThree.mas_top).mas_equalTo(-10);
//    }];
//    _passwordImg.backgroundColor = [UIColor brownColor];
//    
//    _password = [[UITextField alloc] init];
//    [self.view addSubview:_password];
//    [_password mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(kWidthScale(200), kWidthScale(40)));
//        make.right.mas_equalTo(self.lineThree.mas_right);
//        make.bottom.mas_equalTo(self.lineThree.mas_top);
//    }];
//    _password.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
//    //    _password.keyboardType = UIKeyboardTypeNamePhonePad;
//    [_password setSecureTextEntry:YES];
//    
//    _lineFour = [[UIView alloc] init];
//    [self.view addSubview:_lineFour];
//    [_lineFour mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.lineThree.mas_bottom).mas_equalTo(kWidthScale(75));
//        make.centerX.mas_equalTo(0);
//        make.width.mas_equalTo(kWidthScale(250));
//        make.height.mas_equalTo(1);
//    }];
//    _lineFour.backgroundColor = [UIColor whiteColor];
//    
//    _surePasswordImg = [[UIImageView alloc] init];
//    [self.view addSubview:_surePasswordImg];
//    [_surePasswordImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.lineFour.mas_left).mas_equalTo(5);
//        make.size.mas_equalTo(CGSizeMake(kWidthScale(30), kWidthScale(30)));
//        make.bottom.mas_equalTo(self.lineFour.mas_top).mas_equalTo(-10);
//    }];
//    _surePasswordImg.backgroundColor = [UIColor brownColor];
//    
//    _surePassword = [[UITextField alloc] init];
//    [self.view addSubview:_surePassword];
//    [_surePassword mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(kWidthScale(200), kWidthScale(40)));
//        make.right.mas_equalTo(self.lineFour.mas_right);
//        make.bottom.mas_equalTo(self.lineFour.mas_top);
//    }];
//    _surePassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"确认密码" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
//    [_surePassword setSecureTextEntry:YES];
//    
//    _lineFive = [[UIView alloc] init];
//    [self.view addSubview:_lineFive];
//    [_lineFive mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.lineFour.mas_bottom).mas_equalTo(kWidthScale(75));
//        make.centerX.mas_equalTo(0);
//        make.width.mas_equalTo(kWidthScale(250));
//        make.height.mas_equalTo(1);
//    }];
//    _lineFive.backgroundColor = [UIColor whiteColor];
//    
//    _messageImg = [[UIImageView alloc] init];
//    [self.view addSubview:_messageImg];
//    [_messageImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.lineFive.mas_left).mas_equalTo(5);
//        make.size.mas_equalTo(CGSizeMake(kWidthScale(30), kWidthScale(30)));
//        make.bottom.mas_equalTo(self.lineFive.mas_top).mas_equalTo(-10);
//    }];
//    _messageImg.backgroundColor = [UIColor brownColor];
//    
//    _sendMessageBtn = [[UIButton alloc] init];
//    [self.view addSubview:_sendMessageBtn];
//    [_sendMessageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.lineFive.mas_right);
//        make.width.mas_greaterThanOrEqualTo(50);
//        make.height.mas_equalTo(kWidthScale(30));
//        make.bottom.mas_equalTo(self.lineFive.mas_top).mas_equalTo(-5);
//    }];
//    _sendMessageBtn.backgroundColor = [UIColor grayColor];
//    [_sendMessageBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//    _sendMessageBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//    _sendMessageBtn.layer.cornerRadius = 5;
//    _sendMessageBtn.layer.masksToBounds = YES;
//    [_sendMessageBtn addTarget:self action:@selector(btnTouchDown:) forControlEvents:UIControlEventTouchUpInside];
//    
//    _messageTextField = [[UITextField alloc] init];
//    [self.view addSubview:_messageTextField];
//    [_messageTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        //        make.size.mas_equalTo(CGSizeMake(kWidthScale(150), kWidthScale(40)));
//        make.height.mas_equalTo(kWidthScale(40));
//        make.left.mas_equalTo(self.messageImg.mas_right).mas_equalTo(15);
//        make.right.mas_equalTo(self.sendMessageBtn.mas_left);
//        make.bottom.mas_equalTo(self.lineFive.mas_top);
//    }];
//    _messageTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"短信验证码" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont systemFontOfSize:13]}];
//    
//    _completionBtn = [[UIButton alloc] init];
//    [self.view addSubview:_completionBtn];
//    [_completionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.lineFive.mas_bottom).mas_equalTo(kWidthScale(70));
//        make.width.mas_equalTo(kWidthScale(250));
//        make.height.mas_equalTo(kWidthScale(40));
//        make.centerX.mas_equalTo(0);
//    }];
//    [_completionBtn setTitle:@"完 成" forState:UIControlStateNormal];
//    [_completionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    _completionBtn.layer.borderColor = [UIColor whiteColor].CGColor;
//    _completionBtn.layer.borderWidth = 1;
//    [_completionBtn addTarget:self action:@selector(completionClicked:) forControlEvents:UIControlEventTouchUpInside];
//}
//- (void)btnTouchDown:(UIButton *)sender {
//    if (_mobile.text.length != 11) {
//        [self alertShowWithTitle:@"请输入正确手机号"];
//    }
//    if (count < 1) {
//        count = 60;
//        NSDictionary *paramet = @{@"mobile" : _mobile.text};
//        [SCNetwork postWithURLString:BDUrl_(@"sendSms/send") parameters:paramet success:^(NSDictionary *dic) {
//            if ([dic[@"code"] integerValue] > 0) {
//                NSLog(@"请求成功%@, result: %@", dic[@"code"], dic[@"ressult"]);
//                sender.userInteractionEnabled = NO;
//                self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timekeeping) userInfo:nil repeats:YES];
//                [self alertShowWithTitle: dic[@"result"]];
//            }else {
//                [self alertShowWithTitle:@"发送验证码失败"];
//            }
//        } failure:^(NSError *error) {
//            [self alertShowWithTitle:@"网络连接失败，请检查网络"];
//        }];
//    }
//}
//- (void)timekeeping {
//    count--;
//    if (count <= 0) {
//        self.sendMessageBtn.userInteractionEnabled = YES;
//        [_timer invalidate];
//        _timer = nil;
//        [self.sendMessageBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//    }else {
//        [self.sendMessageBtn setTitle:[NSString stringWithFormat:@"%ds后重新获取",count] forState:UIControlStateNormal];
//    }
//}
//- (void)completionClicked:(UIButton *)sender {
//    NSDictionary *paramet = @{@"mobile" : _mobile.text, @"password" : _password.text, @"repassword" : _surePassword.text, @"mobileCode" : _messageTextField.text};
//    [SCNetwork postWithURLString:BDUrl_(@"user/forget") parameters:paramet success:^(NSDictionary *dic) {
//        if ([dic[@"code"] integerValue] > 0) {
//            [self alertShowWithTitle:dic[@"result"]];
//
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self.navigationController popViewControllerAnimated:YES];
//            });
//        }else {
//            [self alertShowWithTitle:dic[@"result"]];
//        }
//    } failure:^(NSError *error) {
//        [self alertShowWithTitle:@"网络连接失败，请重试"];
//    }];
//}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.view endEditing:YES];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configLayoutSignUpView];
    count = 0;
    [self creatMyAlertlabel];
    [self setCommonLeftBarButtonItem];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_timer invalidate];
    _timer = nil;
}
- (void)configLayoutSignUpView {
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
    
    _lineViewThree = [[UIView alloc] init];
    [self.view addSubview:_lineViewThree];
    [_lineViewThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kWidthScale(45));
        make.right.equalTo(kWidthScale(-45));
        make.height.equalTo(1);
        make.top.equalTo(self.lineViewTwo.mas_bottom).equalTo(kWidthScale(62));
    }];
    _lineViewThree.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    
    _password = [[UITextField alloc] init];
    [self.view addSubview:_password];
    [_password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lineViewThree.mas_left).equalTo(5);
        make.right.equalTo(self.lineViewThree.mas_right);
        make.height.equalTo(kWidthScale(32));
        make.bottom.equalTo(self.lineViewThree.mas_top);
    }];
    _password.font = [UIFont systemFontOfSize:17];
    // 设置placeholder的字体颜色和大小
    NSAttributedString *attrStringPass = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:
                                          @{NSForegroundColorAttributeName:RGBA(255, 255, 255, 0.6),
                                            NSFontAttributeName:_messageTextField.font
                                            }];
    _password.attributedPlaceholder = attrStringPass;
    [_password setSecureTextEntry:YES];
    _password.textColor = [UIColor whiteColor];
//    _password.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
//    _sureBtn = [[UIButton alloc] init];
//    [self.view addSubview:_sureBtn];
//    [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(kWidthScale(51));
//        make.top.mas_equalTo(self.lineViewTwo.mas_bottom).mas_equalTo(kWidthScale(21));
//        make.size.mas_equalTo(CGSizeMake(kWidthScale(12), kWidthScale(12)));
//    }];
//    _sureBtn.backgroundColor = RGB(200, 200, 200);
//    [_sureBtn setImage:[UIImage imageNamed:@"sureAgreement"] forState:UIControlStateNormal];
//    [_sureBtn setImage:[UIImage imageNamed:@"eye"] forState:UIControlStateSelected];
//    _sureBtn.layer.cornerRadius = kWidthScale(6);
//    _sureBtn.layer.masksToBounds = YES;
//    [_sureBtn addTarget:self action:@selector(sureBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//
//    _agreementBtn = [[UIButton alloc] init];
//    [self.view addSubview:_agreementBtn];
//    [_agreementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.sureBtn.mas_right).mas_equalTo(kWidthScale(10));
//        make.width.mas_greaterThanOrEqualTo(10);
//        make.height.mas_equalTo(kWidthScale(12));
//        make.top.mas_equalTo(self.lineViewTwo.mas_bottom).mas_equalTo(kWidthScale(21));
//    }];
//    [_agreementBtn setTitle:@"我同意LINK用户服务协议" forState:UIControlStateNormal];
//    [_agreementBtn setTitleColor:RGBA(15, 201, 244, 0.6) forState:UIControlStateNormal];
//    _agreementBtn.titleLabel.font = [UIFont systemFontOfSize:kWidthScale(11)];
//
    _nextBtn = [[UIButton alloc] init];
    [self.view addSubview:_nextBtn];
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthScale(45));
        make.right.mas_equalTo(kWidthScale(-45));
        make.bottom.mas_equalTo(kWidthScale(-123));
        make.height.mas_equalTo(kWidthScale(54));
    }];
    [_nextBtn setTitle:@"重置密码" forState:UIControlStateNormal];
    [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:kWidthScale(21)];
    _nextBtn.backgroundColor = ColorHex(@"f5b840");
    [_nextBtn addTarget:self action:@selector(nextBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _nextBtn.layer.cornerRadius = kWidthScale(27);
    _nextBtn.layer.masksToBounds = YES;
    //    [_nextBtn addTarget:self action:@selector(ddd) forControlEvents:UIControlEventTouchUpInside];
}
//点击发送验证码按钮
- (void)sendMessageBtnClicked:(UIButton *)sender {
    if (_mobile.text.length != 11) {
        [self alertShowWithTitle:@"请输入正确手机号"];
    }else {
        if (count < 1) {
            count = 60;
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
    
    
    //    NSString *path = [self getheadPath];
    //    UIImage *image = [UIImage imageNamed:@"xitong"];
    ////    [self zipNSDataWithImage:image];
    //    //写入文件
    //    [UIImagePNGRepresentation(image) writeToFile:path atomically:YES];
    //    [self postImageData:path];
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
- (void)sureBtnClicked:(UIButton *)sender {
    self.sureBtn.selected = !self.sureBtn.selected;
    if (_sureBtn.selected) {
        _nextBtn.backgroundColor = [RGB(3, 163, 219) colorWithAlphaComponent:0.6];
    }else {
        _nextBtn.backgroundColor = RGB(3, 163, 219);
    }
}
//点击完成
- (void)nextBtnClicked:(UIButton *)sender {
    NSDictionary *paramet = @{@"mobile" : _mobile.text, @"mobileCode" : _messageTextField.text, @"password" : _password.text, @"repassword" : _password.text, @"sign" : BD_SIGN};
    [SCNetwork postWithURLString:BDUrl_c(@"user/forget") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"dic:%@", dic);
            [self alertShowWithTitle:dic[@"result"]];
        }else {
            [self alertShowWithTitle:dic[@"result"]];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}
//点击注册按钮
//- (void)registerRequest:(UIButton *)sender {
//    NSDictionary *paramet = @{@"mobile" : _mobile.text, @"nickName" : _nickNameTextField.text, @"password" : _password.text, @"repassword" : _surePassword.text, @"mobileCode" : _messageTextField.text};
//    [SCNetwork postWithURLString:BDUrl_(@"register/register") parameters:paramet success:^(NSDictionary *dic) {
//        if ([dic[@"code"] integerValue] > 0) {
//            NSLog(@"请求成功%@, result: %@", dic[@"code"], dic[@"ressult"]);
//            [self alertShowWithTitle:dic[@"result"]];
//
//            self.loginVC.accountText = self.mobile.text;
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self.navigationController popViewControllerAnimated:YES];
//            });
//
//        }else {
//            [self alertShowWithTitle:dic[@"result"]];
//        }
//    } failure:^(NSError *error) {
//        [self alertShowWithTitle:@"网络连接失败，请检查网络"];
//    }];
//}





@end
