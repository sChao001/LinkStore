//
//  PublishHomeController.m
//  Link
//
//  Created by Surdot on 2018/6/22.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "PublishHomeController.h"
#import "TextAndImageEditController.h"
#import "EditContentViewController.h"


@interface PublishHomeController ()
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UIButton *contentBtn;
@property (nonatomic, strong) UIButton *publishAdBtn;
@property (nonatomic, strong) UIButton *publishNorBtn;
@property (nonatomic, strong) UITextField *titleField;
@property (nonatomic, strong) UISlider *distanceSlider;
@property (nonatomic, strong) UILabel *distanceLb;
@property (nonatomic, strong) UILabel *kmLabel;
@end

@implementation PublishHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatPublishViewlayout];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)creatPublishViewlayout {
    _titleLb = [[UILabel alloc] initWithFrame:CGRectMake(15, LK_iPhoneXNavHeight, 50, 40)];
    [self.view addSubview:_titleLb];
    _titleLb.backgroundColor = [UIColor orangeColor];
    _titleLb.text = @"标题";
    
    _contentBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 150, 230, 40)];
    [self.view addSubview:_contentBtn];
    _contentBtn.backgroundColor = [UIColor cyanColor];
    [_contentBtn setTitle:@"编辑内容" forState:UIControlStateNormal];
    [_contentBtn addTarget:self action:@selector(contentBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    _publishNorBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 210, 60, 40)];
    [self.view addSubview:_publishNorBtn];
    _publishNorBtn.backgroundColor = RGB(200, 200, 200);
    [_publishNorBtn setBackgroundImage:[UIImage imageWithColor:[UIColor cyanColor]] forState:UIControlStateSelected];
    [_publishNorBtn setTitle:@"简讯" forState:UIControlStateNormal];
    [_publishNorBtn addTarget:self action:@selector(choosedType:) forControlEvents:UIControlEventTouchUpInside];
    
    _publishAdBtn = [[UIButton alloc] initWithFrame:CGRectMake(95, 210, 60, 40)];
    [self.view addSubview:_publishAdBtn];
    _publishAdBtn.backgroundColor = RGB(200, 200, 200);
    [_publishAdBtn setBackgroundImage:[UIImage imageWithColor:[UIColor cyanColor]] forState:UIControlStateSelected];
    [_publishAdBtn setTitle:@"广告" forState:UIControlStateNormal];
    [_publishAdBtn addTarget:self action:@selector(choosedTypeTwo:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    _distanceSlider = [[UISlider alloc] initWithFrame:CGRectMake(15, 380, ScreenW - 30, 50)];
    [self.view addSubview:_distanceSlider];
//    _distanceSlider.backgroundColor = [UIColor redColor];
    _distanceSlider.minimumValue = 3;
    _distanceSlider.maximumValue = 5;
    [_distanceSlider addTarget:self action:@selector(toSliding) forControlEvents:UIControlEventValueChanged];

    
    _distanceLb = [[UILabel alloc] init];
    [self.view addSubview:_distanceLb];
    [_distanceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.top.equalTo(self.distanceSlider.mas_top).equalTo(-30);
        make.size.equalTo(CGSizeMake(50, 20));
    }];
//    _distanceLb.backgroundColor = [UIColor yellowColor];
    _distanceLb.text = @"距离";
    _distanceLb.font = [UIFont systemFontOfSize:kWidthScale(15)];
    _distanceLb.textColor = RGB(68, 68, 68);
    
    _kmLabel = [[UILabel alloc] init];
    [self.view addSubview:_kmLabel];
    [_kmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-15);
        make.top.equalTo(self.distanceLb.mas_top);
        make.size.equalTo(CGSizeMake(50, 20));
    }];
    _kmLabel.text = @"3.0km";
    _kmLabel.font = [UIFont systemFontOfSize:kWidthScale(15)];
    _kmLabel.textColor = RGB(68, 68, 68);
}

- (void)contentBtnClicked {
//    TextAndImageEditController *vc = [[TextAndImageEditController alloc] init];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
    

    EditContentViewController *vc = [[EditContentViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)toSliding {
    NSLog(@"%f", _distanceSlider.value);
    _kmLabel.text = [NSString stringWithFormat:@"%.1fkm", _distanceSlider.value];
}
- (void)choosedType:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        _publishAdBtn.selected = NO;
    }
//    sender.backgroundColor = [UIColor cyanColor];
}
- (void)choosedTypeTwo:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        _publishNorBtn.selected = NO;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
