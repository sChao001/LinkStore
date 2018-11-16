//
//  LKConnecterViewController.m
//  Link
//
//  Created by Surdot on 2018/4/18.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "LKConnecterViewController.h"
#import "SignTypeModel.h"
#import "ShowNewsModel.h"
#import "NewsTitleCell.h"
#import "NewsImageOneCell.h"
#import "NewsImgThreeCell.h"
#import "NewsWebViewController.h"

@interface LKConnecterViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *navigationView;
@property (nonatomic, strong) NSMutableArray *signArray;
@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, strong) NSString *signString;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *listNewsTableView;
@property (nonatomic, assign) int pageNumber;
@property (nonatomic, assign) BOOL isRefresh;

@end

@implementation LKConnecterViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(245, 245, 245);
    self.signArray = [NSMutableArray arrayWithCapacity:0];
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self setMyNavigationBarShowOfImage];
    [self crearListNewsTableView];
    if (![UserDefault boolForKey:@"SecondLogin"]) {
        [self touristsRequestMessageContentOfData];
    }else {
        [self requestMessageContentOfData];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
//自定义导航栏
- (void)setNavigationCustomBarView {
    [self setMyNavigationBarClear];
    _navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, LK_iPhoneXNavHeight)];
    [self.view addSubview:_navigationView];
    _navigationView.backgroundColor = [UIColor purpleColor];
}

- (instancetype)initWithMsgType:(NSInteger)msgType {
    self = [super init];
    if (self) {
        _pageCount = msgType;
        NSLog(@"msgType:%ld", (long)msgType);
    }
    return self;
}
- (instancetype)initWithMessageType:(id)msgType{
    self = [super init];
    if (self) {
        _signString = msgType;
        NSLog(@"myString:%@", _signString);
    }
    return self;
}

- (void)requestMessageContentOfData {
    NSLog(@"%@", _signString);
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"labelName" : @"推荐", @"pageNo" : [NSString stringWithFormat:@"%d", _pageNumber], @"pageSize" : @"10"};
    [SCNetwork postWithURLString:BDUrl_s(@"news/getNewsList") parameters:paramet success:^(NSDictionary *dic) {
        NSLog(@"%@", dic);
        if (self.pageNumber == 1) {
            [self.dataArray removeAllObjects];
        }
        NSArray *newsArr = dic[@"newes"];
        for (NSDictionary *listDic in newsArr) {
            ShowNewsModel *model = [[ShowNewsModel alloc] init];
            [model setValuesForKeysWithDictionary:listDic];
            [self.dataArray addObject:model];
        }
        [self.listNewsTableView reloadData];
        [self endRefresh];
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
        [SVProgressHUD dismissWithDelay:0.7];
        [self endRefresh];
    }];
}

- (void)requestChangeMessageData {
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"pageNo" : [NSString stringWithFormat:@"%d", _pageNumber]};
    [SCNetwork postWithURLString:BDUrl_s(@"knownews/getKnowNewsList") parameters:paramet success:^(NSDictionary *dic) {
        if (self.pageNumber == 1) {
            [self.dataArray removeAllObjects];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
        [SVProgressHUD dismissWithDelay:0.7];
        [self endRefresh];
    }];
}

- (void)touristsRequestMessageContentOfData {
    NSLog(@"%@", _signString);
    NSDictionary *paramet = @{@"sign" : Un_LogInSign.md5String, @"labelName" : _signString, @"pageNo" : [NSString stringWithFormat:@"%d", _pageNumber], @"pageSize" : @"10"};
    [SCNetwork postWithURLString:BDUrl_s(@"news/getNewsList") parameters:paramet success:^(NSDictionary *dic) {
        NSLog(@"%@", dic);
        if (self.pageNumber == 1) {
            [self.dataArray removeAllObjects];
        }
        NSArray *newsArr = dic[@"newes"];
        for (NSDictionary *listDic in newsArr) {
            ShowNewsModel *model = [[ShowNewsModel alloc] init];
            [model setValuesForKeysWithDictionary:listDic];
            [self.dataArray addObject:model];
        }
        [self.listNewsTableView reloadData];
        [self endRefresh];
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
        [SVProgressHUD dismissWithDelay:0.7];
        [self endRefresh];
    }];
}

- (void)crearListNewsTableView {                                                                   //63
    self.listNewsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, LK_iPhoneXNavHeight, ScreenW, ScreenH - 49 - LK_iPhoneXNavHeight) style:UITableViewStylePlain];
    [self.view addSubview:_listNewsTableView];
    _listNewsTableView.delegate = self;
    _listNewsTableView.dataSource = self;
    [_listNewsTableView registerClass:[NewsImageOneCell class] forCellReuseIdentifier:@"NewsCell"];
    [_listNewsTableView registerClass:[NewsTitleCell class] forCellReuseIdentifier:@"titleCell"];
    [_listNewsTableView registerClass:[NewsImgThreeCell class] forCellReuseIdentifier:@"threeCell"];
    
    
//    UIView * footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 30+15)];
//    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, ScreenW, 15)];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.textColor = RGB(159, 159, 159);
//    label.font = [UIFont systemFontOfSize:15];
//    label.text = @"~ 没有数据了 ~";
//    [footerView addSubview: label];
//    self.listNewsTableView.tableFooterView = footerView;
    
    self.listNewsTableView.mj_header = [YGRefreshHeader headerWithRefreshingBlock:^{
        if (self.isRefresh == NO) {
            self.isRefresh = YES;
            self.pageNumber = 1;
            if (![UserDefault boolForKey:@"SecondLogin"]) {
                [self touristsRequestMessageContentOfData];
            }else {
                [self requestMessageContentOfData];
            }
        }
    }];
    
    self.listNewsTableView.mj_footer = [YGRefreshFooter footerWithRefreshingBlock:^{
        if (self.isRefresh == NO) {
            self.isRefresh = YES;
            self.pageNumber++;
            if (![UserDefault boolForKey:@"SecondLogin"]) {
                [self touristsRequestMessageContentOfData];
            }else {
                [self requestMessageContentOfData];
            }
        }
    }];
}
//结束刷新
- (void)endRefresh {
    self.isRefresh = NO;
    [self.listNewsTableView.mj_header endRefreshing];
    [self.listNewsTableView.mj_footer endRefreshing];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    ShowNewsModel *model = self.dataArray[indexPath.row];
//    NewsTitleCell *mycell = [tableView dequeueReusableCellWithIdentifier:@"titleCell" forIndexPath:indexPath];
//    mycell.titleLb.text = model.title;
//    cell = mycell;
    if ([model.imgNumber integerValue]== 0) {
        NewsTitleCell *mycell = [tableView dequeueReusableCellWithIdentifier:@"titleCell" forIndexPath:indexPath];
        mycell.titleLb.text = model.title;
        cell = mycell;
        NSLog(@"%@", model.imgNumber);
    }else if ([model.imgNumber integerValue] == 1){
        NewsImageOneCell *mycell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
        NSLog(@"%@", model.imgUrl1);
        //    [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
        [mycell.showImg sd_setImageWithURL:[NSURL URLWithString:model.imgUrl1] placeholderImage:[UIImage imageNamed:@"y_infoPlace"]];
        //    [cell.showImg sd_setImageWithURL:[NSURL URLWithString:model.imgUrl1] placeholderImage:[UIImage imageWithColor:[UIColor redColor]] options:SDWebImageAllowInvalidSSLCertificates];
        mycell.titleLb.text = model.title;
        cell = mycell;
    }else {
        NewsImgThreeCell *mycell = [tableView dequeueReusableCellWithIdentifier:@"threeCell" forIndexPath:indexPath];
        mycell.imageLeft.backgroundColor = [UIColor orangeColor];
        mycell.titleLb.text = model.title;
        [mycell.imageLeft sd_setImageWithURL:[NSURL URLWithString:model.imgUrl1]];
        [mycell.imageCenter sd_setImageWithURL:[NSURL URLWithString:model.imgUrl2]];
        [mycell.imageRight sd_setImageWithURL:[NSURL URLWithString:model.imgUrl3]];
        cell = mycell;
    }
    
    return cell;
}

-(CGSize)createCustomHeightWithText:(NSString *)text {
    CGSize size = [text sizeForFont:[UIFont systemFontOfSize:17] size:CGSizeMake(ScreenW - 30, kWidthScale(100)) mode:NSLineBreakByCharWrapping];
    return size;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShowNewsModel *model = self.dataArray[indexPath.row];
    if ([model.imgNumber integerValue] == 3) {
        NSLog(@"%f", [self createCustomHeightWithText:model.title].height);
        return 135 + [self createCustomHeightWithText:model.title].height;
    }else if ([model.imgNumber integerValue] == 1) {
        NSLog(@"%f", [self createCustomHeightWithText:model.title].height);
        return 85 + [self createCustomHeightWithText:model.title].height - 17;
    }else {
        return 60 + [self createCustomHeightWithText:model.title].height - 17;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ShowNewsModel *model = self.dataArray[indexPath.row];
    NewsWebViewController *vc = [[NewsWebViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.webUrlStr = model.url;
    NSLog(@"%@", model.url);
    [self.navigationController pushViewController:vc animated:YES];
    
}

















@end
