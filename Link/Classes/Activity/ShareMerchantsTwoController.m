//
//  ShareMerchantsTwoController.m
//  Link
//
//  Created by Surdot on 2018/7/24.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "ShareMerchantsTwoController.h"
#import <WebKit/WebKit.h>
#import "ShareMerchantsThreeController.h"
#import "MembersCardPayController.h"
#import "InvitationTwoController.h"
#import "LoginViewController.h"
#import "LKSharedMerchantsController.h"
#import "LKSessionViewController.h"

@interface ShareMerchantsTwoController () <WKNavigationDelegate, WKScriptMessageHandler>
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) NSURL *webUrl;
@end

@implementation ShareMerchantsTwoController

#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self setMyNavigationBarShowOfImage];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"action"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"member"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"line"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"memberNext"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"call"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"hint"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"inviteFriends"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"contactBusiness"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"topUp"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"returnUpPage"];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self setMyNavigationBarHidden];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"action"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"member"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"line"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"memberNext"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"call"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"hint"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"inviteFriends"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"contactBusiness"];
    //
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"pay"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"topUp"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"returnUpPage"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", _loadUrlStr);
    [SVProgressHUD show];
    [self creatMyAlertlabel];
    self.view.backgroundColor = [UIColor whiteColor];

//    [self setCommonLeftBarButtonItem];
    [self configWebViewLayout];
//    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, LK_iPhoneXNavHeight)];
//    [self.view addSubview:topView];
//    topView.backgroundColor = [UIColor whiteColor];

}
- (void)leftBarItemBack {
    [SVProgressHUD dismiss];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)configWebViewLayout {
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - LK_TabbarSafeBottomMargin)];
    [self.view addSubview:_webView];
    _webView.navigationDelegate = self;
    _webView.scrollView.bounces = NO;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    
    if (![UserDefault boolForKey:@"SecondLogin"]) {
        _webUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@&sign=%@", MAIN_URL, _loadUrlStr, Un_LogInSign.md5String]];
    }else {
        _webUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@&sign=%@&userId=%@", MAIN_URL, _loadUrlStr, BD_MD5Sign.md5String, [UserInfo sharedInstance].getUserid]];
    }
    
//    NSString *urlStr = [NSString stringWithFormat:@"%@%@&sign=%@&userId=%@", MAIN_URL, _loadUrlStr, BD_MD5Sign.md5String, [UserInfo sharedInstance].getUserid];
//    NSLog(@"%@", urlStr);
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
//    [_webView loadRequest:request];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:_webUrl]];
    
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
#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if (![UserDefault boolForKey:@"SecondLogin"]) {
        LoginViewController *vc = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([message.name isEqualToString:@"action"]) {
        NSLog(@"%@", message.body);
        NSLog(@"%@", [message.body stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]);
        ShareMerchantsThreeController *vc = [[ShareMerchantsThreeController alloc] init];
        vc.loadUrlStr = [message.body stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([message.name isEqualToString:@"member"]) {
        NSLog(@"%@", message.body);
        MembersCardPayController *vc = [[MembersCardPayController alloc] init];
        vc.typeId = message.body[@"memberId"];
        vc.conversionRate = message.body[@"conversionRate"];
        vc.gold = message.body[@"gold"];
        vc.realPrice = message.body[@"realPrice"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([message.name isEqualToString:@"memberNext"]) {
        NSLog(@"%@", message.body);
        MembersCardPayController *vc = [[MembersCardPayController alloc] init];
        vc.typeId = message.body[@"memberId"];
        vc.number = [message.body[@"number"] integerValue];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([message.name isEqualToString:@"call"]) {
        NSLog(@"%@", message.body);
        //@"telprompt://%@"
        NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@", message.body];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    if ([message.name isEqualToString:@"hint"]) {
        [self alertShowWithTitle:message.body];
    }
    if ([message.name isEqualToString:@"inviteFriends"]) {
        InvitationTwoController *vc = [[InvitationTwoController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([message.name isEqualToString:@"contactBusiness"]) {
//        NSLog(@"123");
        NSLog(@"%@", message.body);
        LKSessionViewController *messageVc = [[LKSessionViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:message.body[@"userId"]];
        messageVc.title = message.body[@"nickName"];
        [self.navigationController pushViewController:messageVc animated:YES];
    }
    if ([message.name isEqualToString:@"line"]) {
        NSLog(@"%@", message.body);
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"选择跳转地图" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOne = [UIAlertAction actionWithTitle:@"高德地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 高德地图
            // 起点为“我的位置”，终点为后台返回的address
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
                NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&sid=BGVIS1&sname=%@&did=BGVIS2&dname=%@&dev=0&t=0",@"我的位置",message.body[@"address"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            }else {
                [self alertShowWithTitle:@"您还没有安装该地图"];
            }
            
        }];
        UIAlertAction *actionTwo = [UIAlertAction actionWithTitle:@"百度地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 百度地图 // 起点为“我的位置”，终点为后台返回的坐标
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
                NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=%@,%@&mode=riding&src=快健康快递", message.body[@"latitude"], message.body[@"longitude"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSURL *url = [NSURL URLWithString:urlString];
                [[UIApplication sharedApplication] openURL:url];
            }else {
                [self alertShowWithTitle:@"您还没有安装该地图"];
            }
        }];
        UIAlertAction *actionThree = [UIAlertAction actionWithTitle:@"苹果地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://maps.apple.com"]]) {
                NSString *urlString = [[NSString stringWithFormat:@"http://maps.apple.com/?daddr=%@",message.body[@"address"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            }else {
                [self alertShowWithTitle:@"您还没有安装该地图"];
            }
            
        }];
        UIAlertAction *actionFour = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVC addAction:actionOne];
        [alertVC addAction:actionTwo];
        [alertVC addAction:actionThree];
        [alertVC addAction:actionFour];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
    if ([message.name isEqualToString:@"pay"]) {
//        if ([message.body[@"type"] isEqualToString:@"1"]) {
//            [self toAliPayOfShopId:message.body[@"shopId"] totalFee:message.body[@"totalFee"] activityId:message.body[@"activityId"] deductionMoney:message.body[@"deductionMoney"] deductionType:@"2"];
//        }
//        if ([message.body[@"type"] isEqualToString:@"2"]) {
//            [self toWeChatPayOfShop:message.body[@"shopId"] totalFee:message.body[@"totalFee"] activityId:message.body[@"activityId"] deductionMoney:message.body[@"deductionMoney"] deductionType:@"2"];
//        }
    }
    if ([message.name isEqualToString:@"topUp"]) {
        NSLog(@"%@", message.body);
        NSLog(@"%@", message.body[@"type"]);
        if ([message.body[@"type"] isEqualToString:@"1"]) {
            [self congZhiOfAlipay:message.body[@"money"] shopId:message.body[@"shopId"]];
        }else {
            [self chongZhiOfWeChat:message.body[@"money"] shopId:message.body[@"shopId"]];
        }
    }
    if ([message.name isEqualToString:@"returnUpPage"]) {
        NSLog(@"%@", message.body);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//充值
- (void)congZhiOfAlipay:(NSString *)totalFee shopId:(NSString *)shopId {
    NSDictionary *paramet = @{@"userId" : [UserInfo sharedInstance].getUserid, @"sign" : BD_MD5Sign.md5String, @"total_fee" : totalFee, @"shopId" : shopId};
    [SCNetwork postWithURLString:BDUrl_s(@"alipay/topUp") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] >0) {
            NSString *appScheme = @"alisdkSurdot";
            [[AlipaySDK defaultService] payOrder:dic[@"info"] fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@", resultDic);
                
//                if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
//                    NSError *error;
//                    // 将json字符串转换成字典
//                    NSData * getJsonData = [resultDic[@"result"] dataUsingEncoding:NSUTF8StringEncoding];
//                    NSDictionary *getDic = [NSJSONSerialization JSONObjectWithData:getJsonData options:NSJSONReadingMutableContainers error:&error];
//                    
//                    self.zhiFuTime.text = [NSString stringWithFormat:@"支付时间：%@", getDic[@"alipay_trade_app_pay_response"][@"timestamp"]];
//                    self.dinDanLb.text = [NSString stringWithFormat:@"订单编号：%@", getDic[@"alipay_trade_app_pay_response"][@"out_trade_no"]];
//                    self.successView.hidden = NO;
//                }
            }];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络请求失败"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}

//微信充值
- (void)chongZhiOfWeChat:(NSString *)totalFee shopId:(NSString *)shopId {
    NSDictionary *paramet = @{@"userId" : [UserInfo sharedInstance].getUserid, @"sign" : BD_MD5Sign.md5String, @"total_fee" : totalFee, @"shopId" : shopId};
    [SCNetwork postWithURLString:BDUrl_s(@"weixinpay/weixinTopUp") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            [self wechatPay:dic[@"iosInfo"]];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络请求失败"];
        [SVProgressHUD dismissWithDelay:0.7];
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






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end






