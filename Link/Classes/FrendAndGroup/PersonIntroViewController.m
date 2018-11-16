//
//  PersonIntroViewController.m
//  Link
//
//  Created by Surdot on 2018/5/21.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "PersonIntroViewController.h"
#import "LKSessionViewController.h"

@interface PersonIntroViewController ()
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nickNameLb;
@property (nonatomic, strong) UILabel *accountLb;
@property (nonatomic, strong) UIButton *addFriendBtn;

@property (nonatomic, strong) UILabel *addressLb;
@property (nonatomic, strong) UILabel *phoneLb;
@property (nonatomic, strong) UILabel *signLb;
@end

@implementation PersonIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(239, 239, 239);
    [self creatIntroView];
    [self creatMyAlertlabel];
    NSLog(@"%@", _status);
    [self setCommonLeftBarButtonItem];
    self.title = @"个人资料";
}

- (void)creatIntroView {
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, ScreenW, kWidthScale(112))];
    [self.view addSubview:_contentView];
    _contentView.backgroundColor = [UIColor whiteColor];
    
    _iconView = [[UIImageView alloc] init];
    [_contentView addSubview:_iconView];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kWidthScale(10));
        make.left.equalTo(15);
        make.bottom.equalTo(kWidthScale(-10));
        make.width.equalTo(kWidthScale(92));
    }];
//    _iconView.image = [UIImage imageNamed:@""];
    [_iconView sd_setImageWithURL:[NSURL URLWithString:BDUrl_(_headerStr)]];
    _iconView.backgroundColor = [UIColor brownColor];
    
    _nickNameLb = [[UILabel alloc] init];
    [_contentView addSubview:_nickNameLb];
    [_nickNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).equalTo(20);
        make.top.equalTo(kWidthScale(30));
        make.width.greaterThanOrEqualTo(10);
    }];
    _nickNameLb.text = _naameStr;
//    _nickNameLb.backgroundColor = [UIColor orangeColor];
    _nickNameLb.font = [UIFont systemFontOfSize:kWidthScale(20)];
    
    _accountLb = [[UILabel alloc] init];
    [_contentView addSubview:_accountLb];
    [_accountLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nickNameLb.mas_left);
        make.top.equalTo(self.nickNameLb.mas_bottom).equalTo(10);
        make.width.greaterThanOrEqualTo(10);
    }];
    _accountLb.font = [UIFont systemFontOfSize:kWidthScale(17)];
    _accountLb.textColor = RGB(130, 130, 130);
//    _accountLb.backgroundColor = [UIColor redColor];
    _accountLb.text = [NSString stringWithFormat:@"账号:%@",_accountStr];
    
    _signLb = [[UILabel alloc] init];
    [self.view addSubview:_signLb];
    [_signLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.height.equalTo(kWidthScale(60));
        make.top.equalTo(self.contentView.mas_bottom).equalTo(kWidthScale(25));
    }];
    _signLb.backgroundColor = [UIColor whiteColor];
    _signLb.textColor = RGB(43, 43, 43);
    _signLb.text = @"  个性签名:";
    _signLb.font = [UIFont systemFontOfSize:kWidthScale(17)];
    
    _addressLb = [[UILabel alloc] init];
    [self.view addSubview:_addressLb];
    [_addressLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.height.equalTo(kWidthScale(60));
        make.top.equalTo(self.signLb.mas_bottom).equalTo(kWidthScale(25));
    }];
    _addressLb.backgroundColor = [UIColor whiteColor];
    _addressLb.textColor = RGB(43, 43, 43);
    _addressLb.font = [UIFont systemFontOfSize:kWidthScale(17)];
    _addressLb.text = @"  地区";
    
    _phoneLb = [[UILabel alloc] init];
    [self.view addSubview:_phoneLb];
    [_phoneLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.height.equalTo(kWidthScale(60));
        make.top.equalTo(self.addressLb.mas_bottom).equalTo(1);
    }];
    _phoneLb.backgroundColor = [UIColor whiteColor];
    _phoneLb.textColor = RGB(43, 43, 43);
    _phoneLb.font = [UIFont systemFontOfSize:kWidthScale(17)];
    _phoneLb.text = @"  电话";
    
    _addFriendBtn = [[UIButton alloc] init];
    [self.view addSubview:_addFriendBtn];
    [_addFriendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
//        make.width.equalTo(100);
        make.height.equalTo(40);
        make.left.equalTo(15);
        make.right.equalTo(-15);
        make.top.equalTo(self.phoneLb.mas_bottom).equalTo(40);
    }];
    _addFriendBtn.layer.cornerRadius = 2;
    _addFriendBtn.layer.masksToBounds = YES;
    
    if ([_status integerValue] > 0) {
        [_addFriendBtn setTitle:@"发送消息" forState:UIControlStateNormal];
        _addFriendBtn.backgroundColor = RGB(2, 133, 193);
        [_addFriendBtn addTarget:self action:@selector(sendFriendMessage) forControlEvents:UIControlEventTouchUpInside];
    }else {
        [_addFriendBtn setTitle:@"添加好友" forState:UIControlStateNormal];
        _addFriendBtn.backgroundColor = RGB(2, 133, 193);
        [_addFriendBtn addTarget:self action:@selector(addFriendBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}
- (void)sendFriendMessage {
    LKSessionViewController *sessionVC = [[LKSessionViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:_friendId];
    sessionVC.title = _naameStr;
    [self.navigationController pushViewController:sessionVC animated:YES];
}
- (void)addFriendBtnClicked:(UIButton *)sender {
    NSString *jmString = [NSString stringWithFormat:@"%@%@%@", BD_key, BD_secret, [UserInfo sharedInstance].getjmToken];
    NSDictionary *paramet = @{@"userId" : [UserInfo sharedInstance].getUserid, @"friendId" : _friendId, @"nickName" : _naameStr, @"message" : [NSString stringWithFormat:@"我是%@", [UserInfo sharedInstance].getNickName], @"sign" : jmString.md5String};
    [SCNetwork postWithURLString:BDUrl_s(@"userRelation/add") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            [self alertShowWithTitle:@"已发送"];
            NSLog(@"%@", dic);
        }else {
            [self alertShowWithTitle:dic[@"result"]];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
        [SVProgressHUD dismissWithDelay:0.6];
    }];
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
