//
//  ShareMerchtsFiveController.m
//  Link
//
//  Created by Surdot on 2018/7/25.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "ShareMerchtsFiveController.h"
#import <WebKit/WebKit.h>
#import "ShareMerchantsTwoController.h"
#import "WXApiManager.h"
#import "AppDelegate.h"


@interface ShareMerchtsFiveController () <WKNavigationDelegate, WKScriptMessageHandler, WXApiManagerDelegate, AppDelegateOfDelegate>
@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) UIView *successView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *zhiFuTime;
@property (nonatomic, strong) UILabel *dinDanLb;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) NSURL *webUrl;
@end

@implementation ShareMerchtsFiveController

#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setMyNavigationBarShowOfImage];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"action"];
    //
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"pay"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"hint"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"payByZero"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"action"];
    //
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"pay"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"hint"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"payByZero"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatMyAlertlabel];
    [self configWebViewLayout];
    [self setLeftBarButtonWithNorImgName:@"y_back"];
    [self configWebViewLayout];
    [WXApiManager sharedManager].delegate = self;
    [self configSuccessTheOderView];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.appDelegate = self;
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, LK_iPhoneXNavHeight)];
    [self.view addSubview:topView];
    topView.backgroundColor = [UIColor whiteColor];
}

- (void)configWebViewLayout {
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, LK_iPhoneXNavHeight, ScreenW, ScreenH - LK_TabbarSafeBottomMargin-LK_iPhoneXNavHeight)];
    [self.view addSubview:_webView];
    _webView.navigationDelegate = self;
    _webView.scrollView.bounces = NO;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@&sign=%@&userId=%@", MAIN_URL, _loadUrlStr, BD_MD5Sign.md5String, [UserInfo sharedInstance].getUserid];
    NSLog(@"%@", urlStr);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [_webView loadRequest:request];
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    [SVProgressHUD dismissWithDelay:1];
    
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [SVProgressHUD dismiss];
    
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [SVProgressHUD showWithStatus:@"内容加载失败"];
    [SVProgressHUD dismissWithDelay:0.6];
    
}
//支付完成订单页
- (void)configSuccessTheOderView {
    _successView = [[UIView alloc]initWithFrame:CGRectMake(0, LK_iPhoneXNavHeight, ScreenW, ScreenH - LK_iPhoneXNavHeight-LK_TabbarSafeBottomMargin)];
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
- (void)backBtnClicked {
    [self leftBarItemBack];
}
#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"action"]) {
        NSLog(@"%@", message.body);
        ShareMerchantsTwoController *vc = [[ShareMerchantsTwoController alloc] init];
        vc.loadUrlStr = message.body;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([message.name isEqualToString:@"pay"]) {
        NSLog(@"%@", message.body);
        if ([message.body[@"type"] isEqualToString:@"1"]) {
//            [self toAliPayOfShopId:message.body[@"shopId"] totalFee:message.body[@"totalFee"] activityId:message.body[@"activityId"] deductionMoney:message.body[@"deductionMoney"] deductionType:@"2"];
            [self toAliPayOfShopId:message.body[@"shopId"] totalFee:message.body[@"totalFee"] activityId:message.body[@"activityId"] deductionMoney:message.body[@"deductionMoney"] deductionType:@"2" money:message.body[@"money"]];
        }
        if ([message.body[@"type"] isEqualToString:@"2"]) {
//            [self toWeChatPayOfShop:message.body[@"shopId"] totalFee:message.body[@"totalFee"] activityId:message.body[@"activityId"] deductionMoney:message.body[@"deductionMoney"] deductionType:@"2"];
            [self toWeChatPayOfShop:message.body[@"shopId"] totalFee:message.body[@"totalFee"] activityId:message.body[@"activityId"] deductionMoney:message.body[@"deductionMoney"] deductionType:@"2" money:message.body[@"money"]];
        }
    }
    if ([message.name isEqualToString:@"hint"]) {
        [self alertShowWithTitle:message.body];
    }
    if ([message.name isEqualToString:@"payByZero"]) {
        NSLog(@"%@", message.body);
        [self requestPayMoneyOfZeroActitId:message.body[@"activityId"] deductionMoney:message.body[@"deductionMoney"] deductionType:@"2" shopId:message.body[@"shopId"] money:message.body[@"money"]];
    }
    
}

- (void)toAliPayOfShopId:(NSString *)shopId totalFee:(NSString *)totalFee activityId:(NSString *)activityId deductionMoney:(NSString *)deductionMoney deductionType:(NSString *)deductionType money:(NSString *)money{
    //进入支付宝支付
//    [self requestAliPaySignData:shopId totalFee:totalFee activityId:activityId deductionMoney:deductionMoney deductionType:deductionType];
    [self requestAliPaySignData:shopId totalFee:totalFee activityId:activityId deductionMoney:deductionMoney deductionType:deductionType money:money];
    
}
//获取支付宝支付签名
- (void)requestAliPaySignData:(NSString *)shopId totalFee:(NSString *)totalFee activityId:(NSString *)activityId deductionMoney:(NSString *)deductionMoney deductionType:(NSString *)deductionType money:(NSString *)money{
    if ([totalFee isEqualToString:@"0"]) {
        [self alertShowWithTitle:@"请输入金额"];
        return;
    }
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"total_fee" : totalFee, @"shopId" : shopId, @"activityId" : activityId, @"deductionMoney" : deductionMoney, @"deductionType" : deductionType, @"money" : money};
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
//走AppDelegate中回调方法
- (void)successDinDanView:(NSDictionary *)result {
    if ([result[@"resultStatus"] isEqualToString:@"9000"]) {
        NSError *error;
        // 将json字符串转换成字典
        NSData * getJsonData = [result[@"result"] dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *getDic = [NSJSONSerialization JSONObjectWithData:getJsonData options:NSJSONReadingMutableContainers error:&error];
        
        self.zhiFuTime.text = [NSString stringWithFormat:@"支付时间：%@", getDic[@"alipay_trade_app_pay_response"][@"timestamp"]];
        self.dinDanLb.text = [NSString stringWithFormat:@"订单编号：%@", getDic[@"alipay_trade_app_pay_response"][@"out_trade_no"]];
        self.successView.hidden = NO;
    }
}
- (void)toWeChatPayOfShop:(NSString *)shopId totalFee:(NSString *)totalFee activityId:(NSString *)activityId deductionMoney:(NSString *)deductionMoney deductionType:(NSString *)deductionType money:(NSString *)money{
    NSLog(@"%@---%@", shopId, totalFee);
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
//        [self requestWeChatPayData:shopId totalFee:totalFee activityId:activityId deductionMoney:deductionMoney deductionType:deductionType];
        [self requestWeChatPayData:shopId totalFee:totalFee activityId:activityId deductionMoney:deductionMoney deductionType:deductionType money:money];
        
    }
}
//微信支付签名
- (void)requestWeChatPayData:(NSString *)shopId totalFee:(NSString *)totalFee activityId:(NSString *)activityId deductionMoney:(NSString *)deductionMoney deductionType:(NSString *)deductionType money:(NSString *)money{
    NSLog(@"%@==%@", shopId, totalFee);
    NSLog(@"%@", activityId);
    if ([totalFee isEqualToString:@"0"]) {
        [self alertShowWithTitle:@"请输入金额"];
        return;
    }
    
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"shopId" : shopId, @"total_fee" : totalFee, @"activityId" : activityId, @"deductionMoney" : deductionMoney, @"deductionType" : deductionType, @"money" : money};
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
#pragma mark - wxMangerDelegate
- (void)tanSuccessDinDanView {
    self.successView.hidden = NO;
}
//抵扣后待支付金额为0
- (void)requestPayMoneyOfZeroActitId:(NSString *)activityId deductionMoney:(NSString *)deductionMoney deductionType:(NSString *)deductionType shopId:(NSString *)shopId money:(NSString *)money{
    //    NSLog(@"", activityId, deductionType, deductionMoney)
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"activityId" : activityId, @"deductionMoney" : deductionMoney, @"deductionType" : deductionType, @"shopId" : shopId, @"money" : money};
    [SCNetwork postWithURLString:BDUrl_s(@"payhistory/payByZero") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"%@", dic);
            self.successView.hidden = NO;
            self.zhiFuTime.hidden = YES;
            self.dinDanLb.hidden = YES;
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}

















@end
