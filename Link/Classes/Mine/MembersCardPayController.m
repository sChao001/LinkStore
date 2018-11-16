//
//  MembersCardPayController.m
//  Link
//
//  Created by Surdot on 2018/8/16.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "MembersCardPayController.h"
#import "WXApiManager.h"
#import "AppDelegate.h"

@interface MembersCardPayController () <WXApiManagerDelegate, AppDelegateOfDelegate>
@property (nonatomic, strong) UIButton *aliPay;
@property (nonatomic, strong) UIButton *wechatPay;
//
@property (nonatomic, strong) UIView *successView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *zhiFuTime;
@property (nonatomic, strong) UILabel *dinDanLb;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *topTwoView;
@property (nonatomic, strong) UILabel *coinTitleLb;
@property (nonatomic, strong) UILabel *coinNumber;
@property (nonatomic, strong) UILabel *totalPrice;
@property (nonatomic, strong) UILabel *ruleTitle;
@property (nonatomic, strong) UILabel *ruleDescribe;
@property (nonatomic, strong) UILabel *personDiscount;
@property (nonatomic, strong) UIButton *coinSureBtn;
@property (nonatomic, strong) UIButton *accountSureBtn;
@property (nonatomic, strong) NSString *discountType;
@property (nonatomic, strong) NSString *discountMoney;
@property (nonatomic, strong) NSString *finishMoney;
@end

@implementation MembersCardPayController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.discountType = @"0";
    self.discountMoney = @"0";
    self.view.backgroundColor = ColorHex(@"f5f5f2");
    [self setCommonLeftBarButtonItem];
    [self configLayoutView];
    [WXApiManager sharedManager].delegate = self;
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.appDelegate = self;
    
    NSLog(@"%@===%@", _totalFeeStr, _shopIdStr);
    NSLog(@"%@==%@==%@", _conversionRate, _gold, _realPrice);
    
//    if ([_typeId isEqualToString:@"4"]||![CommentTool isBlankString:_comId]) {
//        _topView.hidden = YES;
//        _totalPrice.hidden = YES;
//        _ruleTitle.hidden = YES;
//        _ruleDescribe.hidden = YES;
//        [_aliPay mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(30 + LK_iPhoneXNavHeight);
//        }];
//    }
    [self configSuccessTheOderView];
    if (![CommentTool isBlankString:_shopIdStr]) {
        _topView.hidden = YES;
        _ruleTitle.hidden = YES;
        _ruleDescribe.hidden = YES;

    }

}

- (void)configLayoutView {
    _topView = [[UIView alloc] init];
    [self.view addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(30+LK_iPhoneXNavHeight);
        make.left.equalTo(20);
        make.right.equalTo(-20);
        make.height.equalTo(50);
    }];
    _topView.backgroundColor = [UIColor whiteColor];
    _topView.layer.cornerRadius = 8;
    _topView.layer.masksToBounds = YES;
    
    _coinTitleLb = [[UILabel alloc] init];
    [_topView addSubview:_coinTitleLb];
    [_coinTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.centerY.equalTo(0);
        make.width.greaterThanOrEqualTo(10);
    }];
    _coinTitleLb.font = [UIFont systemFontOfSize:kWidthScale(17)];
    _coinTitleLb.text = [NSString stringWithFormat:@"金币：%@", _gold];
//    _coinTitleLb.textColor = ColorHex(@"282828");
    _coinTitleLb.textColor = ColorHex(@"989898");
    
    _coinSureBtn = [[UIButton alloc] init];
    [_topView addSubview:_coinSureBtn];
    [_coinSureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-22);
        make.size.equalTo(CGSizeMake(25, 25));
        make.centerY.equalTo(0);
    }];
    [_coinSureBtn setImage:[UIImage imageNamed:@"h_unselect"] forState:UIControlStateNormal];
    [_coinSureBtn setImage:[UIImage imageNamed:@"y_hook"] forState:UIControlStateSelected];
    [_coinSureBtn addTarget:self action:@selector(coinSureBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
//    _coinNumber = [[UILabel alloc] init];
//    [_topView addSubview:_coinNumber];
//    [_coinNumber mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(-15);
//        make.centerY.equalTo(0);
//        make.width.greaterThanOrEqualTo(10);
//    }];
//    _coinNumber.font = [UIFont systemFontOfSize:kWidthScale(17)];
//    _coinNumber.textColor = ColorHex(@"282828");
//    _coinNumber.text = _gold;
    
    _topTwoView = [[UIView alloc] init];
    [self.view addSubview:_topTwoView];
    [_topTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).equalTo(8);
        make.left.equalTo(20);
        make.right.equalTo(-20);
        make.height.equalTo(50);
    }];
    _topTwoView.backgroundColor = [UIColor whiteColor];
    _topTwoView.layer.cornerRadius = 8;
    _topTwoView.layer.masksToBounds = YES;
    
    _personDiscount = [[UILabel alloc] init];
    [_topTwoView addSubview:_personDiscount];
    [_personDiscount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.centerY.equalTo(0);
        make.width.greaterThanOrEqualTo(10);
    }];
    _personDiscount.font = [UIFont systemFontOfSize:kWidthScale(17)];
    _personDiscount.text = [NSString stringWithFormat:@"个人账户可抵：%@元", _returnMoney];
    _personDiscount.textColor = ColorHex(@"989898");
    
    _accountSureBtn = [[UIButton alloc] init];
    [_topTwoView addSubview:_accountSureBtn];
    [_accountSureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-22);
        make.size.equalTo(CGSizeMake(25, 25));
        make.centerY.equalTo(0);
    }];
//    _accountSureBtn.backgroundColor = [UIColor yellowColor];
    [_accountSureBtn setImage:[UIImage imageNamed:@"h_unselect"] forState:UIControlStateNormal];
    [_accountSureBtn setImage:[UIImage imageNamed:@"y_hook"] forState:UIControlStateSelected];
    [_accountSureBtn addTarget:self action:@selector(accountSureBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _aliPay = [[UIButton alloc] init];
    [self.view addSubview:_aliPay];
    [_aliPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(20);
        make.right.equalTo(-20);
        make.height.equalTo(45);
        make.top.equalTo(43+LK_iPhoneXNavHeight+kHeightScale(230));
    }];
    _aliPay.backgroundColor = [UIColor whiteColor];
    [_aliPay setTitle:@"支付宝" forState:UIControlStateNormal];
    [_aliPay setTitleColor:ColorHex(@"128ee9") forState:UIControlStateNormal];
    _aliPay.titleLabel.font = [UIFont systemFontOfSize:17];
    [_aliPay addTarget:self action:@selector(toAliPay) forControlEvents:UIControlEventTouchUpInside];
    _aliPay.layer.cornerRadius = 8;
    _aliPay.layer.masksToBounds = YES;
    
    _totalPrice = [[UILabel alloc] init];
    [self.view addSubview:_totalPrice];
    [_totalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-22);
        make.bottom.equalTo(self.aliPay.mas_top);
        make.width.greaterThanOrEqualTo(10);
    }];
    _totalPrice.text = [NSString stringWithFormat:@"价格：￥%@", _realPrice];
    _totalPrice.textColor = [UIColor redColor];
    _totalPrice.font = [UIFont systemFontOfSize:kWidthScale(15)];
    
    _wechatPay = [[UIButton alloc] init];
    [self.view addSubview:_wechatPay];
    [_wechatPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(20);
        make.right.equalTo(-20);
        make.height.equalTo(45);
        make.top.equalTo(self.aliPay.mas_bottom).equalTo(1);
    }];
    [_wechatPay setTitleColor:ColorHex(@"62b900") forState:UIControlStateNormal];
    [_wechatPay setTitle:@"微信" forState:UIControlStateNormal];
    _wechatPay.titleLabel.font = [UIFont systemFontOfSize:17];
    _wechatPay.backgroundColor = [UIColor whiteColor];
    [_wechatPay addTarget:self action:@selector(toWeChatPay) forControlEvents:UIControlEventTouchUpInside];
    _wechatPay.layer.cornerRadius = 8;
    _wechatPay.layer.masksToBounds = YES;
    
    _ruleTitle = [[UILabel alloc] init];
    [self.view addSubview:_ruleTitle];
    [_ruleTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-80-LK_TabbarSafeBottomMargin);
        make.centerX.equalTo(0);
        make.width.greaterThanOrEqualTo(10);
    }];
    _ruleTitle.font = [UIFont systemFontOfSize:13];
    _ruleTitle.text = @"使用规则";
    _ruleTitle.textColor = ColorHex(@"989898");
    
    _ruleDescribe = [[UILabel alloc] init];
    [self.view addSubview:_ruleDescribe];
    [_ruleDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(43);
        make.right.equalTo(-43);
        make.bottom.equalTo(-43);
    }];
    _ruleDescribe.font = [UIFont systemFontOfSize:13];
    _ruleDescribe.textColor = ColorHex(@"989898");
    _ruleDescribe.text = [NSString stringWithFormat:@"%@金币可抵扣1人民币，未满%@金币不与抵扣。", _conversionRate, _conversionRate];
    _ruleDescribe.numberOfLines = 0;
}
- (void)coinSureBtnClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        _accountSureBtn.selected = NO;
        self.totalPrice.text = [NSString stringWithFormat:@"价格：￥%.2f", [_realPrice doubleValue] - [_deduction doubleValue]];
        _discountType = @"1";
        _discountMoney = @"0";
    }else {
        self.totalPrice.text = [NSString stringWithFormat:@"价格：￥%@", _realPrice];
    }
}
- (void)accountSureBtnClicked:(UIButton *)sender {
    NSLog(@"12356");
    sender.selected = !sender.selected;
    if (sender.selected) {
        _coinSureBtn.selected = NO;
        self.totalPrice.text = [NSString stringWithFormat:@"价格：￥%.2f", [_realPrice doubleValue] - [_returnMoney doubleValue]];
        _discountType = @"2";
        if ([_returnMoney doubleValue] > [_realPrice doubleValue]) {
            _discountMoney = _realPrice;
            self.totalPrice.text = [NSString stringWithFormat:@"价格：￥0.00"];
        }else {
            _discountMoney = _returnMoney;
        }
    }else {
        self.totalPrice.text = [NSString stringWithFormat:@"价格：￥%@", _realPrice];
    }
    
}

//订单页
- (void)configSuccessTheOderView {
    _successView = [[UIView alloc] initWithFrame:CGRectMake(0, LK_iPhoneXNavHeight, ScreenW, ScreenH-LK_iPhoneXNavHeight)];
//    _successView.frame = self.view.bounds;
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
- (void)toAliPay {
    //进入支付宝支付
    [self requestAliPaySignData];
}
//获取支付宝支付签名
- (void)requestAliPaySignData {
    NSLog(@"%@, %ld", _typeId, (long)_number);
    
    if ([_typeId isEqualToString:@"4"]) {
        NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"memberId" : _typeId, @"number" : [NSString stringWithFormat:@"%ld", (long)_number]};
        [SCNetwork postWithURLString:BDUrl_s(@"alipay/pay") parameters:paramet success:^(NSDictionary *dic) {
            if ([dic[@"code"] integerValue] > 0) {
                NSLog(@"%@", dic);
                NSString *appScheme = @"alisdkSurdot";
                [[AlipaySDK defaultService] payOrder:dic[@"info"] fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                    NSLog(@"result = %@", resultDic);
                    
                    if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                        NSError *error;
                        //                     将json字符串转换成字典
                        NSData * getJsonData = [resultDic[@"result"] dataUsingEncoding:NSUTF8StringEncoding];
                        NSDictionary *getDic = [NSJSONSerialization JSONObjectWithData:getJsonData options:NSJSONReadingMutableContainers error:&error];
                        
                        self.zhiFuTime.text = [NSString stringWithFormat:@"支付时间：%@", getDic[@"alipay_trade_app_pay_response"][@"timestamp"]];
                        self.dinDanLb.text = [NSString stringWithFormat:@"订单编号：%@", getDic[@"alipay_trade_app_pay_response"][@"out_trade_no"]];
                        self.successView.hidden = NO;
                    }
                }];
            }
            
        } failure:^(NSError *error) {
            [SVProgressHUD showWithStatus:@"网络连接失败"];
            [SVProgressHUD dismissWithDelay:0.7];
        }];
    }else if (![CommentTool isBlankString:_shopIdStr]) {
        NSLog(@"%@===%@", _discountType, _discountMoney);
        NSString *string = [_totalPrice.text substringFromIndex:4];
        if ([string isEqualToString:@"0.00"]) {
            [self requestZeroMoneyOfTaocan];
        }else {
            NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"total_fee" : string, @"shopId" : _shopIdStr, @"comId" : _comId, @"deductionType" : _discountType, @"deductionMoney" : _discountMoney};
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
                        }
                    }];
                }
            } failure:^(NSError *error) {
                [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
                [SVProgressHUD dismissWithDelay:0.6];
            }];
        }
    }else {
        NSString *string = [_totalPrice.text substringFromIndex:4];
        NSLog(@"%@==%@==%@", string, _discountMoney, _discountType);
        if ([string isEqualToString:@"0.00"]) {
            [self requestZeroMoneyOfData];
        }else {
            NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"memberId" : _typeId, @"total_fee" : string, @"deductionType" : _discountType, @"deductionMoney" : _discountMoney};
            [SCNetwork postWithURLString:[NSString stringWithFormat:@"%@/s/alipay/pay", MAIN_URL] parameters:paramet success:^(NSDictionary *dic) {
                if ([dic[@"code"] integerValue] > 0) {
                    NSLog(@"%@", dic);
                    NSString *appScheme = @"alisdkSurdot";
                    [[AlipaySDK defaultService] payOrder:dic[@"info"] fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                        NSLog(@"result = %@", resultDic);
                        
                        if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                            NSError *error;
                            //                     将json字符串转换成字典
                            NSData * getJsonData = [resultDic[@"result"] dataUsingEncoding:NSUTF8StringEncoding];
                            NSDictionary *getDic = [NSJSONSerialization JSONObjectWithData:getJsonData options:NSJSONReadingMutableContainers error:&error];
                            
                            self.zhiFuTime.text = [NSString stringWithFormat:@"支付时间：%@", getDic[@"alipay_trade_app_pay_response"][@"timestamp"]];
                            self.dinDanLb.text = [NSString stringWithFormat:@"订单编号：%@", getDic[@"alipay_trade_app_pay_response"][@"out_trade_no"]];
                            self.successView.hidden = NO;
                        }
                    }];
                }
            } failure:^(NSError *error) {
                [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
                [SVProgressHUD dismissWithDelay:0.6];
            }];
        }
    }
    
}
//支付宝走AppDelegate中的代理方法
- (void)successDinDanView:(NSDictionary *)result {
    if ([result[@"resultStatus"] isEqualToString:@"9000"]) {
        NSError *error;
        //                     将json字符串转换成字典
        NSData * getJsonData = [result[@"result"] dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *getDic = [NSJSONSerialization JSONObjectWithData:getJsonData options:NSJSONReadingMutableContainers error:&error];
        
        self.zhiFuTime.text = [NSString stringWithFormat:@"支付时间：%@", getDic[@"alipay_trade_app_pay_response"][@"timestamp"]];
        self.dinDanLb.text = [NSString stringWithFormat:@"订单编号：%@", getDic[@"alipay_trade_app_pay_response"][@"out_trade_no"]];
        self.successView.hidden = NO;
    }
}
- (void)toWeChatPay {
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
    NSLog(@"%@, %ld", _typeId, (long)_number);
    NSLog(@"%@,,%@", _typeId, _realPrice);
    if ([_typeId isEqualToString:@"4"]) {
        NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"memberId" : _typeId, @"number" : [NSString stringWithFormat:@"%ld", (long)_number]};
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
    }else if (![CommentTool isBlankString:_shopIdStr]) {
        NSString *string = [_totalPrice.text substringFromIndex:4];
        NSLog(@"%@==%@", _discountMoney, _discountType);
        if ([string isEqualToString:@"0.00"]) {
            [self requestZeroMoneyOfTaocan];
        }else {
            NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"shopId" : _shopIdStr, @"total_fee" : string, @"comId" : _comId, @"deductionType" : _discountType, @"deductionMoney" : _discountMoney};
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
    }else {
        NSString *string = [_totalPrice.text substringFromIndex:4];
        NSLog(@"%@---%@--%@", string, _discountMoney, _discountType);
        if ([string isEqualToString:@"0.00"]) {
            [self requestZeroMoneyOfData];
        }else {
            NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"memberId" : _typeId, @"total_fee" : string, @"deductionType" : _discountType, @"deductionMoney" : _discountMoney};
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
    }
    
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
#pragma mark - wxMangerDelegate
- (void)tanSuccessDinDanView {
    self.successView.hidden = NO;
}
//支付金额为0调用的支付接口
- (void)requestZeroMoneyOfData {
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"memberId" : _typeId, @"deductionType" : _discountType, @"deductionMoney" : _discountMoney};
    [SCNetwork postWithURLString:BDUrl_s(@"payhistory/payByZero") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            self.successView.hidden = NO;
            NSLog(@"%@", dic);
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}
//优惠套餐
- (void)requestZeroMoneyOfTaocan {
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"shopId" : _shopIdStr, @"deductionType" : _discountType, @"deductionMoney" : _discountMoney, @"comId" : _comId};
    [SCNetwork postWithURLString:BDUrl_s(@"payhistory/payByZero") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            self.successView.hidden = NO;
            NSLog(@"%@", dic);
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}














@end
