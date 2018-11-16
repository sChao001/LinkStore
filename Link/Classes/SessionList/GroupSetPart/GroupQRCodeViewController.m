//
//  GroupQRCodeViewController.m
//  Link
//
//  Created by Surdot on 2018/6/2.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "GroupQRCodeViewController.h"
#import "SCQRCodeScanningController.h"

@interface GroupQRCodeViewController ()
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIImageView *QRCodeImg;
@end

@implementation GroupQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    NSLog(@"%@", _groupId);
    self.view.backgroundColor = [UIColor whiteColor];
    [self setCommonLeftBarButtonItem];
    self.title = @"群二维码名片";
    //    self.view.backgroundColor = RGBA(44, 44, 44, 0.6);
    
    _backgroundView = [[UIView alloc] init];
    [self.view addSubview:_backgroundView];
    self.backgroundView.frame = self.view.bounds;
    _backgroundView.backgroundColor = RGBA(190, 190, 190, 0.6);
    
    _QRCodeImg = [[UIImageView alloc] init];
    [_backgroundView addSubview:_QRCodeImg];
    [_QRCodeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.centerY.equalTo(self.view.mas_centerY).equalTo(-LK_TabbarSafeBottomMargin);
//        make.top.equalTo(kHeightScale(90));
        make.size.equalTo(CGSizeMake(kWidthScale(260), kWidthScale(260)));
    }];
    _QRCodeImg.backgroundColor = [UIColor whiteColor];
    if (@available(iOS 10.0, *)) {
        _QRCodeImg.image = [SGQRCodeGenerateManager generateWithColorQRCodeData:[NSString stringWithFormat:@"G_%@", _groupId] backgroundColor:[CIColor blackColor] mainColor:[CIColor whiteColor]];
    } else {
        // Fallback on earlier versions
    }
    //    _QRCodeImg.image = [SGQRCodeGenerateManager generateWithDefaultQRCodeData:@"哈哈" imageViewWidth:100];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
