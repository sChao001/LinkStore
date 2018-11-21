//
//  LKSharedMerchantsController.m
//  Link
//
//  Created by Surdot on 2018/6/29.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "LKSharedMerchantsController.h"
#import <WebKit/WebKit.h>
#import "ShareMerchantsTwoController.h"
#import "MerchantsQRScanController.h"
#import "MerchantsReceiveTwoController.h"
#import "LoginViewController.h"

@interface LKSharedMerchantsController ()<WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler, UINavigationControllerDelegate,  AMapLocationManagerDelegate> //CLLocationManagerDelegate,
{
//    CLLocationManager *locationmanager;
    NSString *strlatitude;
    NSString *strlongitude;
}
@property (nonatomic, strong) NSString *currentCity;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIImageView *topNaviView;
@property (nonatomic, strong) UIImageView *navImage;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSString *longitude;//经度
@property (nonatomic, strong) NSString *latitude;//纬度
@property (nonatomic, strong) UIButton *dayOfSignBtn;
@property (nonatomic, strong) UIImageView *tanView;
@property (nonatomic, strong) AMapLocationManager *aLocationManager;
//@property (nonatomic, copy) AMapLocatingCompletionBlock completionBlock;
@end

@implementation LKSharedMerchantsController

#pragma mark 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setMyNavigationBarHidden];
//    [self checkOutIsSign];
    
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"camera"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"action"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"getData"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"acceptData"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"record"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"hint"];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"camera"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"action"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"getData"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"acceptData"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"record"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"hint"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.longitude = @"";
    self.latitude = @"";
    
//    [self getLocation];
    [self creatMyAlertlabel];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotificationAndLoad) name:@"itemClickLoad" object:nil];

    self.title = @"活动";
    [SVProgressHUD show];
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = [WKUserContentController new];
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
//    preferences.minimumFontSize = 30.0;
    configuration.preferences = preferences;
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-49-LK_TabbarSafeBottomMargin) configuration:configuration];
//    [self.view addSubview:_webView];
    _webView.navigationDelegate = self;
    _webView.backgroundColor = RGB(245, 245, 245);
    
    
    
    if (![UserDefault boolForKey:@"SecondLogin"]) {
        NSLog(@"哈哈哈%@", self.url);
        _url = [NSURL URLWithString:[NSString stringWithFormat:@"%@s/buyshop/getShopList?sign=%@&latitude=%@&longitude=%@",  MAIN_URL, Un_LogInSign.md5String, _latitude, _longitude]];
    }else {
        if ([UserDefault boolForKey:@"isMerchants"] == YES) {
            _url = [NSURL URLWithString:[NSString stringWithFormat:@"%@s/shop/getShop?sign=%@&userId=%@",  MAIN_URL, BD_MD5Sign.md5String, [UserInfo sharedInstance].getUserid]];
        }else {
            _url = [NSURL URLWithString:[NSString stringWithFormat:@"%@s/buyshop/getShopList?sign=%@&userId=%@&latitude=%@&longitude=%@",  MAIN_URL, BD_MD5Sign.md5String, [UserInfo sharedInstance].getUserid, _latitude, _longitude]];
            NSLog(@"%@", _url);
        }
    }
    
    
    [_webView loadRequest:[NSURLRequest requestWithURL:_url]];
    _webView.scrollView.bounces = NO;
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    [SVProgressHUD dismissWithDelay:5];
    [self.view addSubview:_webView];
    self.webView.UIDelegate = self;

    [self creatTopNaviView];
    
    _tanView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    [self.view addSubview:_tanView];
    _tanView.image = [UIImage imageNamed:@"h_tanView"];
    _tanView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tanViewClick)];
    [_tanView addGestureRecognizer:tap];
    _tanView.hidden = YES;
    
    if ([UserDefault boolForKey:@"SecondLogin"]) {
        [self needToRequestNetwork];
    }
    // 清除缓存
//    [self receiveNotificationAndLoad];

    [self requestWebVersion];
}
- (void)requestWebVersion {
    NSDictionary *pramet = @{@"status" : [NSString stringWithFormat:@"%@", [UserDefault objectForKey:@"webviewLoadStatus"]], @"sign" : BD_SIGN};
    [SCNetwork postWithURLString:BDUrl_c(@"version/checkReload") parameters:pramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0 ){
            [UserDefault setObject:dic[@"status"] forKey:@"webviewLoadStatus"];
            [UserDefault synchronize];
            [self receiveNotificationAndLoad];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络请求失败"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}

//高德地图定位
- (void)creatAMapLocation {
    self.aLocationManager = [[AMapLocationManager alloc] init];
    
    [self.aLocationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    self.aLocationManager.locationTimeout = 3;
    self.aLocationManager.reGeocodeTimeout = 3;

    [self.aLocationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);

            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        self.latitude = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
        self.longitude = [NSString stringWithFormat:@"%f", location.coordinate.longitude];

        
        
        //打印当前的经度与纬度
        NSLog(@"%f == %f", location.coordinate.latitude, location.coordinate.longitude);

        if (![UserDefault boolForKey:@"SecondLogin"]) {
            NSLog(@"哈哈哈%@", self.url);
            self.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@s/buyshop/getShopList?sign=%@&latitude=%@&longitude=%@",  MAIN_URL, Un_LogInSign.md5String, self.latitude, self.longitude]];
        }else {
            if ([UserDefault boolForKey:@"isMerchants"] == YES) {
                self.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@s/shop/getShop?sign=%@&userId=%@",  MAIN_URL, BD_MD5Sign.md5String, [UserInfo sharedInstance].getUserid]];
            }else {
                NSLog(@"%@", self.url);
                self.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@s/buyshop/getShopList?sign=%@&userId=%@&latitude=%@&longitude=%@",  MAIN_URL, BD_MD5Sign.md5String, [UserInfo sharedInstance].getUserid, self.latitude, self.longitude]];
            }
        }
        NSLog(@"获取经纬度后的Url:%@", self.url);
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];

        if (regeocode)
        {
            NSLog(@"reGeocode:%@", regeocode);
        }
    }];
}
//需要注册用户进行网络请求的操作
- (void)needToRequestNetwork {
//    [self signOfDay];
//    [self requsetHUiYuanData];
}
- (void)tanViewClick {
    _tanView.hidden = YES;
}
- (void)receiveNotificationAndLoad {
    [self creatAMapLocation];
    NSLog(@"%@==%@", self.latitude, self.longitude);
    NSLog(@"%@", _url);

    //清除缓存
    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];

    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];

    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        NSLog(@"%@", self.url);
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
    }];
}
//签到
- (void)signOfDay {
    _dayOfSignBtn = [[UIButton alloc] init];
    [self.view addSubview:_dayOfSignBtn];
    [_dayOfSignBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-6);
        make.bottom.equalTo(-63-LK_TabbarSafeBottomMargin);
        make.size.equalTo(CGSizeMake(kWidthScale(134/2), kWidthScale(148/2)));
    }];
//    [_dayOfSignBtn addTarget:self action:@selector(dayOfSignBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_dayOfSignBtn setImage:[UIImage imageNamed:@"y_signOfday"] forState:UIControlStateNormal];
    _dayOfSignBtn.hidden = YES;
}
//- (void)dayOfSignBtnClicked {
//    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid};
//    [SCNetwork postWithURLString:BDUrl_s(@"user/signIn") parameters:paramet success:^(NSDictionary *dic) {
//        NSLog(@"%@", dic);
//        if ([dic[@"code"] integerValue] > 0) {
//            [self.dayOfSignBtn setImage:[UIImage imageNamed:@"y_signOfdayS"] forState:UIControlStateNormal];
//            self.dayOfSignBtn.userInteractionEnabled = NO;
//            [self alertShowWithTitle:[NSString stringWithFormat:@"签到成功，您已获得%@金币", dic[@"gold"]]];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                self.dayOfSignBtn.hidden = YES;
//            });
//        }
//    } failure:^(NSError *error) {
//        [SVProgressHUD showWithStatus:@"网络连接失败"];
//        [SVProgressHUD dismissWithDelay:0.6];
//    }];
//}
- (void)creatTopNaviView {
    _topNaviView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, LK_iPhoneXStatusBarHeight)];
    [self.view addSubview:_topNaviView];
    _topNaviView.image = [UIImage imageNamed:@"y_statusC1"];
    if (LK_iPhoneX) {
        _topNaviView.image = [UIImage imageNamed:@"y_sta"];
    }
}
-(void)setCustomNavigation
{
    _navImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, LK_iPhoneXNavHeight)];
    _navImage.backgroundColor = [UIColor whiteColor];
    _navImage.clipsToBounds = YES;
    _navImage.contentMode = UIViewContentModeScaleAspectFill;
    _navImage.userInteractionEnabled = YES;
    _navImage.image = [UIImage imageNamed:@"tbg"];
    if (LK_iPhoneX) {
        _navImage.image = [UIImage imageNamed:@"tbg_iphoneX"];
    }
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URL scheme];
    if ([scheme isEqualToString:@"haleyaction"]) {

        [self handleCustomAction:URL];

        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    [SVProgressHUD dismissWithDelay:1];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [SVProgressHUD dismiss];
   
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
//    [SVProgressHUD showWithStatus:@"内容加载失败"];
    [SVProgressHUD dismissWithDelay:0.6];
}

#pragma mark - private method
- (void)handleCustomAction:(NSURL *)URL {
    NSString *host = [URL host];
    if ([host isEqualToString:@"clicked"]) {
        NSLog(@"123333");
    }
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"camera"]) {
        NSLog(@"%@====%@", message.body, message.name);
        [SVProgressHUD show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            MerchantsQRScanController *vc = [[MerchantsQRScanController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        });
    }
    if ([message.name isEqualToString:@"action"]) {
        NSLog(@"%@", message.body);
        NSString *str = @"anonymity=1";
        if (![UserDefault boolForKey:@"SecondLogin"] && [message.body rangeOfString:str].location != NSNotFound) {
            LoginViewController *vc = [[LoginViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            ShareMerchantsTwoController *vc = [[ShareMerchantsTwoController alloc] init];
            vc.loadUrlStr = message.body;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if ([message.name isEqualToString:@"getData"]) {
        NSLog(@"%@", message.body);
        [self requestGetData:message.body];
//        [self.webView evaluateJavaScript:@"data(\"你好\")" completionHandler:nil];
    }
    if ([message.name isEqualToString:@"record"]) {
        NSLog(@"%@", message.body);
        MerchantsReceiveTwoController *vc = [[MerchantsReceiveTwoController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([message.name isEqualToString:@"hint"]) {
        NSLog(@"%@", message.body);
        [self alertShowWithTitle:message.body];
    }
}

//#pragma mark - UINavigationControllerDelegate
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    BOOL isShowPersonPage = [viewController isKindOfClass:[self class]];
//    [self.navigationController setNavigationBarHidden:isShowPersonPage];
//
//}

- (void)requestGetData:(NSString *)stringUrl {
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid};
    [SCNetwork postWithURLString:BDUrl_(stringUrl) parameters:paramet success:^(NSDictionary *dic) {
        NSLog(@"%@", dic);
    } failure:^(NSError *error) {
        
    }];
}
//-(void)getLocation
//{
//    //判断定位功能是否打开
//    if ([CLLocationManager locationServicesEnabled]) {
//        locationmanager = [[CLLocationManager alloc]init];
//        locationmanager.delegate = self;
//        [locationmanager requestAlwaysAuthorization];
//        _currentCity = [NSString new];
//        [locationmanager requestWhenInUseAuthorization];
//
//        //设置寻址精度
//        locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
//        locationmanager.distanceFilter = 5.0;
//        [locationmanager startUpdatingLocation];
//    }
//}


#pragma mark 定位成功后则执行此代理方法
//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
//{
//    [locationmanager stopUpdatingHeading];
//    //旧址
//    CLLocation *currentLocation = [locations lastObject];
//    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
//    //打印当前的经度与纬度
//    NSLog(@"%f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
//    self.longitude = [NSString stringWithFormat:@"%f", currentLocation.coordinate.longitude];
//    self.latitude = [NSString stringWithFormat:@"%f", currentLocation.coordinate.latitude];
//
//    if ([UserDefault boolForKey:@"isMerchants"] == YES) {
//        _url = [NSURL URLWithString:[NSString stringWithFormat:@"%@s/shop/getShop?sign=%@&userId=%@",  MAIN_URL, BD_MD5Sign.md5String, [UserInfo sharedInstance].getUserid]];
//    }else {
//        if (![UserDefault boolForKey:@"SecondLogin"]) {
//            _url = [NSURL URLWithString:[NSString stringWithFormat:@"%@s/buyshop/getShopList?sign=%@&latitude=%@&longitude=%@",  MAIN_URL, Un_LogInSign.md5String, _latitude, _longitude]];
//        }else {
//            if ([UserDefault boolForKey:@"isMerchants"] == YES) {
//                _url = [NSURL URLWithString:[NSString stringWithFormat:@"%@s/shop/getShop?sign=%@&userId=%@",  MAIN_URL, BD_MD5Sign.md5String, [UserInfo sharedInstance].getUserid]];
//            }else {
//                _url = [NSURL URLWithString:[NSString stringWithFormat:@"%@s/buyshop/getShopList?sign=%@&userId=%@&latitude=%@&longitude=%@",  MAIN_URL, BD_MD5Sign.md5String, [UserInfo sharedInstance].getUserid, _latitude, _longitude]];
//            }
//        }
//    }
//    NSLog(@"嘿嘿%@", _url);
////    [_webView loadRequest:[NSURLRequest requestWithURL:_url]];
//
//    //反地理编码
//    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        if (placemarks.count > 0) {
//            CLPlacemark *placeMark = placemarks[0];
//            self.currentCity = placeMark.locality;
//            if (!self.currentCity) {
//                self.currentCity = @"无法定位当前城市";
//            }
//
//            /*看需求定义一个全局变量来接收赋值*/
//            NSLog(@"----%@",placeMark.country);//当前国家
//            NSLog(@"%@",self.currentCity);//当前的城市
//            NSLog(@"%@",placeMark.subLocality);//当前的位置
//            NSLog(@"%@",placeMark.thoroughfare);//当前街道
//            NSLog(@"%@",placeMark.name);//具体地址
//        }
//    }];
//}



- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}




@end
