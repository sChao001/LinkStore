//
//  SessionIconTapViewController.m
//  Link
//
//  Created by Surdot on 2018/6/3.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "SessionIconTapViewController.h"
#import "LKSessionViewController.h"

@interface SessionIconTapViewController ()
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nickNameLb;
@property (nonatomic, strong) UILabel *accountLb;
@property (nonatomic, strong) UIButton *addFriendBtn;

@property (nonatomic, strong) UILabel *addressLb;
@property (nonatomic, strong) UILabel *phoneLb;
@property (nonatomic, strong) UILabel *signLb;
@end

@implementation SessionIconTapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(239, 239, 239);
    [self creatIntroView];
    [self creatMyAlertlabel];
    [self setCommonLeftBarButtonItem];
    self.title = @"个人资料";
    [self requestInfoOfData];
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
//    [_iconView sd_setImageWithURL:[NSURL URLWithString:BDUrl_(_headerStr)]];
    
    _nickNameLb = [[UILabel alloc] init];
    [_contentView addSubview:_nickNameLb];
    [_nickNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).equalTo(20);
        make.top.equalTo(kWidthScale(30));
        make.width.greaterThanOrEqualTo(10);
    }];
//    _nickNameLb.text = _naameStr;
    //    _nickNameLb.backgroundColor = [UIColor orangeColor];
    _nickNameLb.font = [UIFont systemFontOfSize:kWidthScale(20)];
    _nickNameLb.text = @"aa";
    
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
    _accountLb.text = @"LINK号：13135259945";
    
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
    
    [_addFriendBtn setTitle:@"发送消息" forState:UIControlStateNormal];
    _addFriendBtn.backgroundColor = RGB(2, 133, 193);
    [_addFriendBtn addTarget:self action:@selector(sendFriendMessage) forControlEvents:UIControlEventTouchUpInside];
   
    
}
- (void)sendFriendMessage {
    LKSessionViewController *sessionVC = [[LKSessionViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:_targetId];
    sessionVC.title = _nickNameLb.text;
    [self.navigationController pushViewController:sessionVC animated:YES];
}
- (void)addFriendBtnClicked {
    NSLog(@"999999");
}
- (void)requestInfoOfData {
    NSString *jmString = [NSString stringWithFormat:@"%@%@%@", BD_key, BD_secret, [UserInfo sharedInstance].getjmToken];
    NSLog(@"%@++", jmString.md5String);
    NSDictionary *paramet = @{@"userId" : [UserInfo sharedInstance].getUserid, @"selectId" : _targetId, @"sign" : jmString.md5String};
    [SCNetwork postWithURLString:BDUrl_s(@"user/getUser") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            if ([dic[@"status"] integerValue] == 0) {
                self.addFriendBtn.hidden = YES;
            }
            if ([dic[@"status"] integerValue] < 0) {
                [self.addFriendBtn setTitle:@"添加好友" forState:UIControlStateNormal];
                [self.addFriendBtn addTarget:self action:@selector(addFriendBtnClicked) forControlEvents:UIControlEventTouchUpInside];
            }
            NSLog(@"dic:%@", dic);
            NSDictionary *userDic = dic[@"user"];
            [self.iconView sd_setImageWithURL:[NSURL URLWithString:BDUrl_(userDic[@"headUrl"])] placeholderImage:[UIImage imageNamed:@"headerImg"]];
            self.nickNameLb.text = userDic[@"nickName"];
            self.accountLb.text = [NSString stringWithFormat:@"LINK号:%@", userDic[@"account"]];
        }else {
            NSLog(@"%@", dic[@"result"]);
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}

@end
