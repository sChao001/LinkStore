//
//  SignUpViewController.m
//  Link
//
//  Created by Surdot on 2018/5/7.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "SignUpViewController.h"
#import "LoginViewController.h"
#import "SureSignUpViewController.h"
#import "LoginAgreementController.h"

@interface SignUpViewController ()
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
@property (nonatomic, strong) UIButton *agreementBtn;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) SureSignUpViewController *sureSignVC;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configLayoutSignUpView];
    count = 0;
    [self creatMyAlertlabel];
    [self setCommonLeftBarButtonItem];
    NSString *keyStr = @"nishishui20180608";
    NSString *secretStr = @"woshishui20180608p2dz";
    NSString *str3 = [NSString stringWithFormat:@"%@%@", keyStr, secretStr];
    NSString *str4 = [str3 md5String];
    NSLog(@"%@", str4);

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
    
    _sureBtn = [[UIButton alloc] init];
    [self.view addSubview:_sureBtn];
    [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthScale(51));
        make.top.mas_equalTo(self.lineViewTwo.mas_bottom).mas_equalTo(kWidthScale(21));
        make.size.mas_equalTo(CGSizeMake(kWidthScale(12), kWidthScale(12)));
    }];
    _sureBtn.backgroundColor = RGB(200, 200, 200);
    [_sureBtn setImage:[UIImage imageNamed:@"sureAgreement"] forState:UIControlStateNormal];
    [_sureBtn setImage:[UIImage imageNamed:@"eye"] forState:UIControlStateSelected];
    _sureBtn.layer.cornerRadius = kWidthScale(6);
    _sureBtn.layer.masksToBounds = YES;
    [_sureBtn addTarget:self action:@selector(sureBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    _agreementBtn = [[UIButton alloc] init];
    [self.view addSubview:_agreementBtn];
    [_agreementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.sureBtn.mas_right).mas_equalTo(kWidthScale(10));
        make.width.mas_greaterThanOrEqualTo(10);
        make.height.mas_equalTo(12);
        make.top.mas_equalTo(self.lineViewTwo.mas_bottom).mas_equalTo(kWidthScale(21));
    }];
    [_agreementBtn setTitle:@"我同意LINK用户服务协议" forState:UIControlStateNormal];
    [_agreementBtn setTitleColor:RGBA(15, 201, 244, 0.6) forState:UIControlStateNormal];
    _agreementBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_agreementBtn addTarget:self action:@selector(agreementBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    _nextBtn = [[UIButton alloc] init];
    [self.view addSubview:_nextBtn];
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthScale(45));
        make.right.mas_equalTo(kWidthScale(-45));
        make.bottom.mas_equalTo(kWidthScale(-123));
        make.height.mas_equalTo(kWidthScale(54));
    }];
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
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
                    NSLog(@"请求成功%@, result: %@", dic[@"code"], dic[@"result"]);
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
- (void)nextBtnClicked:(UIButton *)sender {
    if (_sureBtn.selected == NO) {
        NSDictionary *paramet = @{@"mobile" :_mobile.text, @"mobileCode" : _messageTextField.text, @"sign" : BD_SIGN};
        [SCNetwork postWithURLString:BDUrl_c(@"register/register") parameters:paramet success:^(NSDictionary *dic) {
            if ([dic[@"code"] integerValue] > 0) {
                NSLog(@"上传成功:%@", dic);
                self.useridStr = dic[@"userId"];
                
                self.sureSignVC = [[SureSignUpViewController alloc] init];
                self.sureSignVC.useridStr = dic[@"userId"];
                [self.navigationController pushViewController:self.sureSignVC animated:YES];
            }else {
                [self alertShowWithTitle:dic[@"result"]];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showWithStatus:@"网络连接失败，请检查网络"];
            [SVProgressHUD dismissWithDelay:0.6];
        }];
        
    }else {
        [self alertShowWithTitle:@"请同意LINK用户服务协议"];
    }
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
- (void)ddd {
    [SCNetwork postWithURLString:@"http://192.168.3.9:8888/register/register" parameters:@{@"mobile" : @"15201152914", @"mobileCode" : @"124"} success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"上传成功:%@", dic);
            self.useridStr = dic[@"userId"];
        }else {
            NSLog(@"上传失败");
        }
    } failure:^(NSError *error) {
        NSLog(@"网络连接失败");
    }];
}

#pragma mark -上传头像文件
- (void)postImageData:(NSString *)path {
    UIImage *phoneImg=[UIImage imageWithContentsOfFile:path];
    NSData *imageData = UIImageJPEGRepresentation(phoneImg, 0.5);
    NSString *imageString = [imageData base64EncodedString];
//    NSString * userID = [[UserInfo sharedInstance] getUserid];

    NSDictionary * paramet = @{@"userId" : _useridStr, @"nickName" : @"黑夜的眼", @"password" : @"666666", @"repassword" : @"666666", @"mobileCode" : @"123", @"image":imageString};

    [SCNetwork postWithURLString:@"http://192.168.3.9:8888/register/nextregister" parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"上传成功:%@", dic);
        }else {
            NSLog(@"上传失败");
        }
    } failure:^(NSError *error) {
        NSLog(@"网络连接失败");
    }];
}
//跳转用户协议
- (void)agreementBtnClicked {
    LoginAgreementController *vc = [[LoginAgreementController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


//再本地获取图片路径啊
-(NSString *)getheadPath
{
    NSString* str=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* path=[str stringByAppendingPathComponent:@"headImage.png"];
    return path;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
//图片压缩
- (NSData *)zipNSDataWithImage:(UIImage *)sourceImage{
    //进行图像尺寸的压缩
    CGSize imageSize = sourceImage.size;//取出要压缩的image尺寸
    CGFloat width = imageSize.width;    //图片宽度
    CGFloat height = imageSize.height;  //图片高度
    //1.宽高大于1280(宽高比不按照2来算，按照1来算)
    if (width>1280||height>1280) {
        if (width>height) {
            CGFloat scale = height/width;
            width = 1280;
            height = width*scale;
        }else{
            CGFloat scale = width/height;
            height = 1280;
            width = height*scale;
        }
        //2.宽大于1280高小于1280
    }else if(width>1280||height<1280){
        CGFloat scale = height/width;
        width = 1280;
        height = width*scale;
        //3.宽小于1280高大于1280
    }else if(width<1280||height>1280){
        CGFloat scale = width/height;
        height = 1280;
        width = height*scale;
        //4.宽高都小于1280
    }else{
    }
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [sourceImage drawInRect:CGRectMake(0,0,width,height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //进行图像的画面质量压缩
    NSData *data=UIImageJPEGRepresentation(newImage, 1.0);
    if (data.length>100*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(newImage, 0.7);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(newImage, 0.8);
        }else if (data.length>200*1024) {
            //0.25M-0.5M
            data=UIImageJPEGRepresentation(newImage, 0.9);
        }
    }
    return data;
}






















@end
