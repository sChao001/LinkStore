//
//  SearchAndAddFriendController.m
//  Link
//
//  Created by Surdot on 2018/5/21.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "SearchAndAddFriendController.h"
#import "FrendListCell.h"
#import "SearchInfoModel.h"
#import "PersonIntroViewController.h"

@interface SearchAndAddFriendController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *searchView;
@property (nonatomic, strong) UIImageView *searchImg;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) UITableView *searchListTableview;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSString *iconUrlString;

//zuixin
@property (nonatomic, strong) UIButton *searchImgBtn;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *sureSearchbtn;
@property (nonatomic, strong) UITextField *inputTextFd;
@end

@implementation SearchAndAddFriendController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ColorHex(@"f3f3f3");
    [self setCommonLeftBarButtonItem];
    [self creaTableView];
    [self creatMyAlertlabel];
    [self searchViewLayout];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

//    [_searchView removeFromSuperview];
}

//- (void)setSearchView {
//    _searchView = [[UIView alloc] init];
//    [self.navigationController.navigationBar addSubview:_searchView];
//    [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(0);
//        make.left.equalTo(45);
//        make.right.equalTo(-15);
//        make.height.equalTo(30);
//    }];
//    _searchView.backgroundColor = RGB(170, 169, 169);
//
//    _searchImg = [[UIImageView alloc] init];
//    [_searchView addSubview:_searchImg];
//    [_searchImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(15);
//        make.centerY.equalTo(0);
//        make.size.equalTo(CGSizeMake(18, 18));
//    }];
//    _searchImg.image = [UIImage imageNamed:@"search_gray"];
//
//    _searchTextField = [[UITextField alloc] init];
//    [_searchView addSubview:_searchTextField];
//    [_searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.searchImg.mas_right).equalTo(0);
//        make.top.bottom.equalTo(0);
//        make.right.equalTo(-30);
//    }];
////    _searchTextField.backgroundColor = [UIColor redColor];
//    _searchTextField.placeholder = @"搜索账号";
//
//    _searchBtn = [[UIButton alloc] init];
//    [_searchView addSubview:_searchBtn];
//    [_searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.searchTextField.mas_right);
//        make.top.right.bottom.equalTo(0);
//    }];
////    _searchBtn.backgroundColor = [UIColor yellowColor];
//    [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
//    _searchBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//    [_searchBtn addTarget:self action:@selector(searchBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//}
- (void)searchViewLayout {
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(8, 56, ScreenW-16, 1)];
    [self.view addSubview:_lineView];
    _lineView.backgroundColor = ColorHex(@"d2d2d2");
    
    _searchImgBtn = [[UIButton alloc] init];
    [self.view addSubview:_searchImgBtn];
    [_searchImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(8);
        make.top.equalTo(20);
        make.size.equalTo(CGSizeMake(29, 29));
    }];
    [_searchImgBtn setImage:[UIImage imageNamed:@"y_addFriend"] forState:UIControlStateNormal];
    
    _sureSearchbtn = [[UIButton alloc] init];
    [self.view addSubview:_sureSearchbtn];
    [_sureSearchbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-15);
        make.bottom.equalTo(self.lineView.mas_top).equalTo(-11);
        make.size.equalTo(CGSizeMake(40, 20));
    }];
//    _sureSearchbtn.backgroundColor = [UIColor cyanColor];
    [_sureSearchbtn setTitle:@"搜索" forState:UIControlStateNormal];
    [_sureSearchbtn setTitleColor:ColorHex(@"282828") forState:UIControlStateNormal];
    _sureSearchbtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [_sureSearchbtn addTarget:self action:@selector(searchBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    _inputTextFd = [[UITextField alloc] init];
    [self.view addSubview:_inputTextFd];
    [_inputTextFd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchImgBtn.mas_right).equalTo(20);
        make.right.equalTo(self.sureSearchbtn.mas_left).equalTo(-20);
        make.centerY.equalTo(self.searchImgBtn);
        make.height.equalTo(29);
    }];
//    _inputTextFd.textColor = ColorHex(@"f8b651");
    _inputTextFd.textColor = ColorHex(@"282828");
    _inputTextFd.font = [UIFont systemFontOfSize:17];
    _inputTextFd.placeholder = @"请输入账号搜索";
    _inputTextFd.keyboardType = UIKeyboardTypeNumberPad;
    
}
- (void)searchBtnClicked:(UIButton *)sender {
    if ([CommentTool isBlankString:_inputTextFd.text] || _inputTextFd.text.length < 8) {
        [self alertShowWithTitle:@"请输入正确的账号"];
        return;
    }
    [SVProgressHUD show];
    NSLog(@"%@---%@", _searchTextField.text, [UserInfo sharedInstance].getUserid);
    NSString *jmString = [NSString stringWithFormat:@"%@%@%@", BD_key, BD_secret, [UserInfo sharedInstance].getjmToken];
    NSDictionary *paramet = @{@"account" : _inputTextFd.text, @"userId" : [UserInfo sharedInstance].getUserid, @"sign" : jmString.md5String};
    [SCNetwork postWithURLString:BDUrl_s(@"user/get") parameters:paramet success:^(NSDictionary *dic) {
        [self.dataArray removeAllObjects];
        if ([dic[@"code"] integerValue] > 0) {
            self.status = dic[@"status"];
            [SVProgressHUD dismissWithDelay:0.6];
            NSDictionary *userDic = dic[@"user"];
            self.iconUrlString = userDic[@"headUrl"];
            SearchInfoModel *model = [[SearchInfoModel alloc] init];
            [model setValuesForKeysWithDictionary:userDic];
            [self.dataArray addObject:model];
            [self.searchListTableview reloadData];
            NSLog(@"dic:%@", dic);
            
        }else {
            [SVProgressHUD showWithStatus:dic[@"result"]];
            [SVProgressHUD dismissWithDelay:0.7];
        }
    
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络请求失败，检查网络"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}

- (void)creaTableView {
    self.searchListTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, ScreenW, ScreenH) style:UITableViewStylePlain];
    [self.view addSubview:_searchListTableview];
    _searchListTableview.backgroundColor = ColorHex(@"f3f3f3");
    self.searchListTableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.searchListTableview registerClass:[FrendListCell class] forCellReuseIdentifier:@"frendList"];
    self.searchListTableview.delegate = self;
    self.searchListTableview.dataSource = self;
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchInfoModel *model = self.dataArray[indexPath.row];
    FrendListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"frendList" forIndexPath:indexPath];
    cell.nameLb.text = model.nickName;
    [cell.headerImg sd_setImageWithURL:[NSURL URLWithString:BDUrl_(_iconUrlString)]];
    if (indexPath.row == _dataArray.count-1) {
        cell.separatorInset = UIEdgeInsetsMake(0, cell.frame.size.width, 0, 0);
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kWidthScale(64);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchInfoModel *model = self.dataArray[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PersonIntroViewController *vc = [[PersonIntroViewController alloc] init];
    vc.headerStr = model.headUrl;
    vc.naameStr = model.nickName;
    vc.accountStr = model.account;
    vc.friendId = [NSString stringWithFormat:@"%@", model.ID];
    vc.status = _status;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
