//
//  ScanSuccessViewController.m
//  Link
//
//  Created by Surdot on 2018/4/27.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "ScanSuccessViewController.h"
#import "SGWebView.h"

@interface ScanSuccessViewController () <SGWebViewDelegate>
@property (nonatomic , strong) SGWebView *webView;
@end

@implementation ScanSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setCommonLeftBarButtonItem];
    [self setupLabel];

}


// 添加Label，加载扫描过来的内容
- (void)setupLabel {
    // 提示文字
    UILabel *prompt_message = [[UILabel alloc] init];
    prompt_message.frame = CGRectMake(0, 150, self.view.frame.size.width, 30);
    prompt_message.text = @"二维码未识别";
    prompt_message.textColor = [UIColor greenColor];
    prompt_message.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:prompt_message];
    
    // 扫描结果
    CGFloat label_Y = CGRectGetMaxY(prompt_message.frame);
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, label_Y, self.view.frame.size.width, 30);
//    label.text = self.jump_bar_code;
    label.text = self.jump_URL;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}

// 添加webView，加载扫描过来的内容
- (void)setupWebView {
    CGFloat webViewW = [UIScreen mainScreen].bounds.size.width;
    CGFloat webViewH = [UIScreen mainScreen].bounds.size.height;
    self.webView = [SGWebView webViewWithFrame:CGRectMake(0, 0, webViewW, webViewH)];
    if (self.comeFromVC == ScanSuccessJumpComeFromWB) {
        _webView.progressViewColor = [UIColor orangeColor];
    };
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.jump_URL]]];
    _webView.SGQRCodeDelegate = self;
    [self.view addSubview:_webView];
    
//    // 提示文字
//    UILabel *prompt_message = [[UILabel alloc] init];
//    prompt_message.frame = CGRectMake(0, 200, self.view.frame.size.width, 30);
//    prompt_message.text = @"您扫描的条形码结果如下： ";
//    prompt_message.textColor = [UIColor redColor];
//    prompt_message.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:prompt_message];
//    
//    // 扫描结果
//    CGFloat label_Y = CGRectGetMaxY(prompt_message.frame);
//    UILabel *label = [[UILabel alloc] init];
//    label.frame = CGRectMake(0, label_Y, self.view.frame.size.width, 30);
//    label.text = self.jump_bar_code;
//    label.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:label];
}

- (void)webView:(SGWebView *)webView didFinishLoadWithURL:(NSURL *)url {
    NSLog(@"didFinishLoad");
    self.title = webView.navigationItemTitle;
}

@end
