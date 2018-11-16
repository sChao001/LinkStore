//
//  MerchantsReceiveOfNotifiController.m
//  Link
//
//  Created by Surdot on 2018/9/13.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "MerchantsReceiveOfNotifiController.h"
#import "ReceiveMoneyModel.h"
#import "ReceiveMoneyCell.h"
#import "DetialMoneyController.h"

@interface MerchantsReceiveOfNotifiController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *totalLb;
@property (nonatomic, strong) UILabel *priceTotalLb;
@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *entityArray;
@property (nonatomic, assign) int pageNumber;
@property (nonatomic, assign) BOOL isRefresh;
@end

@implementation MerchantsReceiveOfNotifiController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setMyNavigationBarShowOfImage];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self setMyNavigationBarHidden];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收款记录";
    //    _pageNumber = 1;
    self.view.backgroundColor = ColorHex(@"f5f5f2");
    [self setCommonLeftBarButtonItem];
    [self configLayoutOfTableView];
    [self requestBillList];
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
}
- (void)leftBarItemBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)configLayoutOfTableView {
    _topView = [[UIView alloc] initWithFrame:CGRectMake(8, LK_iPhoneXNavHeight+5, ScreenW - 16, kWidthScale(160))];
    [self.view addSubview:_topView];
    _topView.backgroundColor = ColorHex(@"ffffff");
    
    _totalLb = [[UILabel alloc] init];
    [_topView addSubview:_totalLb];
    [_totalLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kWidthScale(25));
        make.centerX.equalTo(0);
        make.width.greaterThanOrEqualTo(10);
    }];
    _totalLb.font = [UIFont systemFontOfSize:kWidthScale(15)];
    _totalLb.textColor = ColorHex(@"282828");
    _totalLb.text = @"收入总金额";
    
    _priceTotalLb = [[UILabel alloc] init];
    [_topView addSubview:_priceTotalLb];
    [_priceTotalLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(kWidthScale(90));
        make.width.greaterThanOrEqualTo(10);
    }];
    _priceTotalLb.font = [UIFont systemFontOfSize:kWidthScale(25)];
    _priceTotalLb.textColor = ColorHex(@"282828");
    _priceTotalLb.text = @"￥";
    
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, LK_iPhoneXNavHeight + kWidthScale(160), ScreenW, ScreenH-LK_iPhoneXNavHeight-LK_TabbarSafeBottomMargin - kWidthScale(160)) style:UITableViewStylePlain];
    [self.view addSubview:_listTableView];
    _listTableView.backgroundColor = ColorHex(@"f5f5f2");
    //    _listTableView.bounces = NO;
    _listTableView.tableFooterView = [[UIView alloc] init];
    _listTableView.dataSource = self;
    _listTableView.delegate = self;
    [_listTableView registerClass:[ReceiveMoneyCell class] forCellReuseIdentifier:@"cell"];
    _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.listTableView.mj_header = [YGRefreshHeader headerWithRefreshingBlock:^{
        if (self.isRefresh == NO) {
            self.isRefresh = YES;
            self.pageNumber = 1;
            [self requestBillList];
        }
    }];
    self.listTableView.mj_footer = [YGRefreshFooter footerWithRefreshingBlock:^{
        if (self.isRefresh == NO) {
            self.isRefresh = YES;
            self.pageNumber++;
            [self requestBillList];
        }
    }];
}
//结束刷新
- (void)endRefresh {
    self.isRefresh = NO;
    [self.listTableView.mj_header endRefreshing];
    [self.listTableView.mj_footer endRefreshing];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReceiveMoneyModel *model = self.dataArray[indexPath.row];
    ReceiveMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.nameLb.text = model.userEntity[@"nickName"];
    cell.moneyLb.text = [NSString stringWithFormat:@"%@", model.moneyStr];
    cell.payLb.text = model.typeName;
    cell.timeLb.text = model.createTime;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ReceiveMoneyModel *model = self.dataArray[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetialMoneyController *vc = [[DetialMoneyController alloc] init];
    vc.payId = [NSString stringWithFormat:@"%@", model.Id];
    vc.nameTitle = model.userEntity[@"nickName"];
    vc.moneyStr = [NSString stringWithFormat:@"%@", model.moneyStr];
    vc.myType = model.typeName;
    vc.myTradeTime = [NSString stringWithFormat:@"%@", model.createTime];
    vc.myTradeNo = [NSString stringWithFormat:@"%@", model.code];
    [self.navigationController pushViewController:vc animated:YES];
}
//账单列表
- (void)requestBillList {
    NSLog(@"%d", _pageNumber);
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"pageNo" : [NSString stringWithFormat:@"%d", _pageNumber]};
    [SCNetwork postWithURLString:BDUrl_s(@"payhistory/getPayHistoryListByUserId") parameters:paramet success:^(NSDictionary *dic) {
        NSLog(@"%@", dic);
        if (self.pageNumber == 1) {
            [self.dataArray removeAllObjects];
        }
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"%@", dic);
            self.priceTotalLb.text = [NSString stringWithFormat:@"￥%@", dic[@"countMoney"]];
            NSArray *arrayList = dic[@"payHistories"];
            //            ReceiveMoneyEntityModel *model = [[ReceiveMoneyEntityModel alloc] init];
            //            model setValuesForKeysWithDictionary:dic[@"payHistories"]
            for (NSDictionary *dicList in arrayList) {
                ReceiveMoneyModel *model = [[ReceiveMoneyModel alloc] init];
                [model setValuesForKeysWithDictionary:dicList];
                [self.dataArray addObject:model];
            }
            [self.listTableView reloadData];
            [self endRefresh];
            
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败"];
        [SVProgressHUD dismissWithDelay:0.7];
        [self endRefresh];
    }];
}

@end
