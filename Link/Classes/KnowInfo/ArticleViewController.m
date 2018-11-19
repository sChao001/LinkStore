//
//  ArticleViewController.m
//  Link
//
//  Created by Surdot on 2018/11/19.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "ArticleViewController.h"
#import "NewsTitleCell.h"
#import "NewsImageOneCell.h"
#import "NewsImgThreeCell.h"
#import "NewsWebViewController.h"
#import "ArticleModel.h"
#import "NewsWebViewController.h"

@interface ArticleViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) int pageNumber;
@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, assign) BOOL isRefresh;
@end

@implementation ArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(245, 245, 245);
    [self setMyNavigationBarShowOfImage];
    [self creatListTableView];
    if ([UserDefault boolForKey:@"SecondLogin"]) {
        [self requestMessageData];
    }else {
        [self requestTouristsMessageData];
    }
    
}

- (void)creatListTableView {
    self.pageNumber = 1;
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, LK_iPhoneXNavHeight, ScreenW, ScreenH - 49 - LK_iPhoneXNavHeight) style:UITableViewStylePlain];
    [self.view addSubview:_listTableView];
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    [_listTableView registerClass:[NewsImageOneCell class] forCellReuseIdentifier:@"NewsCell"];
    [_listTableView registerClass:[NewsTitleCell class] forCellReuseIdentifier:@"titleCell"];
    [_listTableView registerClass:[NewsImgThreeCell class] forCellReuseIdentifier:@"threeCell"];
    _listTableView.mj_header = [YGRefreshHeader headerWithRefreshingBlock:^{
        if (self.isRefresh == NO) {
            self.isRefresh = YES;
            self.pageNumber = 1;
            if ([UserDefault boolForKey:@"SecondLogin"]) {
                [self requestMessageData];
            }else {
                [self requestTouristsMessageData];
            }
        }
    }];
    
    _listTableView.mj_footer = [YGRefreshFooter footerWithRefreshingBlock:^{
        if (self.isRefresh == NO) {
            self.isRefresh = YES;
            self.pageNumber++;
            if ([UserDefault boolForKey:@"SecondLogin"]) {
                [self requestMessageData];
            }else {
                [self requestTouristsMessageData];
            }
        }
    }];
}

- (void)endRefresh {
    self.isRefresh = NO;
    [self.listTableView.mj_header endRefreshing];
    [self.listTableView.mj_footer endRefreshing];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    ArticleModel *model = self.dataArray[indexPath.row];
    if ([model.titleNumber integerValue] == 0) {
        NewsTitleCell *mycell = [tableView dequeueReusableCellWithIdentifier:@"titleCell" forIndexPath:indexPath];
        mycell.titleLb.text = model.title;
        cell = mycell;
        NSLog(@"%@", model.titleNumber);
    }else if ([model.titleNumber integerValue] == 1) {
        NewsImageOneCell *mycell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
        [mycell.showImg sd_setImageWithURL:[NSURL URLWithString:KURL_(model.titleUrl0)] placeholderImage:[UIImage imageNamed:@"y_infoPlace"]];
        mycell.titleLb.text = model.title;
        cell = mycell;
    }else {
        NewsImgThreeCell *mycell = [tableView dequeueReusableCellWithIdentifier:@"threeCell" forIndexPath:indexPath];
        mycell.titleLb.text = model.title;
        [mycell.imageLeft sd_setImageWithURL:[NSURL URLWithString:KURL_(model.titleUrl0)] placeholderImage:[UIImage imageNamed:@"y_infoPlace"]] ;
        [mycell.imageCenter sd_setImageWithURL:[NSURL URLWithString:KURL_(model.titleUrl1)] placeholderImage:[UIImage imageNamed:@"y_infoPlace"]];
        [mycell.imageRight sd_setImageWithURL:[NSURL URLWithString:KURL_(model.titleUrl2)] placeholderImage:[UIImage imageNamed:@"y_infoPlace"]];
        cell = mycell;
    }
    return cell;
}

-(CGSize)createCustomHeightWithText:(NSString *)text {
    CGSize size = [text sizeForFont:[UIFont systemFontOfSize:17] size:CGSizeMake(ScreenW - 30, kWidthScale(100)) mode:NSLineBreakByCharWrapping];
    return size;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleModel *model = self.dataArray[indexPath.row];
    if ([model.titleNumber integerValue] == 3) {
        NSLog(@"%f", [self createCustomHeightWithText:model.title].height);
        return 135 + [self createCustomHeightWithText:model.title].height;
    }else if ([model.titleNumber integerValue] == 1) {
        NSLog(@"%f", [self createCustomHeightWithText:model.title].height);
        return 85 + [self createCustomHeightWithText:model.title].height - 17;
    }else {
        return 60 + [self createCustomHeightWithText:model.title].height - 17;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ArticleModel *model = self.dataArray[indexPath.row];
    NewsWebViewController *vc = [[NewsWebViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.webUrlStr = [NSString stringWithFormat:BDUrl_(@"v/knownews/getKnowNews?id=%@"), model.iD];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)requestMessageData {
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"pageNo" : [NSString stringWithFormat:@"%d", _pageNumber]};
    [SCNetwork postWithURLString:BDUrl_s(@"knownews/getKnowNewsList") parameters:paramet success:^(NSDictionary *dic) {
        if (self.pageNumber == 1) {
            [self.dataArray removeAllObjects];
        }
        NSArray *newsArr = dic[@"knowNewses"];
        for (NSDictionary *listDic in newsArr) {
            ArticleModel *model = [[ArticleModel alloc] init];
            [model setValuesForKeysWithDictionary:listDic];
            [self.dataArray addObject:model];
        }
        [self.listTableView reloadData];
        [self endRefresh];
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
        [SVProgressHUD dismissWithDelay:0.7];
        [self endRefresh];
    }];
}
- (void)requestTouristsMessageData {
    NSDictionary *paramet = @{@"sign" : Un_LogInSign.md5String, @"pageNo" : [NSString stringWithFormat:@"%d", _pageNumber]};
    [SCNetwork postWithURLString:BDUrl_s(@"knownews/getKnowNewsList") parameters:paramet success:^(NSDictionary *dic) {
        if (self.pageNumber == 1) {
            [self.dataArray removeAllObjects];
        }
        NSArray *newsArr = dic[@"knowNewses"];
        for (NSDictionary *listDic in newsArr) {
            ArticleModel *model = [[ArticleModel alloc] init];
            [model setValuesForKeysWithDictionary:listDic];
            [self.dataArray addObject:model];
        }
        [self.listTableView reloadData];
        [self endRefresh];
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
        [SVProgressHUD dismissWithDelay:0.7];
        [self endRefresh];
    }];
}







@end
