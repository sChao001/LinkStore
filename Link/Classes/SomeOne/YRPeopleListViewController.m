//
//  YRPeopleListViewController.m
//  Link
//
//  Created by Surdot on 2018/7/9.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "YRPeopleListViewController.h"
#import "HomeInfoModel.h"
//#import "YRHomeInfoCell.h"
#import "FrendListCell.h"
#import "YRHomeUserCell.h"
#import "YRSearchViewController.h"

@interface YRPeopleListViewController ()<UITableViewDelegate, UITableViewDataSource, YRSearchViewControllerDelegate>
@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation YRPeopleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(245, 245, 245);
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self creatMyTableView];
    [self requestDataList];
    YRSearchViewController *vc = [[YRSearchViewController alloc] init];
    vc.delegate = self;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestDataList];
}
- (void)creatMyTableView {
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - LK_iPhoneXNavHeight - 40) style:UITableViewStylePlain];
    [self.view addSubview:_listTableView];
    _listTableView.backgroundColor = [ColorHex(@"adadad") colorWithAlphaComponent:0.2];
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    _listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [_listTableView registerClass:[YRHomeUserCell class] forCellReuseIdentifier:@"listCell"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%ld", _dataArray.count);
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeInfoUserModel *model = self.dataArray[indexPath.row];
    YRHomeUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell" forIndexPath:indexPath];
    
    cell.titleLb.text = model.nickName;
    [cell.headerView sd_setImageWithURL:[NSURL URLWithString:BDUrl_(model.headUrl)]];
//    cell.titleLb.text = model.title;
//    [cell.InfoImageView sd_setImageWithURL:[NSURL URLWithString:BDUrl_(model.titleImageUrl)] placeholderImage:[UIImage imageNamed:@"y_infoPlace"]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
#pragma delegate
- (void)searchText:(NSString *)string {
    NSLog(@"%@", string);
}
- (void)requestDataList {
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"labelName" : @"红烧臭鳜鱼"};
    [SCNetwork postWithURLString:BDUrl_s(@"friendhome/search") parameters:paramet success:^(NSDictionary *dic) {
        [self.dataArray removeAllObjects];
        if ([dic[@"code"] integerValue] > 0) {
            NSArray *array = dic[@"users"];
            for (NSDictionary *listDic in array) {
                HomeInfoUserModel *model = [[HomeInfoUserModel alloc] init];
                [model setValuesForKeysWithDictionary:listDic];
                [self.dataArray addObject:model];
            }
            NSLog(@"%ld", self.dataArray.count);
            [self.listTableView reloadData];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络加载失败"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
