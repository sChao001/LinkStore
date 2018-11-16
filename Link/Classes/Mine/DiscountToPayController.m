//
//  DiscountToPayController.m
//  Link
//
//  Created by Surdot on 2018/8/6.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "DiscountToPayController.h"
#import "WXApiManager.h"

@interface DiscountToPayController () <UITextFieldDelegate, WXApiManagerDelegate>
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *inputLb;
@property (nonatomic, strong) UITextField *inputTextFd;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *actualLb;
@property (nonatomic, strong) UIButton *aliPay;
@property (nonatomic, strong) UIButton *wechatPay;
@property (nonatomic, strong) UILabel *actualLeft;
//
@property (nonatomic, strong) UIView *successView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *zhiFuTime;
@property (nonatomic, strong) UILabel *dinDanLb;
@property (nonatomic, strong) UIButton *backBtn;

@end

@implementation DiscountToPayController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ColorHex(@"f5f5f2");
    [self configLayoutOfView];
    [self setCommonLeftBarButtonItem];
    NSLog(@"%@", _discountNum);
    [IQKeyboardManager sharedManager].enable = NO;
    [self creatMyAlertlabel];
    NSLog(@"%@", _contentStr);
    [WXApiManager sharedManager].delegate = self;
}

- (void)configLayoutOfView {
    _topView = [[UIView alloc] init];
    [self.view addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(8);
        make.top.equalTo(12);
        make.right.equalTo(-8);
        make.height.equalTo(40);
    }];
    _topView.backgroundColor = [UIColor whiteColor];
    
    _inputTextFd = [[UITextField alloc] init];
    [_topView addSubview:_inputTextFd];
    [_inputTextFd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.bottom.equalTo(0);
        make.right.equalTo(-23);
    }];
    _inputTextFd.backgroundColor = [UIColor whiteColor];
    _inputTextFd.font = [UIFont systemFontOfSize:17];
    _inputTextFd.textColor = ColorHex(@"282828");
    _inputTextFd.textAlignment = NSTextAlignmentRight;
    _inputTextFd.delegate = self;
    [_inputTextFd becomeFirstResponder];
    _inputTextFd.keyboardType = UIKeyboardTypeDecimalPad;
    [_inputTextFd addTarget:self action:@selector(passConTextChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    _inputLb = [[UILabel alloc] init];
    [_inputTextFd addSubview:_inputLb];
    [_inputLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(23);
        make.top.bottom.equalTo(0);
        make.width.greaterThanOrEqualTo(10);
    }];
    _inputLb.text = @"输入付款金额";
    _inputLb.textColor = ColorHex(@"bdbdbd");
    _inputLb.font = [UIFont systemFontOfSize:13];
//    _inputLb.backgroundColor = [UIColor cyanColor];
    
    
    _bottomView = [[UIView alloc] init];
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(8);
        make.right.equalTo(-8);
        make.top.equalTo(self.inputTextFd.mas_bottom).equalTo(5);
        make.height.equalTo(40);
    }];
    _bottomView.backgroundColor = [UIColor whiteColor];
    
    _actualLb = [[UILabel alloc] init];
    [_bottomView addSubview:_actualLb];
    [_actualLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(23);
        make.right.equalTo(-80);
        make.top.bottom.equalTo(0);
    }];
    _actualLb.text = @"实际付款金额";
    _actualLb.font = [UIFont systemFontOfSize:13];
    _actualLb.textColor = ColorHex(@"bdbdbd");
    
    _aliPay = [[UIButton alloc] init];
    [self.view addSubview:_aliPay];
    [_aliPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(8);
        make.right.equalTo(-8);
        make.height.equalTo(45);
        make.top.equalTo(self.actualLb.mas_bottom).equalTo(43);
    }];
    _aliPay.backgroundColor = [UIColor whiteColor];
    [_aliPay setTitle:@"支付宝" forState:UIControlStateNormal];
    [_aliPay setTitleColor:ColorHex(@"128ee9") forState:UIControlStateNormal];
    _aliPay.titleLabel.font = [UIFont systemFontOfSize:17];
    [_aliPay addTarget:self action:@selector(toAliPay) forControlEvents:UIControlEventTouchUpInside];
    
    _wechatPay = [[UIButton alloc] init];
    [self.view addSubview:_wechatPay];
    [_wechatPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(8);
        make.right.equalTo(-8);
        make.height.equalTo(45);
        make.top.equalTo(self.aliPay.mas_bottom).equalTo(1);
    }];
    [_wechatPay setTitleColor:ColorHex(@"62b900") forState:UIControlStateNormal];
    [_wechatPay setTitle:@"微信" forState:UIControlStateNormal];
    _wechatPay.titleLabel.font = [UIFont systemFontOfSize:17];
    _wechatPay.backgroundColor = [UIColor whiteColor];
    [_wechatPay addTarget:self action:@selector(toWeChatPay) forControlEvents:UIControlEventTouchUpInside];
    
    _actualLeft = [[UILabel alloc] init];
    [_bottomView addSubview:_actualLeft];
    [_actualLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-23);
        make.width.greaterThanOrEqualTo(10);
        make.top.bottom.equalTo(0);
    }];
    _actualLeft.font = [UIFont systemFontOfSize:17];
    _actualLeft.text = @"";
    _actualLeft.textColor = ColorHex(@"282828");
    _actualLeft.textAlignment = NSTextAlignmentRight;
    
    [self configSuccessTheOderView];
}

- (void)configSuccessTheOderView {
    _successView = [[UIView alloc] init];
    _successView.frame = self.view.bounds;
    [self.view addSubview:_successView];
    _successView.backgroundColor = ColorHex(@"f5f5f2");
    _successView.hidden = YES;
    
    _imageView = [[UIImageView alloc] init];
    [_successView addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kWidthScale(46));
        make.centerX.equalTo(0);
        make.size.equalTo(CGSizeMake(kWidthScale(264/2), 263/2));
    }];
    _imageView.image = [UIImage imageNamed:@"y_dindan"];
    
    _titleLb = [[UILabel alloc] init];
    [_successView addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.width.greaterThanOrEqualTo(10);
        make.height.equalTo(17);
        make.top.equalTo(self.imageView.mas_bottom).equalTo(kWidthScale(15));
    }];
    _titleLb.text = @"订单交易成功";
    _titleLb.textColor = ColorHex(@"282828");
    _titleLb.font = [UIFont systemFontOfSize:17];
    
    _zhiFuTime = [[UILabel alloc] init];
    [_successView addSubview:_zhiFuTime];
    [_zhiFuTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLb.mas_bottom).equalTo(70);
        make.width.greaterThanOrEqualTo(10);
        make.centerX.equalTo(0);
    }];
    _zhiFuTime.text = @"支付时间：";
    _zhiFuTime.textColor = ColorHex(@"656565");
    _zhiFuTime.font = [UIFont systemFontOfSize:13];
    _zhiFuTime.textAlignment = NSTextAlignmentLeft;
    
    _dinDanLb = [[UILabel alloc] init];
    [_successView addSubview:_dinDanLb];
    [_dinDanLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.zhiFuTime.mas_bottom).equalTo(10);
        make.left.equalTo(self.zhiFuTime.mas_left);
        make.width.greaterThanOrEqualTo(10);
    }];
    _dinDanLb.text = @"订单编号：";
    _dinDanLb.textColor = ColorHex(@"656565");
    _dinDanLb.font = [UIFont systemFontOfSize:13];
    _dinDanLb.textAlignment = NSTextAlignmentLeft;
    
    _backBtn = [[UIButton alloc] init];
    [self.successView addSubview:_backBtn];
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dinDanLb.mas_bottom).equalTo(kWidthScale(64));
        make.left.equalTo(54);
        make.right.equalTo(-54);
        make.height.equalTo(kWidthScale(49));
    }];
    [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
    _backBtn.backgroundColor = ColorHex(@"fbe04c");
    _backBtn.layer.cornerRadius = kWidthScale(10);
    _backBtn.layer.masksToBounds = YES;
    _backBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [_backBtn setTitleColor:ColorHex(@"282828") forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.inputTextFd) {
        if (textField.text.length >= 8) {
            return NO;
        }
    }
    return YES;
}
-(void)passConTextChange:(UITextField *)sender{
    NSLog(@"%@",sender.text);
    if (_discountNum) {
        _actualLeft.text = [NSString stringWithFormat:@"￥%.2f", [_inputTextFd.text floatValue] * [_discountNum floatValue]];
    }else {
        _actualLeft.text = [NSString stringWithFormat:@"￥%.2f", [_inputTextFd.text floatValue]];
    }
}
#pragma mark - TextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"%@", _discountNum);
    NSLog(@"%f==%f", [_inputTextFd.text floatValue], [_discountNum floatValue]);
    if (_discountNum) {
        _actualLeft.text = [NSString stringWithFormat:@"￥%.2f", [_inputTextFd.text floatValue] * [_discountNum floatValue]];
    }else {
        _actualLeft.text = [NSString stringWithFormat:@"￥%.2f", [_inputTextFd.text floatValue]];
    }
}
- (void)toAliPay {
    //进入支付宝支付
    if ([_actualLeft.text isEqualToString:@""] || [_actualLeft.text isEqualToString:@"￥0.00"]) {
        [self alertShowWithTitle:@"请输入支付金额"];
        return;
    }
    [self requestAliPaySignData];
}
//获取支付宝支付签名
- (void)requestAliPaySignData {
    NSLog(@"%@", _actualLeft.text);
    NSString *string = [_actualLeft.text substringFromIndex:1];
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"total_fee" : string, @"content" : _contentStr};
    [SCNetwork postWithURLString:[NSString stringWithFormat:@"%@/s/alipay/pay", MAIN_URL] parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"%@", dic);
            NSString *appScheme = @"alisdkSurdot";
            [[AlipaySDK defaultService] payOrder:dic[@"info"] fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@", resultDic);
                
                if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                    NSError *error;
                    // 将json字符串转换成字典
                    NSData * getJsonData = [resultDic[@"result"] dataUsingEncoding:NSUTF8StringEncoding];
                    NSDictionary *getDic = [NSJSONSerialization JSONObjectWithData:getJsonData options:NSJSONReadingMutableContainers error:&error];
                    self.zhiFuTime.text = [NSString stringWithFormat:@"支付时间：%@", getDic[@"alipay_trade_app_pay_response"][@"timestamp"]];
                    self.dinDanLb.text = [NSString stringWithFormat:@"订单编号：%@", getDic[@"alipay_trade_app_pay_response"][@"out_trade_no"]];
                    self.successView.hidden = NO;
                    [self.inputTextFd endEditing:YES]; //
                }
            }];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
        [SVProgressHUD dismissWithDelay:0.6];
    }];
}
- (void)toWeChatPay {
    if ([_actualLeft.text isEqualToString:@""] || [_actualLeft.text isEqualToString:@"￥0.00"]) {
        [self alertShowWithTitle:@"请输入支付金额"];
        return;
    }
    if (!WXApi.isWXAppInstalled) {
        //检测手机是否安装微信，没有安装跳转appStore
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"提示" message:@"检测到您的手机未安装微信，请安装后进行支付" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString * url = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/linkmore/id414478124?mt=8"];
            //https://itunes.apple.com/cn/app/%E5%BE%AE%E4%BF%A1/id414478124?mt=8
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        }];
        [vc addAction:action];
        [self presentViewController:vc animated:YES completion:nil];
    }else {
        //进入微信支付
        [self requestWeChatPayData];
    }
}
//微信支付签名
- (void)requestWeChatPayData {
    NSString *string = [_actualLeft.text substringFromIndex:1];
    NSLog(@"%@", string);
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"content" : _contentStr, @"total_fee" : string};
    [SCNetwork postWithURLString:[NSString stringWithFormat:@"%@/s/weixinpay/weixinpay", MAIN_URL] parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"%@", dic);
            NSDictionary *listDic = dic[@"iosInfo"];
            self.zhiFuTime.text = [NSString stringWithFormat:@"支付时间：%@", [CommentTool dayWithTimeIntervalOfHours:[listDic[@"timestamp"] integerValue]]];
            self.dinDanLb.text = [NSString stringWithFormat:@"订单编号：%@", dic[@"order_no"]];
            [self wechatPay:dic[@"iosInfo"]];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
        [SVProgressHUD dismissWithDelay:0.6];
    }];
}
// 微信支付
-(void)wechatPay:(NSDictionary *)dict{
    PayReq *req             = [[PayReq alloc]init];
    req.partnerId           = dict[@"partnerid"];
    req.prepayId            = dict[@"prepayid"];
    req.nonceStr            = dict[@"noncestr"];
    req.timeStamp           = [dict[@"timestamp"] intValue];
    req.package             = dict[@"package"];
    req.sign                = dict[@"sign"];
    
    [WXApi sendReq:req];
}
- (void)backBtnClicked {
    [self leftBarItemBack];
}
- (void)leftBarItemBack {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark - wxMangerDelegate
- (void)tanSuccessDinDanView {
    self.successView.hidden = NO;
    [self.inputTextFd endEditing:YES];
}









@end
