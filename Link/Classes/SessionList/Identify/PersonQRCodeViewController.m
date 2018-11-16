//
//  PersonQRCodeViewController.m
//  Link
//
//  Created by Surdot on 2018/6/2.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "PersonQRCodeViewController.h"
#import "SCQRCodeScanningController.h"

@interface PersonQRCodeViewController ()
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *QRCodeImg;
@property (nonatomic, strong) UILabel *titleLb;

@end

@implementation PersonQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", _userId);
    self.view.backgroundColor = [UIColor whiteColor];
    [self setCommonLeftBarButtonItem];
    self.title = @"二维码名片";
//    self.view.backgroundColor = RGBA(44, 44, 44, 0.6);
    
    _backgroundView = [[UIView alloc] init];
    [self.view addSubview:_backgroundView];
    self.backgroundView.frame = self.view.bounds;
    _backgroundView.backgroundColor = RGBA(190, 190, 190, 0.6);
    
    _contentView = [[UIView alloc] init];
    [_backgroundView addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.centerY.equalTo(self.view.mas_centerY).equalTo(-LK_TabbarSafeBottomMargin);
        make.size.equalTo(CGSizeMake(kWidthScale(260), kWidthScale(280)));
    }];
    _contentView.backgroundColor = [UIColor whiteColor];
    
    _QRCodeImg = [[UIImageView alloc] init];
    [_contentView addSubview:_QRCodeImg];
    [_QRCodeImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(0);
////        make.top.equalTo(90);
//        make.centerY.equalTo(self.view.mas_centerY).equalTo(-LK_TabbarSafeBottomMargin);
//        make.size.equalTo(CGSizeMake(kWidthScale(260), kWidthScale(260)));
        make.left.equalTo(10);
        make.right.equalTo(-10);
        make.height.equalTo(kWidthScale(260)-20);
        make.top.equalTo(0);
    }];
    _QRCodeImg.backgroundColor = [UIColor whiteColor];
    if (@available(iOS 10.0, *)) {
        _QRCodeImg.image = [SGQRCodeGenerateManager generateWithColorQRCodeData:[NSString stringWithFormat:@"P_%@", _userId] backgroundColor:[CIColor blackColor] mainColor:[CIColor whiteColor]];
    } else {
        // Fallback on earlier versions
    }
//    _QRCodeImg.image = [SGQRCodeGenerateManager generateWithDefaultQRCodeData:@"哈哈" imageViewWidth:100];
    
    _titleLb = [[UILabel alloc] init];
    [_contentView addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.bottom.equalTo(-5);
        make.width.greaterThanOrEqualTo(10);
    }];
    _titleLb.text = @"扫描上面二维码图案，加我好友";
    _titleLb.font = [UIFont systemFontOfSize:13];
    _titleLb.textColor = RGB(150, 150, 150);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
