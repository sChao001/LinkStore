//
//  SureSignUpViewController.m
//  Link
//
//  Created by Surdot on 2018/5/16.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "SureSignUpViewController.h"
//#import "LKMyTabBarController.h"

#define iPhone5 (ScreenW == 320.f ? 2 : 0)
@interface SureSignUpViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) RCUserInfo *currentUserInfo;
@property (nonatomic, strong) UIImageView *backgroundImg;
@property (nonatomic, strong) UIButton *headerBtn;
@property (nonatomic, strong) UIImageView *nickIcon;
@property (nonatomic, strong) UIView *lineViewOne;
@property (nonatomic, strong) UITextField *nickText;
@property (nonatomic, strong) UIView *lineViewTwo;
@property (nonatomic, strong) UIImageView *passwordImg;
@property (nonatomic, strong) UITextField *password;
@property (nonatomic, strong) UIButton *signUpBtn;
@property (nonatomic, strong) RImagButton *showEyeBtn;

@end

@implementation SureSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configLayoutOfView];
    [self creatMyAlertlabel];
    NSLog(@"%@", _useridStr);
    [self setCommonLeftBarButtonItem];
}
- (void)leftBarItemBack {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"您的账号未完成注册，确定退出吗" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionSure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter]removeObserver:self];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *actionCancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:actionSure];
    [alertVC addAction:actionCancle];
    [self presentViewController:alertVC animated:YES completion:nil];
}
- (void)configLayoutOfView {
    _backgroundImg = [[UIImageView alloc] init];
    self.backgroundImg.frame = self.view.bounds;
    [self.view addSubview:_backgroundImg];
    _backgroundImg.image = [UIImage imageNamed:@"loginBackgrounds"];
    
    _headerBtn = [[UIButton alloc] init];
    [self.view addSubview:_headerBtn];
    [_headerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kHeightScale(80));
        make.size.mas_equalTo(CGSizeMake(kWidthScale(85), kWidthScale(85)));
        make.centerX.mas_equalTo(0);
    }];
    [_headerBtn setImage:[UIImage imageNamed:@"headerImg"] forState:UIControlStateNormal];
    [_headerBtn addTarget:self action:@selector(headerBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    _lineViewOne = [[UIView alloc] init];
    [self.view addSubview:_lineViewOne];
    [_lineViewOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthScale(45));
        make.right.mas_equalTo(kWidthScale(-45));
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.headerBtn.mas_bottom).mas_equalTo(89);
    }];
    _lineViewOne.backgroundColor = RGBA(255, 255, 255, 0.6);
    
    _nickIcon = [[UIImageView alloc] init];
    [self.view addSubview:_nickIcon];
    [_nickIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lineViewOne.mas_left).mas_equalTo(kWidthScale(5));
        make.size.mas_equalTo(CGSizeMake(kWidthScale(15) + iPhone5, kWidthScale(15) + iPhone5));
        make.bottom.mas_equalTo(self.lineViewOne.mas_top).mas_equalTo(kWidthScale(-9));
    }];
    _nickIcon.image = [UIImage imageNamed:@"account"];
    
    _nickText = [[UITextField alloc] init];
    [self.view addSubview:_nickText];
    [_nickText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.lineViewOne.mas_top);
        make.right.mas_equalTo(self.lineViewOne.mas_right);
        make.left.mas_equalTo(self.nickIcon.mas_right).mas_equalTo(kWidthScale(10));
        make.height.mas_equalTo(kWidthScale(32));
    }];
    _nickText.font = [UIFont systemFontOfSize:17];
    // 设置placeholder的字体颜色和大小
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请设置昵称" attributes:
                                      @{NSForegroundColorAttributeName:RGBA(255, 255, 255, 0.6),
                                        NSFontAttributeName:_nickText.font
                                        }];
    _nickText.attributedPlaceholder = attrString;
    _nickText.textColor = [UIColor whiteColor];
    
    _lineViewTwo = [[UIView alloc] init];
    [self.view addSubview:_lineViewTwo];
    [_lineViewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineViewOne.mas_bottom).mas_equalTo(kWidthScale(55));
        make.left.mas_equalTo(kWidthScale(45));
        make.right.mas_equalTo(kWidthScale(-45));
        make.height.mas_equalTo(1);
    }];
    _lineViewTwo.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    
    _passwordImg = [[UIImageView alloc] init];
    [self.view addSubview:_passwordImg];
    [_passwordImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lineViewTwo.mas_left).mas_equalTo(kWidthScale(7));
        make.size.mas_equalTo(CGSizeMake(kWidthScale(12) + iPhone5, kWidthScale(17) + iPhone5));
        make.bottom.mas_equalTo(self.lineViewTwo.mas_top).mas_equalTo(kWidthScale(-9));
    }];
    _passwordImg.image = [UIImage imageNamed:@"loginKey"];
    
    _showEyeBtn = [[RImagButton alloc] init];
    [self.view addSubview:_showEyeBtn];
    [_showEyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.lineViewTwo.mas_right);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.bottom.mas_equalTo(self.lineViewTwo.mas_top);
    }];
    [_showEyeBtn setImage:[UIImage imageNamed:@"closeEye"] forState:UIControlStateNormal];
    [_showEyeBtn setImage:[UIImage imageNamed:@"eye"] forState:UIControlStateSelected];
    _showEyeBtn.imageRect = CGRectMake((30 - kWidthScale(20)-iPhone5)/2, (30 - kWidthScale(10)-iPhone5)/2, kWidthScale(20)+iPhone5, kWidthScale(10)+iPhone5);
    [_showEyeBtn addTarget:self action:@selector(pwdTextIsShowSwitch:) forControlEvents:UIControlEventTouchUpInside];
    
    _password = [[UITextField alloc] init];
    [self.view addSubview:_password];
    [_password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.lineViewTwo.mas_top);
        make.right.mas_equalTo(self.showEyeBtn.mas_left);
        make.left.mas_equalTo(self.passwordImg.mas_right).mas_equalTo(kWidthScale(10));
        make.height.mas_equalTo(kWidthScale(32));
    }];
    _password.font = [UIFont systemFontOfSize:17];
    _password.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName: [[UIColor whiteColor] colorWithAlphaComponent:0.6], NSFontAttributeName:_password.font}];
    [_password setSecureTextEntry:YES];
    _password.textColor = [UIColor whiteColor];
    
    _signUpBtn = [[UIButton alloc] init];
    [self.view addSubview:_signUpBtn];
    [_signUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthScale(45));
        make.right.mas_equalTo(kWidthScale(-45));
        make.bottom.mas_equalTo(kWidthScale(-123));
        make.height.mas_equalTo(kWidthScale(54));
    }];
    [_signUpBtn setTitle:@"注 册" forState:UIControlStateNormal];
    [_signUpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _signUpBtn.titleLabel.font = [UIFont systemFontOfSize:kWidthScale(21)];
    _signUpBtn.backgroundColor = ColorHex(@"f5b840");
    [_signUpBtn addTarget:self action:@selector(signUpBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _signUpBtn.layer.cornerRadius = kWidthScale(27);
    _signUpBtn.layer.masksToBounds = YES;
    
}
- (void)headerBtnClicked:(UIButton *)sender {
    UIAlertController *alertSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *fromPhotoAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        imagePicker.allowsEditing = YES;
        
        imagePicker.delegate = self;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction* fromCameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault                                                             handler:^(UIAlertAction * action) {
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            
        {
            
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            
            imagePicker.delegate = self;
    
            //            imagePicker.allowsEditing = YES;
            
            imagePicker.allowsEditing = YES;
            
            imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        }
    }];
    [alertSheet addAction:cancelAction];
    
    [alertSheet addAction:fromCameraAction];
    
    [alertSheet addAction:fromPhotoAction];
    [self presentViewController:alertSheet animated:YES completion:nil];
}
//用户选择完毕 头像的选择器的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //头像
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    [self performSelector:@selector(saveImage:) withObject:img afterDelay:0.5];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"用户取消了");
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//裁剪保存头像图片
- (void)saveImage:(UIImage *)image{
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSError *error;
    NSString *path = [self getheadPath];
    BOOL success = [manager fileExistsAtPath:path];
    if (success) {
        success = [manager removeItemAtPath:path error:&error];
    }
    //将图片设置成200*200压缩图片
    UIImage *smallImage = [CommentTool scallImage:image toSize:CGSizeMake(200, 200)];
    //刷新并展示按钮上的头像
    [_headerBtn setImage:smallImage forState:UIControlStateNormal];
    //写入文件
    [UIImagePNGRepresentation(smallImage) writeToFile:path atomically:YES];
//    [self postImageData:path];
    
    //读取文件
    //    UIImage *photoImg = [UIImage imageWithContentsOfFile:path];
    //    [_headerBtn setBackgroundImage:photoImg forState:(UIControlStateNormal)];
    
}
//再本地获取图片路径啊
-(NSString *)getheadPath
{
    NSString* str=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* path=[str stringByAppendingPathComponent:@"headImage.png"];
    return path;
}
//#pragma mark -上传头像文件
//- (void)postImageData:(NSString *)path {
//    UIImage *phoneImg=[UIImage imageWithContentsOfFile:path];
//    NSData *imageData = UIImageJPEGRepresentation(phoneImg, 0.5);
//    NSString *imageString = [imageData base64EncodedString];
//    //    NSString * userID = [[UserInfo sharedInstance] getUserid];
//
//    NSDictionary * paramet = @{@"userId" : _useridStr, @"nickName" : @"黑夜的眼", @"password" : @"666666", @"repassword" : @"666666", @"mobileCode" : @"123", @"image":imageString};
//
//    [SCNetwork postWithURLString:@"http://192.168.3.9:8888/register/nextregister" parameters:paramet success:^(NSDictionary *dic) {
//        if ([dic[@"code"] integerValue] > 0) {
//            NSLog(@"上传成功:%@", dic);
//        }else {
//            NSLog(@"上传失败");
//        }
//    } failure:^(NSError *error) {
//        NSLog(@"网络连接失败");
//    }];
//}
//注册点击事件
- (void)signUpBtnClicked:(UIButton *)sender {
    if ([_nickText.text isEqualToString:@""] || [_password.text isEqualToString:@""]) {
        [self alertShowWithTitle:@"请您完善信息"];
    }else {
        NSString *path = [self getheadPath];
        UIImage *image = _headerBtn.currentImage;
        //    [self zipNSDataWithImage:image];
        //写入文件
        [UIImagePNGRepresentation(image) writeToFile:path atomically:YES];
        
        UIImage *phoneImg=[UIImage imageWithContentsOfFile:path];
        NSData *imageData = UIImageJPEGRepresentation(phoneImg, 0.5);
        NSString *imageString = [imageData base64EncodedString];
        
        NSDictionary *paramet = @{@"userId" : _useridStr, @"nickName" : _nickText.text, @"password" : _password.text, @"repassword" : _password.text, @"image" : imageString, @"sign" : BD_SIGN};
        [SCNetwork postWithURLString:BDUrl_c(@"register/nextregister") parameters:paramet success:^(NSDictionary *dic) {
            if ([dic[@"code"] integerValue] > 0) {
                NSLog(@"注册成功:%@", dic);
                NSDictionary *userList = dic[@"user"];
                [self saveUser:userList];
                [UserDefault setObject:dic[@"token"] forKey:@"jmToken"];
                [UserDefault synchronize];
            }else {
                NSLog(@"注册失败：%@", dic[@"code"]);
                [self alertShowWithTitle:dic[@"result"]];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showWithStatus:@"网络连接失败，请检查"];
            [SVProgressHUD dismissWithDelay:0.6];
        }];
    }
    
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
//    [[RCIM sharedRCIM] initWithAppKey:@"pwe86ga5pv916"];// 开发环境
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
- (void)pwdTextIsShowSwitch:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.password.secureTextEntry = NO;
    }else {
        self.password.secureTextEntry = YES;
    }
}
     















     
     
     
     
     

@end
