//
//  SomeOneWebController.m
//  Link
//
//  Created by Surdot on 2018/7/16.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "SomeOneWebController.h"
#import "ReportInfoViewController.h"

@interface SomeOneWebController ()<WKNavigationDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIView *tanView;
@property (nonatomic, strong) UIButton *tanBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UIButton *reportBtn;
@property (nonatomic, strong) NSString *webViewUrl;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation SomeOneWebController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"帖子";
    [self setLeftBarButtonAndWillDismissWebview:@"y_back"];
    [self setRightBarItemOfIcon:@"y_func"];
    [self creatMyAlertlabel];
    [SVProgressHUD show];
    self.view.backgroundColor = [UIColor whiteColor];
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, LK_iPhoneXNavHeight, ScreenW, ScreenH-LK_TabbarSafeBottomMargin-LK_iPhoneXNavHeight)];
    [self.view addSubview:_webView];
    _webView.navigationDelegate = self;
    _webView.backgroundColor = RGB(245, 245, 245);
    
    _webViewUrl = [NSString stringWithFormat:@"%@/v/community/getCommunity?communityId=%@&userId=%@&sign=%@", MAIN_URL, _idStr, [UserInfo sharedInstance].getUserid, BD_MD5Sign.md5String];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_webViewUrl]]];
    
    _tanView = [[UIView alloc] initWithFrame:CGRectMake(ScreenW-kWidthScale(80), LK_iPhoneXNavHeight, kWidthScale(80), 80)];
    [self.view addSubview:_tanView];
    _tanView.backgroundColor = RGB(200, 200, 200);
    _tanView.hidden = YES;
    
    _reportBtn = [[UIButton alloc] init];
    [_tanView addSubview:_reportBtn];
    [_reportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(0);
        make.height.equalTo(40);
    }];
    _reportBtn.titleLabel.font = [UIFont systemFontOfSize:kWidthScale(17)];
    [_reportBtn setTitle:@"举报" forState:UIControlStateNormal];
    [_reportBtn addTarget:self action:@selector(reportBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    _shareBtn = [[UIButton alloc] init];
    [_tanView addSubview:_shareBtn];
    [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(self.reportBtn.mas_bottom).equalTo(0);
        make.height.equalTo(40);
    }];
    _shareBtn.titleLabel.font = [UIFont systemFontOfSize:kWidthScale(17)];
    [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [_shareBtn addTarget:self action:@selector(shareBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, LK_iPhoneXNavHeight)];
    [self.view addSubview:topView];
    topView.backgroundColor = [UIColor whiteColor];
    
//    NSLog(@"hhh%@", [NSString stringWithFormat:@"%@", [[UMSocialSinaHandler defaultManager] umSocial_isInstall]]);
    
//    if ([[UMSocialSinaHandler defaultManager] umSocial_isInstall]) {
//        NSLog(@"安装");
//    }else {
//        NSLog(@"未安装");
//    }
    
}
- (void)shareBtnClicked {
//    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformType:UMSocialPlatformType_QQ];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        NSLog(@"%@", userInfo);
        NSLog(@"%ld", (long)platformType);
        if (platformType == 0 && ![[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Sina]) {
            [self alertShowWithTitle:@"你没有安装微博"];
        }else {
            [self toShare:platformType];
        }
    }];
}
- (void)toShare:(UMSocialPlatformType)platformType {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    NSString *title = _articleTitle;
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:@"优秀文章尽在共享VIP,快来看看吧" thumImage:[UIImage imageNamed:@"AppIcon"]];
    //    shareObject.webpageUrl = @"http://47.93.244.115/v/index";
    shareObject.webpageUrl = _webViewUrl;
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

- (void)reportBtnClicked {
    NSLog(@"123");
    ReportInfoViewController *vc = [[ReportInfoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)setLeftBarButtonAndWillDismissWebview:(NSString *)norName {
    UIImage *tempImage = [UIImage imageNamed:norName];
    UIImage *selectedImage = [tempImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//防止系统渲染
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:selectedImage style:UIBarButtonItemStylePlain target:self action:@selector(leftBarItemBack)];
}

- (void)leftBarItemBack {
    [SVProgressHUD dismiss];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setRightBarItemOfIcon:(NSString *)iconStr {
//    UIImage *tempImage = [UIImage imageNamed:iconStr];
//    UIImage *sureImage = [tempImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:sureImage style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClicked)];
    
    self.tanBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [self.tanBtn setImage:[UIImage imageNamed:iconStr] forState:UIControlStateNormal];
    [self.tanBtn setImage:[UIImage imageNamed:@"y_funcS"] forState:UIControlStateSelected];
    [self.tanBtn addTarget:self action:@selector(rightItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.tanBtn];
    self.navigationItem.rightBarButtonItem = item;
//    self.tanBtn.backgroundColor = [UIColor blueColor];
}
- (void)rightItemClicked:(UIButton *)btn {
    NSLog(@"");
    if (btn.selected == NO) {
        _tanView.hidden = NO;
    }else {
        _tanView.hidden = YES;
    }
    btn.selected = !btn.selected;
    
}
#pragma mark - wkWebviewDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [SVProgressHUD dismiss];
    
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [SVProgressHUD showWithStatus:@"内容加载失败"];
    [SVProgressHUD dismissWithDelay:0.6];
}



#pragma mark
@end
