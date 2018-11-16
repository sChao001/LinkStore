//
//  CoinExchangeController.m
//  Link
//
//  Created by Surdot on 2018/8/15.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "CoinExchangeController.h"
#import <WebKit/WebKit.h>

@interface CoinExchangeController () <WKNavigationDelegate, WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation CoinExchangeController

#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"action"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"action"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configWebViewLayout];
    [self setCommonLeftBarButtonItem];
}

- (void)configWebViewLayout {
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - LK_iPhoneXNavHeight-LK_TabbarSafeBottomMargin)];
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
#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"action"]) {
        NSLog(@"%@", message.body);
//        NSLog(@"%@", message.body);
//        ShareMerchantsThreeController *vc = [[ShareMerchantsThreeController alloc] init];
//        vc.loadUrlStr = message.body;
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
        
    }
}
@end
