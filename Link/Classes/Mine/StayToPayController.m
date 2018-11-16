//
//  StayToPayController.m
//  Link
//
//  Created by Surdot on 2018/7/26.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "StayToPayController.h"

@interface StayToPayController ()
@property (nonatomic, strong) NSString *myString;
@end

@implementation StayToPayController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCommonLeftBarButtonItem];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configlayoutButton];
    
}
- (void)configlayoutButton {
    UIButton *aliPayBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 30, ScreenW - 30, 30)];
    [self.view addSubview:aliPayBtn];
    aliPayBtn.backgroundColor = [UIColor cyanColor];
    [aliPayBtn setTitle:@"支付宝支付" forState:UIControlStateNormal];
    [aliPayBtn addTarget:self action:@selector(toAliPay) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *WeChatBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 90, ScreenW - 30, 30)];
    [self.view addSubview:WeChatBtn];
    WeChatBtn.backgroundColor = [UIColor cyanColor];
    [WeChatBtn setTitle:@"微信支付" forState:UIControlStateNormal];
    [WeChatBtn addTarget:self action:@selector(toWeChatPay) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *weixinShare = [[UIButton alloc] initWithFrame:CGRectMake(15, 150, ScreenW - 30, 30)];
    [self.view addSubview:weixinShare];
    weixinShare.backgroundColor = [UIColor cyanColor];
    [weixinShare setTitle:@"分享" forState:UIControlStateNormal];
    [weixinShare addTarget:self action:@selector(toShare) forControlEvents:UIControlEventTouchUpInside];
}
- (void)toAliPay {
    //进入支付宝支付
    [self requestAliPaySignData];
}
- (void)toWeChatPay {
    NSLog(@"微信");
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
- (void)toShare {
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        NSLog(@"%@", userInfo);
        [self toShare:platformType];
    }];
}
- (void)toShare:(UMSocialPlatformType)platformType {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    NSString *title = @"趣标";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:@"会员活动" thumImage:[UIImage imageNamed:@"AppIcon"]];
    shareObject.webpageUrl = @"http://joint-think.com/share/debate.html";
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id result, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"UMsocail error:%@", error);
        }else {
            if ([result isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = result;
                //分享结果消息
//                UMSocialLogInfo(@"%@", resp.message);
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
            }else {
//                UMSocialLogInfo(@"%@", result);
                UMSocialLogInfo(@"response data is %@",result);
            }
        }
    }];
}
//获取支付宝支付签名
- (void)requestAliPaySignData {
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid};
    [SCNetwork postWithURLString:[NSString stringWithFormat:@"%@/s/alipay/pay", MAIN_URL] parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"%@", dic);
            NSString *appScheme = @"alisdkSurdot";
            [[AlipaySDK defaultService] payOrder:dic[@"info"] fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@", resultDic);
            }];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
        [SVProgressHUD dismissWithDelay:0.6];
    }];
}
//微信支付签名
- (void)requestWeChatPayData {
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid};
    [SCNetwork postWithURLString:[NSString stringWithFormat:@"%@/s/weixinpay/weixinpay", MAIN_URL] parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"%@", dic);
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





@end
