//
//  MerchantsQRController.m
//  Link
//
//  Created by Surdot on 2018/8/7.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "MerchantsQRController.h"

@interface MerchantsQRController ()
@property (nonatomic, strong) UIImageView *QRimageView;

@end

@implementation MerchantsQRController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(239, 239, 239);
    [self setCommonLeftBarButtonItem];
    
    _QRimageView = [[UIImageView alloc] init];
    [self.view addSubview:_QRimageView];
    [_QRimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.size.equalTo(CGSizeMake(240, 240));
        make.top.equalTo(80);
    }];
//    _QRimageView.backgroundColor = [UIColor cyanColor];
    [self requestMerchantsInfo];
}

- (void)requestMerchantsInfo {
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid};
    [SCNetwork postWithURLString:BDUrl_s(@"shop/getShopByUserId") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSDictionary *shopDic = dic[@"shop"];
//            self.QRimageView.image = [UIImage imageNamed:BDUrl_(shopDic[@"qrUrl"])];
            NSLog(@"%@", dic);
            [self.QRimageView sd_setImageWithURL:[NSURL URLWithString:BDUrl_(shopDic[@"qrUrl"])]];
            NSLog(@"%@", dic);
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败"];
        [SVProgressHUD dismissWithDelay:0.6];
    }];
}

@end
