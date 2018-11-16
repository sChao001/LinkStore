//
//  YRInfomationViewController.m
//  Link
//
//  Created by Surdot on 2018/7/9.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "YRInfomationViewController.h"
#import "HomeInfoModel.h"
#import "YRHomeInfoCell.h"
#import "SomeOneWebController.h"

@interface YRInfomationViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation YRInfomationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(245, 245, 245);
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self creatMyTableView];
    [self requestDataList];
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
    [_listTableView registerClass:[YRHomeInfoCell class] forCellReuseIdentifier:@"listCell"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%ld", _dataArray.count);
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeInfoModel *model = self.dataArray[indexPath.row];
    YRHomeInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell" forIndexPath:indexPath];
    cell.titleLb.text = model.title;
    [cell.InfoImageView sd_setImageWithURL:[NSURL URLWithString:BDUrl_(model.titleImageUrl)] placeholderImage:[UIImage imageNamed:@"y_infoPlace"]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeInfoModel *model = self.dataArray[indexPath.row];
    SomeOneWebController *vc = [[SomeOneWebController alloc] init];
    vc.idStr = [NSString stringWithFormat:@"%@", model.iD];
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}
- (void)requestDataList {
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"labelName" : @"红烧臭鳜鱼"};
    [SCNetwork postWithURLString:BDUrl_s(@"friendhome/search") parameters:paramet success:^(NSDictionary *dic) {
        [self.dataArray removeAllObjects];
        if ([dic[@"code"] integerValue] > 0) {
            NSArray *array = dic[@"communities"];
            for (NSDictionary *listDic in array) {
                HomeInfoModel *model = [[HomeInfoModel alloc] init];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
