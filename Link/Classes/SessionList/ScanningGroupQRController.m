//
//  ScanningGroupQRController.m
//  Link
//
//  Created by Surdot on 2018/8/8.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "ScanningGroupQRController.h"
#import "LKSessionViewController.h"

@interface ScanningGroupQRController ()
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *groupNameLb;
@property (nonatomic, strong) UILabel *groupCountLb;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UILabel *tipLb;
@end

@implementation ScanningGroupQRController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(239, 239, 239);
    [self configLayoutView];
    [self setCommonLeftBarButtonItem];
    [self requestInfomationData];
}

- (void)configLayoutView {
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, kHeightScale(185))];
    [self.view addSubview:_topView];
    _topView.backgroundColor = [UIColor whiteColor];
    
    _iconView = [[UIImageView alloc] init];
    [_topView addSubview:_iconView];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kWidthScale(30));
        make.size.equalTo(CGSizeMake(kWidthScale(100), kWidthScale(100)));
        make.centerX.equalTo(0);
    }];
    _iconView.backgroundColor = [UIColor orangeColor];
    
    _groupNameLb = [[UILabel alloc] init];
    [_topView addSubview:_groupNameLb];
    [_groupNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.lessThanOrEqualTo(150);
        make.height.equalTo(16);
        make.top.equalTo(self.iconView.mas_bottom).equalTo(10);
        make.centerX.equalTo(0);
    }];
    _groupNameLb.text = @"刷卡收款卡";
    _groupNameLb.textColor = RGB(28, 28, 28);
    _groupNameLb.font = [UIFont systemFontOfSize:kWidthScale(16)];
    
    _groupCountLb = [[UILabel alloc] init];
    [_topView addSubview:_groupCountLb];
    [_groupCountLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.groupNameLb.mas_bottom).equalTo(5);
        make.width.lessThanOrEqualTo(150);
        make.centerX.equalTo(0);
        make.height.equalTo(12);
    }];
    _groupCountLb.text = @"(共2人)";
    _groupCountLb.font = [UIFont systemFontOfSize:12];
    _groupCountLb.textColor = RGB(100, 100, 100);
    
    _addBtn = [[UIButton alloc] init];
    [self.view addSubview:_addBtn];
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).equalTo(100);
        make.centerX.equalTo(0);
        make.width.equalTo(100);
        make.height.equalTo(40);
    }];
    _addBtn.backgroundColor = ColorHex(@"f5b840");
    [_addBtn setTitle:@"加入群聊" forState:UIControlStateNormal];
    _addBtn.titleLabel.font = [UIFont systemFontOfSize:kWidthScale(17)];
    [_addBtn setTitleColor:RGB(18, 18, 18) forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(addBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    _tipLb = [[UILabel alloc] init];
    [self.view addSubview:_tipLb];
    [_tipLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.addBtn.mas_top).equalTo(-20);
        make.width.equalTo(100);
        make.height.equalTo(13);
        make.centerX.equalTo(0);
    }];
    _tipLb.text = @"您已经加入该群";
    _tipLb.textColor = RGB(68, 68, 68);
    _tipLb.font = [UIFont systemFontOfSize:13];
    _tipLb.hidden = YES;
}

- (void)requestInfomationData {
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"groupId" : _targetId};
    [SCNetwork postWithURLString:BDUrl_s(@"group/getGroup") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"%@", dic);
            self.groupCountLb.text = [NSString stringWithFormat:@"（共%@人）", dic[@"count"]];
            NSDictionary *groupDic = dic[@"group"];
            self.groupNameLb.text = groupDic[@"name"];
            [self.iconView sd_setImageWithURL:[NSURL URLWithString:BDUrl_(groupDic[@"imageUrl"])]];
            if ([dic[@"status"] integerValue] >0) {
                self.tipLb.hidden = NO;
                [self.addBtn setTitle:@"发送消息" forState:UIControlStateNormal];
            }
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
    
    
    
}

- (void)addBtnClicked {
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"groupId" : _targetId};
    [SCNetwork postWithURLString:BDUrl_s(@"group/addGroup") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            LKSessionViewController *vc = [[LKSessionViewController alloc] initWithConversationType:ConversationType_GROUP targetId:self.targetId];
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            [self alertShowWithTitle:dic[@"result"]];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
