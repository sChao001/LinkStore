//
//  PersonFrendListViewController.m
//  Link
//
//  Created by Surdot on 2018/5/18.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "PersonFrendListViewController.h"
#import "FrendListCell.h"
#import "FrendListModel.h"
#import "LKSessionViewController.h"


@interface PersonFrendListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *ListTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic) NSInteger count;
@property (nonatomic, strong) UILabel *tipLabel;
@end

@implementation PersonFrendListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatListTableView];
    [self.ListTableView registerClass:[FrendListCell class] forCellReuseIdentifier:@"frendList"];

    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self requestData];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.tabBarController.tabBar.hidden = YES;
    [self requestData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"9999%lu", (unsigned long)self.count);
        if (self.count == 0) {
            self.tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, ScreenW, 50)];
            [self.ListTableView addSubview:self.tipLabel];
//            tipLabel.backgroundColor = [UIColor redColor];
            self.tipLabel.text = @"当前好友列表为空\n~~~快去添加好友吧~~~";
            self.tipLabel.numberOfLines = 0;
            self.tipLabel.textAlignment = NSTextAlignmentCenter;
            self.tipLabel.textColor = RGB(119, 216, 57);
            self.tipLabel.font = [UIFont systemFontOfSize:15];
        }
    });
    
    
    
}
- (void)creatListTableView {
    self.ListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - LK_iPhoneXNavHeight-kHeightScale(181)) style:UITableViewStylePlain];
    [self.view addSubview:_ListTableView];
    self.ListTableView.delegate = self;
    self.ListTableView.dataSource = self;
    self.ListTableView.showsVerticalScrollIndicator = NO;
    self.ListTableView.backgroundColor = RGB(239, 239, 239);
    self.ListTableView.bounces = NO;
    self.ListTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"dataArrayCount:%lu", (unsigned long)_dataArray.count);
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FrendListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"frendList" forIndexPath:indexPath];
    FrendListModel *model = self.dataArray[indexPath.row];
    [cell.headerImg sd_setImageWithURL:[NSURL URLWithString:BDUrl_(model.headUrl)]];
    cell.nameLb.text = model.nickName;
    if (indexPath.row == _dataArray.count-1) {
        cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);
    }
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kWidthScale(64);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FrendListModel *model = self.dataArray[indexPath.row];
    NSLog(@"%@", model.iD);
    LKSessionViewController *sessionVC = [[LKSessionViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:[NSString stringWithFormat:@"%@",model.iD]];
    [self.navigationController pushViewController:sessionVC animated:YES];
//    self.tabBarController.tabBar.hidden = YES;
    sessionVC.title = model.nickName;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)requestData {
    NSString *jmString = [NSString stringWithFormat:@"%@%@%@", BD_key, BD_secret, [UserInfo sharedInstance].getjmToken];
    NSLog(@"==%@", [UserInfo sharedInstance].getUserid);
    NSDictionary *paramet = @{@"userId" : [UserInfo sharedInstance].getUserid, @"sign" : jmString.md5String};
    [SCNetwork postWithURLString:BDUrl_s(@"userRelation/getfriendList") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"请求成功");
            [self.dataArray removeAllObjects];
            NSArray *dicArr = dic[@"friends"];
            NSLog(@"%@", dic);
            for (NSDictionary *friendDic in dicArr) {
                FrendListModel *model = [[FrendListModel alloc] init];
                [model setValuesForKeysWithDictionary:friendDic];
                [self.dataArray addObject:model];
            }
            self.count = self.dataArray.count;
            if (self.count > 0) {
                [self.tipLabel removeFromSuperview];
            }
            [self.ListTableView reloadData];
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
