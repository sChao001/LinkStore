//
//  GroupListViewController.m
//  Link
//
//  Created by Surdot on 2018/5/18.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "GroupListViewController.h"
#import "GroupListModel.h"
#import "FrendListCell.h"
#import "LKSessionViewController.h"

@interface GroupListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *groupListTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic) NSInteger count;
@property (nonatomic, strong) UILabel *tipLabel;
@end

@implementation GroupListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatListTableView];
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self requestData];
    [_groupListTableView registerClass:[FrendListCell class] forCellReuseIdentifier:@"frendList"];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"9999%lu", (unsigned long)self.count);
        if (self.count == 0) {
            UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, ScreenW, 50)];
            [self.groupListTableView addSubview:tipLabel];
            //            tipLabel.backgroundColor = [UIColor redColor];
            self.tipLabel.text = @"~~~群聊空空如也~~~";
            self.tipLabel.numberOfLines = 0;
            self.tipLabel.textAlignment = NSTextAlignmentCenter;
            self.tipLabel.textColor = RGB(119, 216, 57);
            self.tipLabel.font = [UIFont systemFontOfSize:15];
        }
    });
}
- (void)creatListTableView {
    self.groupListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - LK_iPhoneXNavHeight-kHeightScale(181)) style:UITableViewStylePlain];
    [self.view addSubview:_groupListTableView];
    self.groupListTableView.delegate = self;
    self.groupListTableView.dataSource = self;
    self.groupListTableView.showsVerticalScrollIndicator = NO;
    self.groupListTableView.backgroundColor = RGB(239, 239, 239);
    self.groupListTableView.bounces = NO;
    self.groupListTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GroupListModel *model = self.dataArray[indexPath.row];
    FrendListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"frendList" forIndexPath:indexPath];
    cell.nameLb.text = model.name;
    if (indexPath.row == _dataArray.count-1) {
        cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);
    }
    
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kWidthScale(64);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GroupListModel *model = self.dataArray[indexPath.row];
    LKSessionViewController *sessionVc = [[LKSessionViewController alloc] initWithConversationType:ConversationType_GROUP targetId:[NSString stringWithFormat:@"%@", model.groupid]];
    sessionVc.title = model.name;
    [self.navigationController pushViewController:sessionVc animated:YES];
//    self.tabBarController.tabBar.hidden = YES;
}
- (void)requestData {
    NSLog(@"==%@", [UserInfo sharedInstance].getUserid);
    NSString *jmString = [NSString stringWithFormat:@"%@%@%@", BD_key, BD_secret, [UserInfo sharedInstance].getjmToken];
    NSDictionary *paramet = @{@"userId" : [UserInfo sharedInstance].getUserid, @"sign" : jmString.md5String};
    [SCNetwork postWithURLString:BDUrl_s(@"group/get") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"请求群组成功");
            NSLog(@"group:%@", dic);
            [self.dataArray removeAllObjects];
            NSArray *dicArr = dic[@"groups"];
            
            for (NSDictionary *groupDic in dicArr) {
                GroupListModel *model = [[GroupListModel alloc] init];
                [model setValuesForKeysWithDictionary:groupDic];
                [self.dataArray addObject:model];
            }
            self.count = self.dataArray.count;
            if (self.count > 0) {
                [self.tipLabel removeFromSuperview];
            }
            [self.groupListTableView reloadData];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"请求失败，请查看网络"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
