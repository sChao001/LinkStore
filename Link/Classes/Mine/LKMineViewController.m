//
//  LKMineViewController.m
//  Link
//
//  Created by Surdot on 2018/4/18.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "LKMineViewController.h"
#import "LKinfoViewController.h"
#import "LKMessageListController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "MineListCell.h"
#import "EditIdentifyViewController.h"
#import "SomeOneLabelsController.h"
#import "PlatformInfoController.h"
#import "MineSetViewController.h"
#import "DiscountToPayController.h"
#import "MerchantsQRController.h"
#import "MembersCenterViewController.h"
#import "CoinExchangeController.h"
#import "JoinPartnerViewController.h"
#import "StayToPayController.h"
#import "MerchantsReceiveController.h"
#import "InvitationViewController.h"
#import "PlatformAccountController.h"
#import "LoginViewController.h"
#import "PersonMemberViewController.h"
//
#import "ShareMerchantsTwoController.h"


@interface LKMineViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *navigationView;
@property (nonatomic, strong) LKMessageListController *listCell;
@property (nonatomic, strong) UIButton *LogoutBtn;
@property (nonatomic, strong) UIImageView *personView;
@property (nonatomic, strong) UIButton *iconBtn;
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UIButton *QRBtn;
@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) NSArray *listArray;
@property (nonatomic, strong) NSArray *iconArray;
@property (nonatomic, strong) NSArray *merchantsArray;
@property (nonatomic, strong) NSArray *merchantsIcon;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *headUrl;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *personId;
//
@property (nonatomic, strong) UIImageView *imageViewOne;
@property (nonatomic, strong) RImagButton *imageViewTwo;
@property (nonatomic, strong) UILabel *meMoney;
@property (nonatomic, strong) UILabel *meScore;
@property (nonatomic, strong) UILabel *meVouchers;
@property (nonatomic, strong) NSArray *arrayTwo;
@property (nonatomic, strong) NSArray *arrayThree;
@property (nonatomic, strong) NSArray *iconTwoArray;
@property (nonatomic, strong) NSArray *iconThreeArray;
@end

@implementation LKMineViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self setImageNaviBar];
    [self setMyNavigationBarHidden];
    if ([UserDefault boolForKey:@"SecondLogin"]) {
        [self requestPersonData];
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(245, 245, 245);
    self.listArray = @[@"个人资料", @"立即充值", @"商家入驻", @"关于我们", @"设置"];
    self.iconArray = @[@"w_person", @"w_money", @"w_merchants", @"w_aboutWe", @"w_set"];
    
    self.merchantsArray = @[@"个人资料", @"收款记录", @"商家中心", @"关于我们", @"设置"];
    self.merchantsIcon = @[@"w_person", @"w_receiveMoney", @"w_member",  @"w_aboutWe", @"w_set"];
    
    self.arrayTwo = @[@"立即充值", @"账户明细"];
    self.iconTwoArray = @[@"w_money", @"w_aboutWe"];
    self.arrayThree = @[@"关于我们", @"商家入驻", @"设置"];
    self.iconThreeArray = @[@"w_aboutWe", @"w_merchants", @"w_set"];
    [self makeTopViewLayout];
    [self creatMyListTableView];
    if ([UserDefault boolForKey:@"SecondLogin"]) {
        [self requestPersonData];
    }

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)setImageNaviBar {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //去掉黑线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:RGB(28, 28, 28),NSFontAttributeName:[UIFont boldSystemFontOfSize:17]};
    self.navigationController.navigationBar.translucent = YES;
}

- (void)makeTopViewLayout {
    _personView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, kWidthScale(175))];
    [self.view addSubview:_personView];
    _personView.backgroundColor = ColorHex(@"ffda00");
    if ([UserDefault boolForKey:@"isMerchants"]) {
        _personView.backgroundColor = ColorHex(@"282828");
    }
    _personView.userInteractionEnabled = YES;
    
    UILabel *titleLb = [[UILabel alloc] init];
    [_personView addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(LK_iPhoneXNavHeight - 44 +13.5);
        make.width.equalTo(30);
        make.height.equalTo(17);
    }];
    titleLb.font = [UIFont boldSystemFontOfSize:17];
    titleLb.textColor = RGB(28, 28, 28);
    titleLb.text = @"";
    
    _iconBtn = [[UIButton alloc] init];
    [_personView addSubview:_iconBtn];
    [_iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(20);
        make.bottom.equalTo(-85/2);
        make.size.equalTo(CGSizeMake(kWidthScale(70), kWidthScale(70)));
    }];
    _iconBtn.userInteractionEnabled = NO;
    [_iconBtn setImage:[UIImage imageNamed:@"w_iconPlace"] forState:UIControlStateNormal];
    
    _nameLb = [UILabel new];
    [_personView addSubview:_nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconBtn.mas_right).equalTo(15);
        make.top.equalTo(self.iconBtn.mas_top);
        make.width.equalTo(150);
        make.height.equalTo(kWidthScale(17));
//        make.centerY.equalTo(self.iconBtn.mas_centerY).equalTo(0);
    }];
    _nameLb.font = [UIFont systemFontOfSize:kWidthScale(17)];
    _nameLb.text = @"登录/注册";
    _nameLb.userInteractionEnabled = YES;
    if (![UserDefault boolForKey:@"SecondLogin"]) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClicked)];
        [_nameLb addGestureRecognizer:tap];
    }
    [self creatMemberLayout];
    
    _meMoney = [[UILabel alloc] init];
    [_personView addSubview:_meMoney];
    [_meMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLb.mas_left);
        make.height.equalTo(kWidthScale(12));
        make.top.equalTo(self.nameLb.mas_bottom).equalTo(9);
        make.width.greaterThanOrEqualTo(10);
    }];
    _meMoney.text = @"我的现金：";
    _meMoney.font = [UIFont systemFontOfSize:kWidthScale(12)];
    _meMoney.textColor = ColorHex(@"404040");
    
    _meScore = [[UILabel alloc] init];
    [_personView addSubview:_meScore];
    [_meScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLb.mas_left);
        make.height.equalTo(kWidthScale(12));
        make.top.equalTo(self.meMoney.mas_bottom).equalTo(6);
        make.width.greaterThanOrEqualTo(10);
    }];
    _meScore.text = @"我的积分：";
    _meScore.textColor = ColorHex(@"404040");
    _meScore.font = [UIFont systemFontOfSize:kWidthScale(12)];
    
    _meVouchers = [[UILabel alloc] init];
    [_personView addSubview:_meVouchers];
    [_meVouchers mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLb.mas_left);
        make.height.equalTo(kWidthScale(12));
        make.top.equalTo(self.meScore.mas_bottom).equalTo(6);
        make.width.greaterThanOrEqualTo(10);
    }];
    _meVouchers.text = @"我的代金券：";
    _meVouchers.font = [UIFont systemFontOfSize:kWidthScale(12)];
    _meVouchers.textColor = ColorHex(@"404040");
}

- (void)creatMemberLayout {
    _imageViewOne = [[UIImageView alloc] init];
    [_personView addSubview:_imageViewOne];
    [_imageViewOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconBtn.mas_right).equalTo(15);
        make.width.equalTo(kWidthScale(25.5));
        make.height.equalTo(kWidthScale(18));
        make.bottom.equalTo(-18);
    }];
    _imageViewOne.image = [UIImage imageNamed:@""];
    _imageViewOne.hidden = YES;
    
    _imageViewTwo = [[RImagButton alloc] init];
    [_personView addSubview:_imageViewTwo];
    [_imageViewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-20);
        make.size.equalTo(CGSizeMake(kWidthScale(80), kWidthScale(70)));
        make.centerY.equalTo(self.iconBtn);
    }];
    _imageViewTwo.imageRect = CGRectMake(0, 0, kWidthScale(80), kWidthScale(70));
    [_imageViewTwo setImage:[UIImage imageNamed:@"VIP_sign"] forState:UIControlStateNormal];
    if ([UserDefault boolForKey:@"isMerchants"]) {
        [_imageViewTwo setImage:[UIImage imageNamed:@"VIP_shop"] forState:UIControlStateNormal];
    }

}
- (void)didTapMember {
    ShareMerchantsTwoController *vc = [[ShareMerchantsTwoController alloc] init];
    vc.loadUrlStr = @"s/buyorder/getOrderList?1=1";
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
//    PersonMemberViewController *vc = [[PersonMemberViewController alloc] init];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tapClicked {
    LoginViewController *vc = [[LoginViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)creatMyListTableView {
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kWidthScale(175) + 10, ScreenW, ScreenH - LK_TabbarSafeBottomMargin -49 - kWidthScale(175)) style:UITableViewStyleGrouped];
    [self.view addSubview:_listTableView];
    _listTableView.backgroundColor = ColorHex(@"ebebeb");
    _listTableView.bounces = NO;
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    [_listTableView registerClass:[MineListCell class] forCellReuseIdentifier:@"listCell"];
//    UIView *viewTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0.1)];
//    viewTwo.backgroundColor = [UIColor redColor];
//    _listTableView.tableFooterView = viewTwo;
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0.1)];
//    view.backgroundColor = [UIColor cyanColor];
//    _listTableView.tableHeaderView = view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.00001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *viewTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0.00001)];
    return viewTwo;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 8;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *viewTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 8)];
    return viewTwo;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([UserDefault boolForKey:@"isMerchants"]) {
        return _merchantsArray.count;
    }
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 2;
    }else {
        return 3;
    }
//    return _listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if ([UserDefault boolForKey:@"isMerchants"]) {
        cell.titleLb.text = _merchantsArray[indexPath.row];
        cell.inconImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", _merchantsIcon[indexPath.row]]];
    }else {
        if (indexPath.section == 0) {
            cell.titleLb.text = @"个人资料";
            cell.inconImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", _iconArray[0]]];
        }else if (indexPath.section == 1) {
            cell.titleLb.text = _arrayTwo[indexPath.row];
            cell.inconImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", _iconTwoArray[indexPath.row]]];
        }else {
            cell.titleLb.text = _arrayThree[indexPath.row];
            cell.inconImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", _iconThreeArray[indexPath.row]]];
        }
//        cell.titleLb.text = _listArray[indexPath.row];
//        cell.inconImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", _iconArray[indexPath.row]]];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kWidthScale(60);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (![UserDefault boolForKey:@"SecondLogin"]) {
        LoginViewController *vc = [[LoginViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.row == 0 && indexPath.section == 0) {
        EditIdentifyViewController *vc = [[EditIdentifyViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.nickName = self.nickName;
        vc.account = self.account;
        vc.headUrl = self.headUrl;
        vc.sex = self.sex;
        vc.userId = self.personId;
        [self.navigationController pushViewController:vc animated:YES];
        
//        PlatformAccountController *vc = [[PlatformAccountController alloc] init];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 1 && indexPath.section == 1) {
        if ([UserDefault boolForKey:@"isMerchants"]) {
//            MerchantsReceiveController *vc = [[MerchantsReceiveController alloc] init];
//            vc.hidesBottomBarWhenPushed = YES;
            ShareMerchantsTwoController *vc = [[ShareMerchantsTwoController alloc] init];
            vc.loadUrlStr = @"/s/payhistory/getPayHistoryIndex?1=1";
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            PlatformAccountController *vc = [[PlatformAccountController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
    }
    if (indexPath.row == 0 && indexPath.section == 2) {
        if ([UserDefault boolForKey:@"isMerchants"]) {
            JoinPartnerViewController *vc = [[JoinPartnerViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            PlatformInfoController *vc = [[PlatformInfoController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];

        }

    }
    if (indexPath.row == 1 && indexPath.section == 2) {
        if ([UserDefault boolForKey:@"isMerchants"]) {
            PlatformInfoController *vc = [[PlatformInfoController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else {
//            PlatformInfoController *vc = [[PlatformInfoController alloc] init];
//            vc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:vc animated:YES];
            JoinPartnerViewController *vc = [[JoinPartnerViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if (indexPath.row == 2 && indexPath.section == 2) {
        if ([UserDefault boolForKey:@"isMerchants"]) {
            MineSetViewController *vc = [[MineSetViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            MineSetViewController *vc = [[MineSetViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
  
}

- (void)requestPersonData {
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid};
    [SCNetwork postWithURLString:BDUrl_s(@"user/getAllUser") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSDictionary *userDic = dic[@"user"];
            NSLog(@"%@", dic);
            NSLog(@"%@", [NSString stringWithFormat:@"%@%@", MAIN_URL, userDic[@"headUrl"]]);
            [self.iconBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", MAIN_URL, userDic[@"headUrl"]]] forState:UIControlStateNormal];
            self.nameLb.text = userDic[@"nickName"];
            self.nickName = userDic[@"nickName"];
            self.account = userDic[@"mobile"];
            self.headUrl = userDic[@"headUrl"];
            self.sex = [NSString stringWithFormat:@"%@", [userDic[@"sex"] integerValue] == 0 ? @"女" : @"男"];
            self.personId = userDic[@"id"];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}
- (void)QRBtnCLicked {
//    DiscountToPayController *vc = [[DiscountToPayController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    
    MerchantsQRController *vc = [[MerchantsQRController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)leftBtnClicked {
    
}

- (void)rightBtnClicked {
    
}


@end
