//
//  LaunchADViewController.m
//  Link
//
//  Created by Surdot on 2018/11/21.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "LaunchADViewController.h"
#import "AppDelegate.h"

@interface LaunchADViewController ()
@property (nonatomic, strong) UIImageView *adImageView;
@property (nonatomic, strong) UILabel *timeLb;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int count;
@end

@implementation LaunchADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _adImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_adImageView];
    [_adImageView sd_setImageWithURL:[NSURL URLWithString:BDUrl_(@"public/images/ad.png")]];
    _adImageView.contentMode = UIViewContentModeScaleAspectFill;
    _adImageView.userInteractionEnabled = YES;
    
    _timeLb = [[UILabel alloc] init];
    [_adImageView addSubview:_timeLb];
    [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(20);
        make.right.equalTo(-15);
        make.width.equalTo(80);
        make.height.equalTo(30);
    }];
    _timeLb.layer.cornerRadius = 4;
    _timeLb.layer.masksToBounds = YES;
    _timeLb.textAlignment = NSTextAlignmentCenter;
    _timeLb.textColor = [UIColor whiteColor];
    _timeLb.backgroundColor = RGBA(100, 100, 100, 0.5);
    _count = 3;
    _timeLb.text = [NSString stringWithFormat:@"%ds 跳过", _count];
    _timeLb.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(timeLbClicked)];
    [_timeLb addGestureRecognizer:tap];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeCount) userInfo:nil repeats:YES];
}

- (void)timeCount {
    _count--;
    if (_count < 0) {
        [_timer invalidate];
        _timer = nil;
//        _timeLb.text = @"完成";
        if ([UserDefault boolForKey:@"SecondLogin"]) {
            ((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController = [[LKMyTabBarController alloc] init];
        }else {
            ((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController = [[LKTabBarController alloc] init];
        }
        
    }else {
        _timeLb.text = [NSString stringWithFormat:@"%ds 跳过", _count];
    }
}
- (void)timeLbClicked {
    if ([UserDefault boolForKey:@"SecondLogin"]) {
        ((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController = [[LKMyTabBarController alloc] init];
    }else {
        ((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController = [[LKTabBarController alloc] init];
    }
}

@end
