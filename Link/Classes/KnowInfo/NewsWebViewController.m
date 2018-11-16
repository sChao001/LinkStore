//
//  NewsWebViewController.m
//  Link
//
//  Created by Surdot on 2018/6/15.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "NewsWebViewController.h"
#import "ReportInfoViewController.h"

@interface NewsWebViewController () <WKNavigationDelegate, WKScriptMessageHandler> ///<UIWebViewDelegate>///
@property (nonatomic, strong) UIView *tanView;
@property (nonatomic, strong) UIButton *tanBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UIButton *reportBtn;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation NewsWebViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    [self.timer invalidate];
    self.timer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBarButtonWithNorImgName:@"y_back"];
    [self setRightBarItemOfIcon:@"y_func"];
//    [self setCommonLeftBarButtonItem];
    
    [self creatMyAlertlabel];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [SVProgressHUD show];
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenW,ScreenH)];
    _webView.navigationDelegate = self;
//    _webView.delegate = self;
    NSLog(@"%@", _webUrlStr);
    _webView.backgroundColor = [UIColor whiteColor];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_webUrlStr]]];
    
    [self.view addSubview:_webView];
    [self creatMyAlertlabel];
    
//    UIImage *image = [UIImage imageNamed:@"y_webshare"];
//    UIImage *renderImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:renderImage style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClicked)];
    
    [self configLayoutOfTanView];
}

- (void)configLayoutOfTanView {
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
- (void)reportBtnClicked {
    ReportInfoViewController *vc = [[ReportInfoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)shareBtnClicked {
    [self toShare];
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    [SVProgressHUD dismissWithDelay:1];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [SVProgressHUD dismiss];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 block:^(NSTimer * _Nonnull timer) {
        if (![UserDefault boolForKey:@"SecondLogin"]) {
            
        }else {
            
        }
    } repeats:NO];
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"%@", error);
    [SVProgressHUD showWithStatus:@"网页内容加载失败"];
    [SVProgressHUD dismiss];
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [SVProgressHUD showWithStatus:@"加载失败"];
    [SVProgressHUD dismiss];
}
//WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"share"]) {
        
    }
}


- (void)rightBarButtonItemClicked {
    [self toShare];
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
    NSString *title = @"共享会员";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:@"知道帖子" thumImage:[UIImage imageNamed:@"AppIcon"]];
//    shareObject.webpageUrl = @"http://47.93.244.115/v/index";
    shareObject.webpageUrl = _webUrlStr;
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
                if (![UserDefault boolForKey:@"SecondLogin"]) {
                
                }else {
                   
                }
            }else {
                //                UMSocialLogInfo(@"%@", result);
                UMSocialLogInfo(@"response data is %@",result);
            }
        }
    }];
}








@end
