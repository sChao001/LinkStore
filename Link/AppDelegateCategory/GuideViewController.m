//
//  GuideViewController.m
//  Link
//
//  Created by Surdot on 2018/9/12.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatMyWelcomeView];
}

- (void)creatMyWelcomeView {
    if ([UserDefault boolForKey:@"welcomeViewDismiss"]) {
        return;
    }
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(3*ScreenW, ScreenH);
//    _scrollView.delegate = self;
    _scrollView.tag = 120;
//    _scrollView.backgroundColor = [UIColor redColor];
    _scrollView.bounces = NO;
//    [[UIApplication sharedApplication].keyWindow addSubview:_scrollView];
    [self.view addSubview:_scrollView];
    
    NSString * size = @"750-1334";
    CGFloat btn_bottom = kWidthScale(45)+70;;
    if (LK_iPhoneX) {
        size = @"1125-2436";
        btn_bottom = 190;
    } else if(iPhone4){
        size = @"640-960";
    }else {
        size = @"750-1334";
    }
    NSArray * imgArr = @[[NSString stringWithFormat:@"guides1%@",size],
                         [NSString stringWithFormat:@"guides2%@",size],
                         [NSString stringWithFormat:@"guides3%@",size]];
    
    for (int i=0;i<imgArr.count;i++) {
        UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(i*ScreenW, 0, ScreenW, ScreenH)];
        image.image = [UIImage imageNamed:imgArr[i]];
        [_scrollView addSubview:image];
    }
    
    UIButton * joinBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    //    joinBtn.backgroundColor = RGBA_Y(222, 0.3);
    joinBtn.frame = CGRectMake(2*ScreenW + ScreenW/2-100, ScreenH-btn_bottom+LK_TabbarSafeBottomMargin, 200, 100);
    [_scrollView addSubview:joinBtn];
    [joinBtn addTarget:self action:@selector(joinBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
//    joinBtn.backgroundColor = [UIColor cyanColor];
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (scrollView.tag == 120) {
//        CGFloat x = scrollView.contentOffset.x;
//        if (x>2*ScreenW+20) {
////            NSUserDefaults * defa = [NSUserDefaults standardUserDefaults];
////            [defa setBool:YES forKey:NewGuide];
////            [defa synchronize];
//            [UserDefault setBool:YES forKey:@"welcomeViewDismiss"];
//            [UserDefault synchronize];
//
//            scrollView.scrollEnabled = NO;
////            [UIView animateWithDuration:0.3 animations:^{
////                scrollView.alpha = 0.2;
////            } completion:^(BOOL finished) {
////                [scrollView removeAllSubviews];
////                [scrollView removeFromSuperview];
////            }];
//            LKTabBarController *tabbar = [[LKTabBarController alloc] init];
//            [UIApplication sharedApplication].keyWindow.rootViewController = tabbar;
//        }
//    }
//}
- (void)joinBtnAction {
    
    CGFloat x = _scrollView.contentOffset.x;
    if (x>2*ScreenW || x == 2*ScreenW) {
        [UserDefault setBool:YES forKey:@"welcomeViewDismiss"];
        [UserDefault synchronize];
        
        _scrollView.scrollEnabled = NO;
//        [UIView animateWithDuration:0.4 animations:^{
//            self.scrollView.alpha = 0.2;
//        } completion:^(BOOL finished) {
//            [self.scrollView removeAllSubviews];
//            [self.scrollView removeFromSuperview];
//            LKTabBarController *tabbar = [[LKTabBarController alloc] init];
//            [UIApplication sharedApplication].keyWindow.rootViewController = tabbar;
//        }];
        LKTabBarController *tabbar = [[LKTabBarController alloc] init];
        [UIApplication sharedApplication].keyWindow.rootViewController = tabbar;
    }
    
}

@end
