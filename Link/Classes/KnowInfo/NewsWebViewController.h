//
//  NewsWebViewController.h
//  Link
//
//  Created by Surdot on 2018/6/15.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "SCBaseViewController.h"

@interface NewsWebViewController : SCBaseViewController
@property (nonatomic, strong) NSString *webUrlStr;
@property (nonatomic, strong) WKWebView *webView;
@end
