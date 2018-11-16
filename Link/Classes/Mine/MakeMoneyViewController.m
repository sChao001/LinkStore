//
//  MakeMoneyViewController.m
//  Link
//
//  Created by Surdot on 2018/8/15.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "MakeMoneyViewController.h"
#import <WebKit/WebKit.h>

@interface MakeMoneyViewController () <WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation MakeMoneyViewController

#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configWebViewLayout];
    [self setCommonLeftBarButtonItem];
}

- (void)configWebViewLayout {
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - LK_iPhoneXNavHeight - LK_TabbarSafeBottomMargin)];
    [self.view addSubview:_webView];
    _webView.navigationDelegate = self;
    
    NSString *urlStr = [NSString stringWithFormat:@"%@s/gold/conversion?sign=%@&userId=%@", MAIN_URL, BD_MD5Sign.md5String, [UserInfo sharedInstance].getUserid];
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

@end
