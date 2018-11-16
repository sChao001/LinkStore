//
//  PersonOfHomeController.m
//  Link
//
//  Created by Surdot on 2018/8/29.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "PersonOfHomeController.h"
#import "MFNestTableView.h"
#import "MFPageView.h"
#import "MFSegmentView.h"

#import "HomeInfoModel.h"
#import "YRHomeInfoCell.h"
#import "YRHomeInfoTitleCell.h"
#import "SomeOneWebController.h"
#import "HomeLabelsModel.h"
#import "FSBaseViewController.h"
#import "YRSearchViewController.h"

#define topHeight 0
#define lb_count 4
#define lbBtn_w ((ScreenW-20)/lb_count)
#define lbBtn_y kWidthScale(77)

@interface PersonOfHomeController () <MFNestTableViewDelegate, MFNestTableViewDataSource, MFPageViewDataSource, MFPageViewDelegate, MFSegmentViewDelegate, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>
{
    CLLocationManager *locationmanager;
    NSString *strlatitude;
    NSString *strlongitude;
}
@property (nonatomic, strong) NSString *currentCity;
@property (nonatomic, strong) MFNestTableView *nestTableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) MFSegmentView *segmentView;
@property (nonatomic, strong) MFPageView *contentView;
@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, strong) NSMutableArray <NSArray *> *dataSource;
@property (nonatomic, strong) NSMutableArray <UIView *> *viewList;

@property (nonatomic, assign) BOOL canContentScroll;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *dataArrayTwo;
@property (nonatomic, strong) NSMutableArray *dataArrayThree;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *tableViewTwo;
@property (nonatomic, strong) UITableView *tableViewThree;

@property (nonatomic, assign) int pageNumber;
@property (nonatomic, assign) int pageNumberTwo;
@property (nonatomic, assign) int pageNumberThree;
@property (nonatomic, assign) BOOL isRefresh;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIScrollView *labelsShow;
@property (nonatomic, strong) NSMutableArray *dataLabel;
@property (nonatomic, strong) UIImageView *infoView;
@property (nonatomic, strong) RImagButton *naviView;
@property (nonatomic, strong) NSString *longitude;//经度
@property (nonatomic, strong) NSString *latitude;//纬度
@property (nonatomic, strong) NSString *detailAdress;
@end

@implementation PersonOfHomeController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _naviView.hidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _naviView.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setMyNavigationBarShowOfImage];
    self.title = @"";
    self.tabBarItem.title = @"有人";
    self.longitude = @"";
    self.latitude = @"";
    [self getLocation];

//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    self.dataArrayTwo = [NSMutableArray arrayWithCapacity:0];
    self.dataArrayThree = [NSMutableArray arrayWithCapacity:0];
    self.dataLabel = [NSMutableArray arrayWithCapacity:0];
    self.view.backgroundColor = [UIColor whiteColor];
    _viewList = [[NSMutableArray alloc] init];
    [self requestListTableViewData];
    [self initDataSource];
    [self initLayout:nil];//
    [self requestHomeLabesData];
    [self setNaviViewOfItem];
   
}

- (void)setNaviViewOfItem {
//    _naviView = [[RImagButton alloc] init];
//    [self.navigationController.navigationBar addSubview:_naviView];
//    [_naviView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(40);//50
//        make.right.equalTo(-40);
//        make.centerY.equalTo(0);
//        //        make.top.equalTo(0);
//        make.height.equalTo(20);
//    }];
    
    _naviView = [[RImagButton alloc] initWithFrame:CGRectMake(40, 12, ScreenW - 80, 20)];
    [self.navigationController.navigationBar addSubview:_naviView];
    
    _naviView.backgroundColor = [ColorHex(@"fff276") colorWithAlphaComponent:0.5];
    _naviView.imageRect = CGRectMake(12, 3, 13, 13);
    _naviView.titleRect = CGRectMake(0, 3, ScreenW-100, 15);
    [_naviView setImage:[UIImage imageNamed:@"y_searchBar"] forState:UIControlStateNormal];
    [_naviView setTitle:@"根据标签搜索" forState:UIControlStateNormal];
    [_naviView setTitleColor:[ColorHex(@"282828") colorWithAlphaComponent:0.5] forState:UIControlStateNormal];
    _naviView.titleLabel.font = [UIFont systemFontOfSize:kWidthScale(15)];
    _naviView.titleLabel.textAlignment = NSTextAlignmentCenter;
    _naviView.layer.cornerRadius = 5;
    _naviView.layer.masksToBounds = YES;
    [_naviView addTarget:self action:@selector(toSearchPeopleAndInfo) forControlEvents:UIControlEventTouchUpInside];
    
//    //编辑标签
//    UIImage *imageLeft = [UIImage imageNamed:@"y_label"];
//    UIImage *imageOriginalL = [imageLeft imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:imageOriginalL style:UIBarButtonItemStylePlain target:self action:@selector(toEditLabels)];
//    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)toEditLabels {
    
}
- (void)toSearchPeopleAndInfo {
    YRSearchViewController *vc = [[YRSearchViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - private methods
- (void)initDataSource {
    self.pageNumberThree = 1;
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [ColorHex(@"adadad") colorWithAlphaComponent:0.2];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.tag = 1;
    [_viewList addObject:_tableView];
    [_tableView registerClass:[YRHomeInfoCell class] forCellReuseIdentifier:@"YRCell"];
    [_tableView registerClass:[YRHomeInfoTitleCell class] forCellReuseIdentifier:@"titleCell"];
    self.tableView.mj_header = [YGRefreshHeader headerWithRefreshingBlock:^{
        if (self.isRefresh == NO) {
            self.isRefresh = YES;
            self.pageNumber = 1;
            [self requestListTableViewData];
        }

    }];
    self.tableView.mj_footer = [YGRefreshFooter footerWithRefreshingBlock:^{
        if (self.isRefresh == NO) {
            self.isRefresh = YES;
            self.pageNumber++;
            [self requestListTableViewData];
        }
    }];
    
    
    _tableViewTwo = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableViewTwo.delegate = self;
    _tableViewTwo.dataSource = self;
    _tableViewTwo.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableViewTwo.backgroundColor = [ColorHex(@"adadad") colorWithAlphaComponent:0.2];
    _tableViewTwo.tag = 2;
    [_viewList addObject:_tableViewTwo];
    [_tableViewTwo registerClass:[YRHomeInfoCell class] forCellReuseIdentifier:@"YRCell"];
    [_tableViewTwo registerClass:[YRHomeInfoTitleCell class] forCellReuseIdentifier:@"titleCell"];
    self.tableViewTwo.mj_header = [YGRefreshHeader headerWithRefreshingBlock:^{
        if (self.isRefresh == NO) {
            self.isRefresh = YES;
            self.pageNumberTwo = 1;
            [self requestListTableViewData];
        }
    }];
    self.tableViewTwo.mj_footer = [YGRefreshFooter footerWithRefreshingBlock:^{
        if (self.isRefresh == NO) {
            self.isRefresh = YES;
            self.pageNumberTwo++;
            [self requestDataOfTeiZiWithTime];
        }
    }];
    
    _tableViewThree = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableViewThree.delegate = self;
    _tableViewThree.dataSource = self;
    _tableViewThree.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableViewThree.backgroundColor = [ColorHex(@"adadad") colorWithAlphaComponent:0.2];
    _tableViewThree.tag = 3;
    [_viewList addObject:_tableViewThree];
    [_tableViewThree registerClass:[YRHomeInfoCell class] forCellReuseIdentifier:@"YRCell"];
    [_tableViewThree registerClass:[YRHomeInfoTitleCell class] forCellReuseIdentifier:@"titleCell"];
    self.tableViewThree.mj_header = [YGRefreshHeader headerWithRefreshingBlock:^{
        if (self.isRefresh == NO) {
            self.isRefresh = YES;
            self.pageNumberThree = 1;
            [self requestDataOfTeiziWithAddress];
        }
    }];
    self.tableViewThree.mj_footer = [YGRefreshFooter footerWithRefreshingBlock:^{
        if (self.isRefresh == NO) {
            self.isRefresh = YES;
            self.pageNumberThree++;
            [self requestDataOfTeiziWithAddress];
        }
    }];
    
}
//结束刷新
- (void)endRefresh {
    self.isRefresh = NO;
//    [self.tableView.mj_header endRefreshing];
    [_nestTableView.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableViewTwo.mj_footer endRefreshing];
    [self.tableViewThree.mj_footer endRefreshing];
}
- (void)initLayout:(NSArray *)dataArry {
    [self initHeaderView:dataArry];
    [self initSegmentView];
    [self initContentView];
    
    //    _nestTableView = [[MFNestTableView alloc] initWithFrame:self.view.bounds];
    _nestTableView = [[MFNestTableView alloc] initWithFrame:CGRectMake(0, LK_iPhoneXNavHeight, ScreenW, ScreenH-49)];
    _nestTableView.backgroundColor = [UIColor redColor];
    _nestTableView.headerView = _headerView;
    _nestTableView.segmentView = _segmentView;
    _nestTableView.contentView = _contentView;
    _nestTableView.footerView = _footerView;
    _nestTableView.allowGestureEventPassViews = _viewList;
    _nestTableView.delegate = self;
    _nestTableView.dataSource = self;
    _nestTableView.tableView.mj_header = [YGRefreshHeader headerWithRefreshingBlock:^{
        if (self.isRefresh == NO) {
            self.isRefresh = YES;
            self.pageNumber = 1;
            [self requestListTableViewData];
            [self requestDataOfTeiZiWithTime];
            [self requestDataOfTeiziWithAddress];
        }
    }];
    [self.view addSubview:_nestTableView];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, LK_iPhoneXNavHeight)];
    [self.view addSubview:topView];
    topView.backgroundColor = [UIColor whiteColor];
}
//顶部视图
- (void)initHeaderView:(NSArray *)dataArry {
//    CGFloat offsetTop = [self nestTableViewContentInsetTop:_nestTableView];
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, kWidthScale(154)+17)];
    _imageView.image = [UIImage imageNamed:@"y_topback"];
    _imageView.userInteractionEnabled = YES;
    _headerView = _imageView;
    
    _labelsShow = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 6, ScreenW-20, kWidthScale(154))];
    [_imageView addSubview:_labelsShow];
    _labelsShow.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
    _labelsShow.contentSize = CGSizeMake(dataArry.count/(2*lb_count+1)*(ScreenW-20) + (ScreenW-20), kWidthScale(154));
    _labelsShow.bounces = NO;
    _labelsShow.showsHorizontalScrollIndicator = NO;
    _labelsShow.pagingEnabled = YES;
    _labelsShow.layer.cornerRadius = kWidthScale(17);
    _labelsShow.layer.masksToBounds = YES;
    
//    _infoView = [[UIImageView alloc] initWithFrame:CGRectMake(10, kWidthScale(154)+22, ScreenW-20, kWidthScale(74.5))];
//    [_mainScrollView addSubview:_infoView];
//    _infoView.image = [UIImage imageNamed:@"y_infoback"];
//    //    _infoView.backgroundColor = [UIColor orangeColor];
//
//    _levelBtn = [[UIButton alloc] init];
//    [_infoView addSubview:_levelBtn];
//    [_levelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(-15);
//        make.centerY.equalTo(0);
//        make.size.equalTo(CGSizeMake(45, 30));
//    }];
//    _levelBtn.backgroundColor = [UIColor clearColor];
//    [_levelBtn setTitle:@"排行榜" forState:UIControlStateNormal];
}

- (void)refreshAllOfLabelsShow:(NSArray *)dataArray {
    for (int i = 0; i < dataArray.count; i++) {
        HomeLabelsModel *model = dataArray[i];
        RImagButton *button = [[RImagButton alloc] init];
        if (i < 2*lb_count) {
            button.frame = CGRectMake(i%lb_count*lbBtn_w, i/lb_count*lbBtn_y, lbBtn_w, lbBtn_y);
        }else {
            int k = i - 2*lb_count;
            button.frame = CGRectMake(ScreenW+k%lb_count*lbBtn_w, k/lb_count*lbBtn_y, lbBtn_w, lbBtn_y);
        }
        button.tag = [model.Id integerValue];
        [self.labelsShow addSubview:button];
        [button addTarget:self action:@selector(labelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.imageRect = CGRectMake((lbBtn_w - kWidthScale(42))/2, 8, kWidthScale(42), kWidthScale(42));
        button.titleRect = CGRectMake(0, kWidthScale(42)+16, lbBtn_w, lbBtn_y-kWidthScale(42)-20);
        [button setTitle:model.name forState:UIControlStateNormal];
        [button sd_setImageWithURL:[NSURL URLWithString:BDUrl_(model.imageUrl)] forState:UIControlStateNormal];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.font = [UIFont systemFontOfSize:11];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.imageView.layer.cornerRadius = kWidthScale(21);
        button.imageView.layer.masksToBounds = YES;
    }
}
- (void)labelButtonClicked:(UIButton *)sender {
    FSBaseViewController *vc = [[FSBaseViewController alloc] init];
    vc.rootId = [NSString stringWithFormat:@"%ld", sender.tag];
    vc.hidesBottomBarWhenPushed = YES;
    vc.titleString = sender.currentTitle;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)initSegmentView {
    //CGRectMake(10, kWidthScale(154)+17+kWidthScale(75)+14, ScreenW-20, kWidthScale(22.5))
    _segmentView = [[MFSegmentView alloc] initWithFrame:CGRectMake(100, 10, ScreenW-20, kWidthScale(22.5))];
    _segmentView.delegate = self;
    _segmentView.itemWidth = [UIScreen mainScreen].bounds.size.width/3;
    _segmentView.itemFont = [UIFont systemFontOfSize:15];
    _segmentView.itemNormalColor = [UIColor colorWithRed:155.0 / 255 green:155.0 / 255 blue:155.0 / 255 alpha:1];
    _segmentView.itemSelectColor = [UIColor colorWithRed:244.0 / 255 green:67.0 / 255 blue:54.0 / 255 alpha:1];
    _segmentView.bottomLineWidth = 60;
    _segmentView.bottomLineHeight = 2;
    _segmentView.itemList = @[@"热门", @"时间", @"距离"];
    _segmentView.itemNormalColor = [UIColor blackColor];
    _segmentView.itemSelectColor = ColorHex(@"fab952");
    
}

- (void)initContentView {
    _contentView = [[MFPageView alloc] initWithFrame:self.view.bounds];
    _contentView.delegate = self;
    _contentView.dataSource = self;
}

#pragma mark - MFSegmentViewDelegate

- (void)segmentView:(MFSegmentView *)segmentView didScrollToIndex:(NSUInteger)index {
    NSLog(@"你是%lu", (unsigned long)index);
    if (index == 0) {
//        [self.dataArray removeAllObjects];
        [self requestListTableViewData];
    }
    if (index == 1){
//        [self.dataArray removeAllObjects];
        [self requestDataOfTeiZiWithTime];
    }
    if (index == 2){
//        [self.dataArray removeAllObjects];
        [self requestDataOfTeiziWithAddress];
    }
    
    [_contentView scrollToIndex:index];
}

#pragma mark - MFPageViewDataSource & MFPageViewDelegate

- (NSUInteger)numberOfPagesInPageView:(MFPageView *)pageView {
    NSLog(@"%lu", (unsigned long)pageView);
//    [self.tableView reloadData];
    return [_viewList count];
}

- (UIView *)pageView:(MFPageView *)pageView pageAtIndex:(NSUInteger)index {
    NSLog(@"你他妈是几%lu", (unsigned long)index);
//    [self.tableView reloadData];

    return _viewList[index];
}

- (void)pageView:(MFPageView *)pageView didScrollToIndex:(NSUInteger)index {
    NSLog(@"%lu", (unsigned long)index);
    [_segmentView scrollToIndex:index];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%lu", (unsigned long)_dataArray.count);
    NSInteger cellCount = 0;
    if (tableView.tag == 1) {
        cellCount = self.dataArray.count;
    }
    if (tableView.tag == 2) {
        cellCount = self.dataArrayTwo.count;
    }
    if (tableView.tag == 3) {
        cellCount = self.dataArrayThree.count;
    }
    return cellCount;
//    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (tableView.tag == 1) {
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
    }
    if (tableView.tag == 2) {
        HomeInfoModel *model = self.dataArrayTwo[indexPath.row];
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
    }
    if (tableView.tag == 3) {
        HomeInfoModel *model = self.dataArrayThree[indexPath.row];
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
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld", (long)indexPath.row);
    
    if (tableView.tag == 1) {
        HomeInfoModel *model = self.dataArray[indexPath.row];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        SomeOneWebController *vc = [[SomeOneWebController alloc] init];
        vc.idStr = [NSString stringWithFormat:@"%@", model.iD];
        vc.articleTitle = model.title;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (tableView.tag == 2) {
        HomeInfoModel *model = self.dataArrayTwo[indexPath.row];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        SomeOneWebController *vc = [[SomeOneWebController alloc] init];
        vc.idStr = [NSString stringWithFormat:@"%@", model.iD];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (tableView.tag == 3) {
        HomeInfoModel *model = self.dataArrayThree[indexPath.row];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        SomeOneWebController *vc = [[SomeOneWebController alloc] init];
        vc.idStr = [NSString stringWithFormat:@"%@", model.iD];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


// 3个tableView，scrollView，webView滑动时都会响应这个方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (!_canContentScroll) {
        // 这里通过固定contentOffset，来实现不滚动
        scrollView.contentOffset = CGPointZero;
    } else if (scrollView.contentOffset.y <= 0) {
        _canContentScroll = NO;
        // 通知容器可以开始滚动
        _nestTableView.canScroll = YES;
    }
    scrollView.showsVerticalScrollIndicator = _canContentScroll;
}

#pragma mark - MFNestTableViewDelegate & MFNestTableViewDataSource

- (void)nestTableViewContentCanScroll:(MFNestTableView *)nestTableView {
    
    self.canContentScroll = YES;
}

- (void)nestTableViewContainerCanScroll:(MFNestTableView *)nestTableView {
    
    // 当容器开始可以滚动时，将所有内容设置回到顶部
    for (id view in self.viewList) {
        UIScrollView *scrollView;
        if ([view isKindOfClass:[UIScrollView class]]) {
            scrollView = view;
        } else if ([view isKindOfClass:[UIWebView class]]) {
            scrollView = ((UIWebView *)view).scrollView;
        }
        if (scrollView) {
            scrollView.contentOffset = CGPointZero;
        }
//        nestTableView.tableView.mj_header = [YGRefreshHeader headerWithRefreshingBlock:^{
//
//        }];
    }
}

- (void)nestTableViewDidScroll:(UIScrollView *)scrollView {
    // 监听容器的滚动，来设置NavigationBar的透明度
    if (_headerView) {
//        CGFloat offset = scrollView.contentOffset.y;
//        CGFloat canScrollHeight = [_nestTableView heightForContainerCanScroll];
        
        //        MFTransparentNavigationBar *bar = (MFTransparentNavigationBar *)self.navigationController.navigationBar;
        //        if ([bar isKindOfClass:[MFTransparentNavigationBar class]]) {
        //            [bar setBackgroundAlpha:offset / canScrollHeight];
        //        }
    }
}
- (CGFloat)nestTableViewContentInsetTop:(MFNestTableView *)nestTableView {

    // 因为这里navigationBar.translucent == YES，所以实现这个方法，返回下面的值
    if (IS_IPHONE_X) {
        return 88;
    } else {
        return 64;
    }
}
//请求数据
- (void)requestListTableViewData {
    NSLog(@"%d", _pageNumber);
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"pageNo" : [NSString stringWithFormat:@"%d", _pageNumber]};
    [SCNetwork postWithURLString:BDUrl_s(@"community/getCommunityList") parameters:paramet success:^(NSDictionary *dic) {
        if (self.pageNumber == 1) {
            [self.dataArray removeAllObjects];
        }
        NSLog(@"%@", dic);
        if ([dic[@"code"] integerValue] > 0) {
            NSArray *array = dic[@"communities"];
            for (NSDictionary *lisDic in array) {
                HomeInfoModel *model = [[HomeInfoModel alloc] init];
                [model setValuesForKeysWithDictionary:lisDic];
                [self.dataArray addObject:model];
            }
            [self.tableView reloadData];
            [self endRefresh];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络出问题了哦~"];
        [SVProgressHUD dismissWithDelay:0.7];
        [self endRefresh];
    }];
}

- (void)requestHomeLabesData {
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid};
    [SCNetwork postWithURLString:BDUrl_s(@"friendhome/index") parameters:paramet success:^(NSDictionary *dic) {
//        NSLog(@"%@", dic);
        if ([dic[@"code"] integerValue] > 0) {
            NSArray *arrLb = dic[@"labels"];
            for (NSDictionary *listDic in arrLb) {
                HomeLabelsModel *model =[[HomeLabelsModel alloc] init];
                [model setValuesForKeysWithDictionary:listDic];
                [self.dataLabel addObject:model];
                
            }
//            [self setShowScrollView:self.dataLabel];
            [self initLayout:self.dataLabel];
            [self refreshAllOfLabelsShow:self.dataLabel];
            
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}
//时间排序加载帖子列表
- (void)requestDataOfTeiZiWithTime {
    NSLog(@"%d", _pageNumberTwo);
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"pageNo" : [NSString stringWithFormat:@"%d", _pageNumberTwo]};
    [SCNetwork postWithURLString:BDUrl_s(@"community/getCommunityListByTime") parameters:paramet success:^(NSDictionary *dic) {
        if (self.pageNumberTwo == 1) {
            [self.dataArrayTwo removeAllObjects];
        }
        if ([dic[@"code"] integerValue] > 0) {
            NSArray *array = dic[@"communities"];
            for (NSDictionary *lisDic in array) {
                HomeInfoModel *model = [[HomeInfoModel alloc] init];
                [model setValuesForKeysWithDictionary:lisDic];
                [self.dataArrayTwo addObject:model];
            }
            [self.tableViewTwo reloadData];
            [self endRefresh];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败2"];
        [SVProgressHUD dismissWithDelay:0.7];
        [self endRefresh];
    }];
}

- (void)requestDataOfTeiziWithAddress {
    NSLog(@"%@==%@", _longitude, _latitude);
    NSLog(@"%d", _pageNumberThree);
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"pageNo" : [NSString stringWithFormat:@"%d", _pageNumberThree], @"longitude" : _longitude, @"latitude" : _latitude};
    [SCNetwork postWithURLString:BDUrl_s(@"community/getCommunityListByDistance") parameters:paramet success:^(NSDictionary *dic) {
        if (self.pageNumberThree == 1) {
            [self.dataArrayThree removeAllObjects];
        }
        if ([dic[@"code"] integerValue] > 0) {
            NSArray *array = dic[@"communities"];
            for (NSDictionary *lisDic in array) {
                HomeInfoModel *model = [[HomeInfoModel alloc] init];
                [model setValuesForKeysWithDictionary:lisDic];
                [self.dataArrayThree addObject:model];
            }
            [self.tableViewThree reloadData];
            [self endRefresh];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败3"];
        [SVProgressHUD dismissWithDelay:0.7];
        [self endRefresh];
    }];
}

-(void)getLocation
{
    //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        locationmanager = [[CLLocationManager alloc]init];
        locationmanager.delegate = self;
        [locationmanager requestAlwaysAuthorization];
        _currentCity = [NSString new];
        [locationmanager requestWhenInUseAuthorization];
        
        //设置寻址精度
        locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
        locationmanager.distanceFilter = 5.0;
        [locationmanager startUpdatingLocation];
    }
}
#pragma mark 定位成功后则执行此代理方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    [locationmanager stopUpdatingHeading];
    //旧址
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    //打印当前的经度与纬度
    NSLog(@"%f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    
    self.longitude = [NSString stringWithFormat:@"%f", currentLocation.coordinate.longitude];
    self.latitude = [NSString stringWithFormat:@"%f", currentLocation.coordinate.latitude];
    
    //反地理编码
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            self.currentCity = placeMark.locality;
            if (!self.currentCity) {
                self.currentCity = @"无法定位当前城市";
            }
            
            /*看需求定义一个全局变量来接收赋值*/
            NSLog(@"----%@",placeMark.country);//当前国家
            NSLog(@"%@",self.currentCity);//当前的城市
            NSLog(@"%@",placeMark.subLocality);//当前的位置
            NSLog(@"%@",placeMark.thoroughfare);//当前街道
            NSLog(@"%@",placeMark.name);//具体地址
        }
    }];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
@end
