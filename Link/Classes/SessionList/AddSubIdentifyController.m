//
//  AddSubIdentifyController.m
//  Link
//
//  Created by Surdot on 2018/5/29.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "AddSubIdentifyController.h"
#import "EditIdentifyViewController.h"

@interface AddSubIdentifyController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *accountLb;
@property (nonatomic, strong) UIButton *editBtn;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) RImagButton *addBtn;
@property (nonatomic, strong) UITableView *listTableView;
@end

@implementation AddSubIdentifyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(239, 239, 239);
    [self creatViewlayout];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}
- (void)creatViewlayout {
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 13 +LK_iPhoneXNavHeight, ScreenW, kWidthScale(84))];
    [self.view addSubview:_topView];
    _topView.backgroundColor = [UIColor whiteColor];
    
    _iconImg = [[UIImageView alloc] init];
    [_topView addSubview:_iconImg];
    [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(kWidthScale(67), kWidthScale(67)));
        make.centerY.equalTo(0);
        make.left.equalTo(kWidthScale(16));
    }];
    _iconImg.backgroundColor = [UIColor brownColor];
    
    _nameLb = [[UILabel alloc] init];
    [_topView addSubview:_nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg.mas_right).equalTo(7);
        make.top.equalTo(kWidthScale(21));
        make.width.greaterThanOrEqualTo(10);
        make.height.equalTo(kWidthScale(15));
    }];
    _nameLb.text = @"猛犸客";
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
    _accountLb.text = @"LINK号：1234556664";
    
    _editBtn = [[UIButton alloc] init];
    [_topView addSubview:_editBtn];
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-22);
        make.centerY.equalTo(0);
        make.size.equalTo(CGSizeMake(kWidthScale(20), kWidthScale(18)));
    }];
    [_editBtn setImage:[UIImage imageNamed:@"editBtn"] forState:UIControlStateNormal];
    
    _titleLb = [[UILabel alloc] initWithFrame:CGRectMake(16, 28 +LK_iPhoneXNavHeight + kWidthScale(84), 50, 13)];
    [self.view addSubview:_titleLb];
//    _titleLb.backgroundColor = [UIColor redColor];
    _titleLb.text = @"其他身份";
    _titleLb.font = [UIFont systemFontOfSize:12];
    _titleLb.textColor = RGB(153, 153, 153);
    
    _addBtn = [[RImagButton alloc] initWithFrame:CGRectMake(0, 400, ScreenW, 56)];
    [self.view addSubview:_addBtn];
    _addBtn.imageRect = CGRectMake((ScreenW - 20) / 2, 18, 20, 20);
    _addBtn.backgroundColor = [UIColor whiteColor];
    [_addBtn setImage:[UIImage imageNamed:@"addBtnSele"] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(addBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45 +LK_iPhoneXNavHeight + kWidthScale(84), ScreenW, kWidthScale(210))];
    [self.view addSubview:_listTableView];
    _listTableView.backgroundColor = [UIColor whiteColor];
    _listTableView.bounces = NO;
    _listTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
}
- (void)addBtnClicked {
    EditIdentifyViewController *vc = [[EditIdentifyViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    
//}

- (void)requestIdentifiesData {
    NSDictionary *paramet = @{@"userId" : [UserInfo sharedInstance].getUserid};
    [SCNetwork postWithURLString:BDUrl_(@"user/getAllUser") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"dic:%@", dic);
        }
    
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
