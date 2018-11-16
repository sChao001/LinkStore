//
//  PlatformAccountController.m
//  Link
//
//  Created by Surdot on 2018/9/6.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "PlatformAccountController.h"
#import "PlatformAccountListCell.h"
#import "PlatformAccountModel.h"
#import "InvitationViewController.h"

@interface PlatformAccountController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *topContentView;
@property (nonatomic, strong) UILabel *accountTitle;
@property (nonatomic, strong) UILabel *moneyLb;
@property (nonatomic, strong) UIButton *tixianBtn;
@property (nonatomic, strong) UIButton *makeMoney;
@property (nonatomic, strong) UILabel *sign;
@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *descriLb;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation PlatformAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ColorHex(@"f5f5f2");
    [self setMyNavigationBarShowOfImage];
    [self setCommonLeftBarButtonItem];
    [self configLayoutOfView];
    [self configLayoutOfTableView];
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self requestTableViewList];
}

- (void)configLayoutOfView {
    _topContentView = [[UIView alloc] initWithFrame:CGRectMake(0, LK_iPhoneXNavHeight, ScreenW, kHeightScale(416)+10)];
//    [self.view addSubview:_topContentView];
    _topContentView.backgroundColor = [UIColor whiteColor];
    
    _accountTitle = [[UILabel alloc] init];
    [_topContentView addSubview:_accountTitle];
    [_accountTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(kHeightScale(42));
        make.width.greaterThanOrEqualTo(10);
    }];
    _accountTitle.text = @"账户余额";
    _accountTitle.textColor = ColorHex(@"656565");
    _accountTitle.font = [UIFont systemFontOfSize:kWidthScale(20)];

    _moneyLb = [[UILabel alloc] init];
    [_topContentView addSubview:_moneyLb];
    [_moneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.width.greaterThanOrEqualTo(10);
        make.top.equalTo(kHeightScale(116));
        make.height.equalTo(kWidthScale(40));
    }];
    _moneyLb.text = @"￥8.00";
    _moneyLb.textColor = ColorHex(@"282828");
    _moneyLb.font = [UIFont systemFontOfSize:kWidthScale(40)];

//    _sign = [[UILabel alloc] init];
//    [self.view addSubview:_sign];
//    [_sign mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.moneyLb.mas_left);
//        make.width.greaterThanOrEqualTo(10);
//        make.height.equalTo(kWidthScale(30));
//        make.bottom.equalTo(self.moneyLb.mas_bottom);
//    }];
//    _sign.text = @"￥";
//    _sign.textColor = ColorHex(@"282828");
//    _sign.font = [UIFont systemFontOfSize:kWidthScale(30)];

    _tixianBtn = [[UIButton alloc] init];
    [_topContentView addSubview:_tixianBtn];
    [_tixianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(0);
        make.left.equalTo(85);
        make.right.equalTo(-85);
        make.height.equalTo(kWidthScale(36));
        make.top.equalTo(kHeightScale(210));
    }];
    [_tixianBtn setTitle:@"提现" forState:UIControlStateNormal];
    _tixianBtn.backgroundColor = ColorHex(@"fac345");
    [_tixianBtn setTitleColor:ColorHex(@"ffffff") forState:UIControlStateNormal];
    _tixianBtn.titleLabel.font = [UIFont systemFontOfSize:kWidthScale(17)];
    _tixianBtn.layer.cornerRadius = kWidthScale(10);
    _tixianBtn.layer.masksToBounds = YES;

    _makeMoney = [[UIButton alloc] init];
    [_topContentView addSubview:_makeMoney];
    [_makeMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tixianBtn.mas_left);
        make.right.equalTo(self.tixianBtn.mas_right);
        make.height.equalTo(kWidthScale(36));
        make.top.equalTo(self.tixianBtn.mas_bottom).equalTo(18);
    }];
    _makeMoney.layer.cornerRadius = kWidthScale(10);
    _makeMoney.layer.masksToBounds = YES;
    _makeMoney.layer.borderWidth = 1;
    _makeMoney.layer.borderColor = ColorHex(@"fac345").CGColor;
    [_makeMoney setTitle:@"赚钱" forState:UIControlStateNormal];
    [_makeMoney setTitleColor:ColorHex(@"fac345") forState:UIControlStateNormal];
    _makeMoney.backgroundColor = [UIColor whiteColor];
    _makeMoney.titleLabel.font = [UIFont systemFontOfSize:kWidthScale(17)];
    [_makeMoney addTarget:self action:@selector(makeMoneyClicked) forControlEvents:UIControlEventTouchUpInside];
    
    _bottomView = [[UIView alloc] init];
    [_topContentView addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(0);
        make.height.equalTo(kWidthScale(40));
    }];
    _bottomView.backgroundColor = [UIColor whiteColor];
    
    _lineView = [[UIView alloc] init];
    [_topContentView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.bottom.equalTo(self.bottomView.mas_top);
        make.right.equalTo(0);
        make.height.equalTo(10);
    }];
    _lineView.backgroundColor = ColorHex(@"f5f5f2");
    
    _descriLb = [[UILabel alloc] init];
    [_bottomView addSubview:_descriLb];
    [_descriLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(12);
        make.centerY.equalTo(0);
        make.width.greaterThanOrEqualTo(10);
    }];
    _descriLb.text = @"平台返利";
    _descriLb.textColor = ColorHex(@"282828");
    _descriLb.font = [UIFont systemFontOfSize:kWidthScale(14)];
}

- (void)configLayoutOfTableView {
    //672
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStylePlain];
    [self.view addSubview:_listTableView];
//    _listTableView.backgroundColor = [UIColor cyanColor];
    _listTableView.tableHeaderView = _topContentView;
    [_listTableView registerClass:[PlatformAccountListCell class] forCellReuseIdentifier:@"listCell"];
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    _listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)requestTableViewList {
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid};
    [SCNetwork postWithURLString:BDUrl_s(@"rebate/getRebateList") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"%@", dic);
            NSArray *array = dic[@"rebateEntities"];
            for (NSDictionary *listDic in array) {
                PlatformAccountModel *model = [[PlatformAccountModel alloc] init];
                [model setValuesForKeysWithDictionary:listDic];
                [self.dataArray addObject:model];
            }
            [self.listTableView reloadData];
            NSDictionary *userDic = dic[@"userEntity"];
            self.moneyLb.text = [NSString stringWithFormat:@"￥%@", userDic[@"returnMoneyStr"]];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败"];
        [SVProgressHUD dismissWithDelay:0.6];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlatformAccountModel *model = self.dataArray[indexPath.row];
    PlatformAccountListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell" forIndexPath:indexPath];
    cell.maoneyLb.text = model.moneyStr;
    cell.timeLb.text = model.createTime;
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:BDUrl_(model.userEntity[@"headUrl"])]];
    cell.titleLb.text = model.userEntity[@"nickName"];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kWidthScale(60);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)makeMoneyClicked {
    InvitationViewController *vc = [[InvitationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}







@end
