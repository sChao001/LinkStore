//
//  AddSubIdentifyController.m
//  Link
//
//  Created by Surdot on 2018/5/29.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "AddSubIdentifyController.h"
#import "EditIdentifyViewController.h"
#import "AddEditIdentifyController.h"
#import "SubIdentifyModel.h"
#import "SubIdentifyCell.h"

@interface AddSubIdentifyController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *accountLb;
@property (nonatomic, strong) RImagButton *editBtn;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) RImagButton *addBtn;
@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) NSMutableArray *usersArray;

@property (nonatomic, strong) NSNumber *main_ID;
@property (nonatomic, strong) NSString *main_token;
@property (nonatomic, strong) NSString *main_mobile;
@property (nonatomic, strong) NSString *main_account;
@property (nonatomic, strong) NSString *main_nickName;
@property (nonatomic, strong) NSString *main_headUrl;
@property (nonatomic, strong) NSString *main_sex;
@end

@implementation AddSubIdentifyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(239, 239, 239);
//    [self requestIdentifiesData];
//    [self creatViewlayout];
    [self setCommonLeftBarButtonItem];
    self.usersArray = [NSMutableArray arrayWithCapacity:0];
    self.title = @"身份信息";
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestIdentifiesData];
    [self creatViewlayout];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    
}
- (void)creatViewlayout {
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 13, ScreenW, kWidthScale(84))];
    [self.view addSubview:_topView];
    _topView.backgroundColor = [UIColor whiteColor];
    
    _iconImg = [[UIImageView alloc] init];
    [_topView addSubview:_iconImg];
    [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(kWidthScale(67), kWidthScale(67)));
        make.centerY.equalTo(0);
        make.left.equalTo(kWidthScale(16));
    }];
//    _iconImg.image = [UIImage imageNamed:@"headerImg"];
    [_iconImg sd_setImageWithURL:[NSURL URLWithString:BDUrl_(_main_headUrl)] placeholderImage:[UIImage imageNamed:@"headerImg"]];
    
    _nameLb = [[UILabel alloc] init];
    [_topView addSubview:_nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg.mas_right).equalTo(7);
        make.top.equalTo(kWidthScale(21));
        make.width.greaterThanOrEqualTo(10);
        make.height.equalTo(kWidthScale(15));
    }];
//    _nameLb.text = @"猛犸客";
    _nameLb.text = self.main_nickName;
    _nameLb.font = [UIFont systemFontOfSize:kWidthScale(15)];
    _nameLb.textColor = RGB(61, 58, 57);
    
    _accountLb = [[UILabel alloc] init];
    [_topView addSubview:_accountLb];
    [_accountLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLb.mas_left);
        make.top.equalTo(self.nameLb.mas_bottom).equalTo(13);
        make.width.greaterThanOrEqualTo(10);
        make.height.equalTo(kWidthScale(12));
    }];
    _accountLb.textColor = RGB(153, 153, 153);
    _accountLb.font = [UIFont systemFontOfSize:kWidthScale(12)];
    NSLog(@"%@", [UserInfo sharedInstance].getAccount);
    _accountLb.text = [NSString stringWithFormat:@"LINK号：%@", [UserInfo sharedInstance].getAccount];
    
    _editBtn = [[RImagButton alloc] init];
    [_topView addSubview:_editBtn];
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-22);
        make.centerY.equalTo(0);
//        make.size.equalTo(CGSizeMake(kWidthScale(20), kWidthScale(18)));
        make.size.equalTo(CGSizeMake(32, 32));
    }];
    [_editBtn setImage:[UIImage imageNamed:@"editBtn"] forState:UIControlStateNormal];
    _editBtn.imageRect = CGRectMake((32 - kWidthScale(20)) / 2, (32 - kWidthScale(18)) / 2, kWidthScale(20), kWidthScale(20));
    [_editBtn addTarget:self action:@selector(editBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    _titleLb = [[UILabel alloc] initWithFrame:CGRectMake(16, 28 + kWidthScale(84), 50, 13)];
    [self.view addSubview:_titleLb];
//    _titleLb.backgroundColor = [UIColor redColor];
    _titleLb.text = @"其他身份";
    _titleLb.font = [UIFont systemFontOfSize:12];
    _titleLb.textColor = RGB(153, 153, 153);
    
    _addBtn = [[RImagButton alloc] initWithFrame:CGRectMake(0, 400, ScreenW, 56)];
    [self.view addSubview:_addBtn];
    _addBtn.imageRect = CGRectMake((ScreenW - 20) / 2, 18, 20, 20);
    _addBtn.backgroundColor = [UIColor whiteColor];
    [_addBtn setImage:[UIImage imageNamed:@"addIdentify"] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(addBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 45  + kWidthScale(84), ScreenW - 10, kWidthScale(210))];
    [self.view addSubview:_listTableView];
    _listTableView.backgroundColor = [UIColor whiteColor];
    _listTableView.bounces = NO;
//    _listTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    [_listTableView registerClass:[SubIdentifyCell class] forCellReuseIdentifier:@"identifyCell"];
    _listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}
- (void)addBtnClicked {
//    EditIdentifyViewController *vc = [[EditIdentifyViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    AddEditIdentifyController *vc = [[AddEditIdentifyController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _usersArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kWidthScale(70);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SubIdentifyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifyCell" forIndexPath:indexPath];
    SubIdentifyModel *model = self.usersArray[indexPath.row];
    [cell.iconImg sd_setImageWithURL:[NSURL URLWithString:BDUrl_(model.headUrl)]];
    
    cell.titleLb.text = model.nickName;
    return cell;
    

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SubIdentifyModel *model = self.usersArray[indexPath.row];
    EditIdentifyViewController *vc = [[EditIdentifyViewController alloc] init];
    vc.account = model.account;
    vc.headUrl = model.headUrl;
    vc.userId = [NSString stringWithFormat:@"%@", model.ID];
    vc.nickName = model.nickName;
    NSLog(@"%@", model.sex);
    vc.sex = [NSString stringWithFormat:@"%@", [model.sex integerValue] == 0 ? @"女" : @"男"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)requestIdentifiesData {
    NSString *jmString = [NSString stringWithFormat:@"%@%@%@", BD_key, BD_secret, [UserInfo sharedInstance].getjmToken];
    NSDictionary *paramet = @{@"userId" : [UserInfo sharedInstance].getUserid, @"sign" : jmString.md5String};
    [SCNetwork postWithURLString:BDUrl_s(@"user/getAllUser") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"dic:%@", dic);
//            NSLog(@"%@", dic[@"nickName"]);
            NSArray *usersArr = dic[@"users"];
            NSDictionary *listDic = dic[@"user"];
            self.main_ID = listDic[@"id"];
            self.main_headUrl = listDic[@"headUrl"];
            self.main_account = listDic[@"account"];
            self.main_nickName = listDic[@"nickName"];
            self.main_sex = [NSString stringWithFormat:@"%@", [listDic[@"sex"] integerValue] == 0 ? @"女" : @"男"];
//            [self.iconImg sd_setImageWithURL:[NSURL URLWithString:listDic[@"headUrl"]]];
            [self creatViewlayout];
            NSLog(@"%@", usersArr[0][@"nickName"]);
            [self.usersArray removeAllObjects];
            for (NSDictionary *listDic in usersArr) {
                SubIdentifyModel *model = [[SubIdentifyModel alloc] init];
                [model setValuesForKeysWithDictionary:listDic];
                [self.usersArray addObject:model];
                [self.listTableView reloadData];
//                [self creatViewlayout];
            }
        }
    
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}

- (void)editBtnClicked {
    EditIdentifyViewController *vc = [[EditIdentifyViewController alloc] init];
    vc.account = self.main_account;
    vc.headUrl = self.main_headUrl;
    vc.userId = [NSString stringWithFormat:@"%@", self.main_ID];
    vc.nickName = self.main_nickName;
    vc.sex = self.main_sex;
    [self.navigationController pushViewController:vc animated:YES];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


@end
