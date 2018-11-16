//
//  LabelsTypeInfoOneController.m
//  Link
//
//  Created by Surdot on 2018/7/4.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "LabelsTypeInfoOneController.h"
#import "HomeInfoModel.h"
#import "YRHomeInfoCell.h"
#import "SomeOneWebController.h"

@interface LabelsTypeInfoOneController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) int pageNumber;
@property (nonatomic, assign) BOOL isRefresh;
@end

@implementation LabelsTypeInfoOneController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
//    self.view.backgroundColor = [ColorHex(@"adadad") colorWithAlphaComponent:0.2];
    [self creatTableView];
    [self requestListTableViewData];
}

- (void)creatTableView {
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-LK_iPhoneXNavHeight-18-kWidthScale(22.5)-49) style:UITableViewStylePlain];
    [self.view addSubview:_listTableView];
    _listTableView.backgroundColor = [ColorHex(@"adadad") colorWithAlphaComponent:0.2];
    _listTableView.scrollEnabled = NO;
    _listTableView.bounces = NO;
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    [_listTableView registerClass:[YRHomeInfoCell class] forCellReuseIdentifier:@"cellList"];
    _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    self.listTableView.mj_header = [YGRefreshHeader headerWithRefreshingBlock:^{
        if (self.isRefresh == NO) {
            self.isRefresh = YES;
            self.pageNumber = 1;
            [self requestListTableViewData];
        }
    }];
    
    self.listTableView.mj_footer = [YGRefreshFooter footerWithRefreshingBlock:^{
        if (self.isRefresh == NO) {
            self.isRefresh = YES;
            self.pageNumber++;
            [self requestListTableViewData];
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
    HomeInfoModel *model = self.dataArray[indexPath.row];
    YRHomeInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellList" forIndexPath:indexPath];
    cell.titleLb.text = model.title;
//    [cell.InfoImageView sd_setImageWithURL:[NSURL URLWithString:BDUrl_(model.titleImageUrl)]];
    [cell.InfoImageView sd_setImageWithURL:[NSURL URLWithString:BDUrl_(model.titleImageUrl)] placeholderImage:[UIImage imageNamed:@"y_infoPlace"]];
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeInfoModel *model = self.dataArray[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SomeOneWebController *vc = [[SomeOneWebController alloc] init];
    vc.idStr = [NSString stringWithFormat:@"%@", model.iD];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
  
}
- (void)requestListTableViewData {
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"pageNo" : [NSString stringWithFormat:@"%d", _pageNumber]};
    [SCNetwork postWithURLString:BDUrl_s(@"community/getCommunityList") parameters:paramet success:^(NSDictionary *dic) {
        if (self.pageNumber == 1) {
            [self.dataArray removeAllObjects];
        }
        
        if ([dic[@"code"] integerValue] > 0) {
            NSArray *array = dic[@"communities"];
            for (NSDictionary *lisDic in array) {
                HomeInfoModel *model = [[HomeInfoModel alloc] init];
                [model setValuesForKeysWithDictionary:lisDic];
                [self.dataArray addObject:model];
            }
            [self.listTableView reloadData];
            [self endRefresh];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络出问题了哦~"];
        [SVProgressHUD dismissWithDelay:0.7];
        [self endRefresh];
    }];
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"家具");
////    if (scrollView.contentOffset.y > ScreenH) {
////        _listTableView.scrollEnabled = NO;
////    }
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
