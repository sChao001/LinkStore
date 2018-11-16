//
//  StoreingViewController.m
//  Link
//
//  Created by Surdot on 2018/11/8.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "StoreingViewController.h"
#import <WebKit/WebKit.h>

@interface StoreingViewController () <WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation StoreingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setMyNavigationBarShowOfImage];
    [self configWebViewLayout];
}

- (void)configWebViewLayout {
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, LK_iPhoneXNavHeight, ScreenW, ScreenH - LK_TabbarSafeBottomMargin-LK_iPhoneXNavHeight)];
    [self.view addSubview:_webView];
    _webView.navigationDelegate = self;
    _webView.scrollView.bounces = NO;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/s/buyintegralmall/index?1=1&sign=%@&userId=%@", MAIN_URL, BD_MD5Sign.md5String, [UserInfo sharedInstance].getUserid];
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
