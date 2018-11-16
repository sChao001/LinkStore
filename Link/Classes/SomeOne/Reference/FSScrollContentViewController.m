//
//  FSScrollContentViewController.m
//  FSScrollViewNestTableViewDemo
//
//  Created by huim on 2017/5/23.
//  Copyright © 2017年 fengshun. All rights reserved.
//

#import "FSScrollContentViewController.h"
#import <SVPullToRefresh.h>
#import "HomeInfoModel.h"
#import "YRHomeInfoCell.h"
#import "YRHomeInfoTitleCell.h"
#import "SomeOneWebController.h"

/**
 * 随机数据
 */
#define RandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]

@interface FSScrollContentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign) BOOL fingerIsTouch;
/** 用来显示的假数据 */
@property (strong, nonatomic) NSMutableArray *data;
@property (nonatomic, assign) int pageNumber;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation FSScrollContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    self.view.backgroundColor = [UIColor whiteColor];
    _pageNumber = 1;
    [self setupSubViews];
    [self requestListData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestListData];
    NSLog(@"---%@",self.title);
}
- (void)setupSubViews
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-50-LK_iPhoneXNavHeight-LK_TabbarSafeBottomMargin) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.bounces = NO;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[YRHomeInfoCell class] forCellReuseIdentifier:@"YRCell"];
    [_tableView registerClass:[YRHomeInfoTitleCell class] forCellReuseIdentifier:@"titleCell"];
//    __weak typeof(self) weakSelf = self;
//    [self.tableView addInfiniteScrollingWithActionHandler:^{
//        [weakSelf insertRowAtBottom];
//    }];
    self.tableView.mj_header = [YGRefreshHeader headerWithRefreshingBlock:^{
        if (self.isRefresh == NO) {
            self.isRefresh = YES;
            self.pageNumber = 1;
            [self requestListData];
        }
    }];
    
    self.tableView.mj_footer = [YGRefreshFooter footerWithRefreshingBlock:^{
        if (self.isRefresh == NO) {
            self.isRefresh = YES;
            self.pageNumber++;
            [self requestListData];
        }
    }];
}
//结束刷新
- (void)endRefresh {
    self.isRefresh = NO;
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
- (void)insertRowAtTop
{
    for (int i = 0; i<5; i++) {
        [self.data insertObject:RandomData atIndex:0];
    }
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tableView reloadData];
    });
}

- (void)insertRowAtBottom
{
    for (int i = 0; i<5; i++) {
        [self.data addObject:RandomData];
    }
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tableView reloadData];
        [tableView.infiniteScrollingView stopAnimating];
    });
}

//#pragma mark Setter
//- (void)setIsRefresh:(BOOL)isRefresh
//{
//    _isRefresh = isRefresh;
//    [self insertRowAtTop];
//}

#pragma mark UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%lu", (unsigned long)_dataArray.count);
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return 50;
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    HomeInfoModel *model = self.dataArray[indexPath.row];
//    YRHomeInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YRCell" forIndexPath:indexPath];
//    cell.titleLb.text = model.title;
//    [cell.InfoImageView sd_setImageWithURL:[NSURL URLWithString:BDUrl_(model.titleImageUrl)] placeholderImage:[UIImage imageNamed:@"y_infoPlace"]];
    
    UITableViewCell *cell = nil;
    HomeInfoModel *model = self.dataArray[indexPath.row];
    NSLog(@"%@", model.contentImageNumber);
    
    cell.backgroundColor = [UIColor clearColor];
    if ([model.contentImageNumber integerValue] == 0) {
        YRHomeInfoTitleCell *titleCell = [tableView dequeueReusableCellWithIdentifier:@"titleCell" forIndexPath:indexPath];
        titleCell.titleLb.text = model.title;
        titleCell.countLb.text = [NSString stringWithFormat:@"%@", model.readNumber];
        titleCell.addressLb.text = model.address;
        cell = titleCell;
    }else {
        YRHomeInfoCell *ImgCell = [tableView dequeueReusableCellWithIdentifier:@"YRCell" forIndexPath:indexPath];
        ImgCell.titleLb.text = model.title;
        ImgCell.countLb.text = [NSString stringWithFormat:@"%@", model.readNumber];
        ImgCell.addressLb.text = model.address;
        [ImgCell.InfoImageView sd_setImageWithURL:[NSURL URLWithString:BDUrl_(model.titleImageUrl)] placeholderImage:[UIImage imageNamed:@"y_infoPlace"]];
        cell = ImgCell;
    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    HomeInfoModel *model = self.dataArray[indexPath.row];
    SomeOneWebController *vc = [[SomeOneWebController alloc] init];
    vc.idStr = [NSString stringWithFormat:@"%@", model.iD];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark UIScrollView
//判断屏幕触碰状态
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    DebugLog(@"接触屏幕");
    self.fingerIsTouch = YES;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
//    DebugLog(@"离开屏幕");
    self.fingerIsTouch = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.vcCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    if (scrollView.contentOffset.y <= 0) {
//        if (!self.fingerIsTouch) {//这里的作用是在手指离开屏幕后也不让显示主视图，具体可以自己看看效果
//            return;
//        }
        self.vcCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTop" object:nil];//到顶通知父视图改变状态
    }
    self.tableView.showsVerticalScrollIndicator = _vcCanScroll?YES:NO;
}

#pragma mark LazyLoad

+ (UIColor*) randomColor{
    NSInteger r = arc4random() % 255;
    NSInteger g = arc4random() % 255;
    NSInteger b = arc4random() % 255;
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
}
- (NSMutableArray *)data
{
    if (!_data) {
        self.data = [NSMutableArray array];
        for (int i = 0; i<5; i++) {
            [self.data addObject:RandomData];
        }
    }
    return _data;
}
- (void)requestListData {
    NSLog(@"%d", _pageNumber);
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"pageNo" : [NSString stringWithFormat:@"%d", _pageNumber], @"labelName" : @"", @"rootNodeId" : @""};
    [SCNetwork postWithURLString:BDUrl_s(@"community/getCommunityList") parameters:paramet success:^(NSDictionary *dic) {
        if (self.pageNumber == 1) {
            [self.dataArray removeAllObjects];
        }
        if ([dic[@"code"] integerValue] >0) {
            NSArray *array = dic[@"communities"];
            for (NSDictionary *lisDic in array) {
                HomeInfoModel *model = [[HomeInfoModel alloc] init];
                [model setValuesForKeysWithDictionary:lisDic];
                [self.dataArray addObject:model];
            }
            NSLog(@"%ld", self.dataArray.count);
            [self.tableView reloadData];
            [self endRefresh];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络加载失败，检查网络"];
        [SVProgressHUD dismissWithDelay:0.7];
        [self endRefresh];
    }];
}
@end
