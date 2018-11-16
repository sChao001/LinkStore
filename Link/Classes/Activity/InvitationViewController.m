//
//  InvitationViewController.m
//  Link
//
//  Created by Surdot on 2018/9/4.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "InvitationViewController.h"

@interface InvitationViewController ()
@property (nonatomic, strong) UIImageView *backgroundImg;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) NSString *urlString;
@end

@implementation InvitationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"赚钱推广";
//    [self setImageNaviBar];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setCommonLeftBarButtonItem];
    [self setMyNavigationBarShowOfImage];
    [self configLayoutOfView];
    
}
- (void)setImageNaviBar {
    NSString *stringX = @"w_naviBarX";
    NSString *string = @"w_naviBar";
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", LK_iPhoneX ? stringX : string]] forBarMetrics:UIBarMetricsDefault];
    //去掉黑线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:RGB(28, 28, 28),NSFontAttributeName:[UIFont boldSystemFontOfSize:17]};
    self.navigationController.navigationBar.translucent = YES;
}
- (void)configLayoutOfView {
    _backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, LK_iPhoneXNavHeight, ScreenW, ScreenH - LK_iPhoneXNavHeight)];
    [self.view addSubview:_backgroundImg];
    _backgroundImg.image = [UIImage imageNamed:@"h_invitationTwo"];
    
    _button = [[UIButton alloc] init];
    [self.view addSubview:_button];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-28);
        make.left.equalTo(20);
        make.right.equalTo(-20);
        make.height.equalTo(50);
    }];
    _button.backgroundColor = [UIColor clearColor];
    [_button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
}
- (void)buttonClicked {
    [self requestDataOfShareUrl];
    NSArray *array = @[@(UMSocialPlatformType_QQ), @(UMSocialPlatformType_Qzone), @(UMSocialPlatformType_WechatTimeLine), @(UMSocialPlatformType_WechatFavorite), @(UMSocialPlatformType_Sina)];
    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:array];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        [self toShare:platformType];
    }];
}
- (void)toShare:(UMSocialPlatformType)platformType {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    NSString *title = @"小哥哥小姐姐，您的好友叫您领会员了！";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:@"共享会员让您的生活更加惬意！" thumImage:[UIImage imageNamed:@"AppIcon"]];
        shareObject.webpageUrl = _urlString;
//    shareObject.webpageUrl = _webViewUrl;
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
- (void)requestDataOfShareUrl {
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid};
    [SCNetwork postWithURLString:BDUrl_s(@"generalizewelfare/index") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"%@", dic[@"result"]);
            self.urlString = dic[@"result"];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
