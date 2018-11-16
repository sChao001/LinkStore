//
//  HistoryInfoViewController.m
//  Link
//
//  Created by Surdot on 2018/6/29.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "HistoryInfoViewController.h"
#import "HistoryInfoCell.h"
#import "HistoryPublishModel.h"
#import "NewsWebViewController.h"

@interface HistoryInfoViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation HistoryInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBarButtonWithNorImgName:@"y_back"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"发布历史";
    [self creatMyTableView];
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self requestDataList];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)creatMyTableView {
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStylePlain];
    [self.view addSubview:_listTableView];
    _listTableView.backgroundColor = RGB(245, 245, 245);
    _listTableView.bounces = NO;
    _listTableView.tableFooterView = [[UIView alloc] init];
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    [_listTableView registerClass:[HistoryInfoCell class] forCellReuseIdentifier:@"HistoryCell"];
    [[UITableView appearance] setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%lu", (unsigned long)_dataArray.count);
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HistoryPublishModel *model = self.dataArray[indexPath.row];
    HistoryInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryCell" forIndexPath:indexPath];
    cell.titleLb.text = model.title;
    NSInteger a = [model.createTime integerValue] / 1000;
    cell.timeLb.text = [CommentTool dayWithTimeIntervalOfHours:a];
    cell.publishStateLb.text = model.auditStateValue;
    if (indexPath.row == 4) {
        cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HistoryPublishModel *model = self.dataArray[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NewsWebViewController *vc = [[NewsWebViewController alloc] init];
    vc.webUrlStr = model.url;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)requestDataList {
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid};
    [SCNetwork postWithURLString:BDUrl_s(@"usernews/getUserNewsList") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSArray *arrayList = dic[@"usernewes"];
            for (NSDictionary *listDic in arrayList) {
                HistoryPublishModel *model = [[HistoryPublishModel alloc] init];
                [model setValuesForKeysWithDictionary:listDic];
                [self.dataArray addObject:model];
            }
            [self.listTableView reloadData];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败"];
        [SVProgressHUD dismissWithDelay:0.6];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}



@end
