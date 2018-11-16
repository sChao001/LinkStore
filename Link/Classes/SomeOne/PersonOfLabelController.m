//
//  PersonOfLabelController.m
//  Link
//
//  Created by Surdot on 2018/7/3.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "PersonOfLabelController.h"
#import "LabelsTypeInfoOneController.h"
#import "LabelsTypeInfoTwoController.h"
#import "LabelsTypeInfoThreeController.h"
#import "SomeOneLabelsController.h"
#import "YRSearchViewController.h"
#import "SomeOneSymbolController.h"
#import "HomeLabelsModel.h"
#import "PartOflLabelsController.h"
#import "FSBaseViewController.h"


#define topHeight 0
#define lb_count 4
#define lbBtn_w ((ScreenW-20)/lb_count)
#define lbBtn_y kWidthScale(77)
@interface PersonOfLabelController ()<SGPageTitleViewDelegate, SGPageContentViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) RImagButton *naviView;
@property (nonatomic, strong) UIScrollView *labelsShow;
//@property (nonatomic, strong) RImagButton *labelsBtn;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIImageView *infoView;
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;
@property (nonatomic, strong) UIView *infoScrollView;
@property (nonatomic, strong) UIButton *levelBtn;
@property (nonatomic, strong) UIScrollView *infoRollingView;
@property (nonatomic, strong) NSMutableArray *dataLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) LabelsTypeInfoOneController *vcOne;
@property (nonatomic, strong) NSString *pushIdStr;
@end

@implementation PersonOfLabelController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataLabel = [NSMutableArray arrayWithCapacity:0];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self setMyNavigationBarOfBackground:RGB(2, 133, 193)];
    [self setMyNavigationBarShowOfImage];
    [self setNaviViewOfItem];
    _array = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10"];
    [self makeBackGroundScrollView];
    
    [self setSegmentPartView];
    
    self.title = @"";
    self.tabBarItem.title = @"有人";
    [self requestHomeLabesData];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _naviView.hidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _naviView.hidden = YES;
}
- (void)setNaviViewOfItem {
    _naviView = [[RImagButton alloc] init];
    [self.navigationController.navigationBar addSubview:_naviView];
    [_naviView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(50);
        make.right.equalTo(-50);
        make.centerY.equalTo(0);
//        make.top.equalTo(0);
        make.height.equalTo(20);
    }];
//    _naviView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.4];
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
    
    //编辑标签
    UIImage *imageLeft = [UIImage imageNamed:@"y_label"];
    UIImage *imageOriginalL = [imageLeft imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:imageOriginalL style:UIBarButtonItemStylePlain target:self action:@selector(toEditLabels)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
}
- (void)toSearchPeopleAndInfo {
    YRSearchViewController *vc = [[YRSearchViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)toEditLabels {
//    SomeOneLabelsController *vc = [[SomeOneLabelsController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
//    _naviView.hidden = YES;

}
- (void)makeBackGroundScrollView {
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, topHeight, ScreenW, ScreenH-LK_iPhoneXNavHeight-49)];
    _mainScrollView.backgroundColor = [ColorHex(@"adadad") colorWithAlphaComponent:0.2];
    _mainScrollView.contentSize = CGSizeMake(ScreenW, ScreenH-LK_iPhoneXNavHeight-49+kWidthScale(154)+17+kWidthScale(75)+5 -LK_iPhoneXscrollHeight);
    [self.view addSubview:_mainScrollView];
    _mainScrollView.bounces = NO;
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, kWidthScale(154)+17)];
    [_mainScrollView addSubview:_imageView];
    _mainScrollView.delegate = self;
    _imageView.image = [UIImage imageNamed:@"y_topback"];
    _imageView.userInteractionEnabled = YES;
}
- (void)setShowScrollView:(NSArray *)dataArry {
    _labelsShow = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 6, ScreenW-20, kWidthScale(154))];
    [_imageView addSubview:_labelsShow];
    _labelsShow.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
    _labelsShow.contentSize = CGSizeMake(dataArry.count/(2*lb_count+1)*(ScreenW-20) + (ScreenW-20), kWidthScale(154));
    _labelsShow.bounces = NO;
    _labelsShow.showsHorizontalScrollIndicator = NO;
    _labelsShow.pagingEnabled = YES;
    _labelsShow.layer.cornerRadius = kWidthScale(17);
    _labelsShow.layer.masksToBounds = YES;
    
    _infoView = [[UIImageView alloc] initWithFrame:CGRectMake(10, kWidthScale(154)+22, ScreenW-20, kWidthScale(74.5))];
    [_mainScrollView addSubview:_infoView];
    _infoView.image = [UIImage imageNamed:@"y_infoback"];
//    _infoView.backgroundColor = [UIColor orangeColor];
    
    _levelBtn = [[UIButton alloc] init];
    [_infoView addSubview:_levelBtn];
    [_levelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-15);
        make.centerY.equalTo(0);
        make.size.equalTo(CGSizeMake(45, 30));
    }];
    _levelBtn.backgroundColor = [UIColor clearColor];
    [_levelBtn setTitle:@"排行榜" forState:UIControlStateNormal];
    
    _infoRollingView = [[UIScrollView alloc] init];
    [_infoView addSubview:_infoRollingView];
    [_infoRollingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(30);
        make.right.equalTo(self.levelBtn.mas_left).equalTo(-20);
        make.centerY.equalTo(0);
        make.height.equalTo(30);
    }];
    _infoRollingView.backgroundColor = [UIColor clearColor];
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
//        button.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
        [button addTarget:self action:@selector(labelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.imageRect = CGRectMake((lbBtn_w - kWidthScale(42))/2, 8, kWidthScale(42), kWidthScale(42));
//        [button setImage:[UIImage imageNamed:@"headerImg"] forState:UIControlStateNormal];
        button.titleRect = CGRectMake(0, kWidthScale(42)+16, lbBtn_w, lbBtn_y-kWidthScale(42)-20);
        [button setTitle:model.name forState:UIControlStateNormal];
//        [button.imageView sd_setImageWithURL:[NSURL URLWithString:BDUrl_(model.imageUrl)]];
        [button sd_setImageWithURL:[NSURL URLWithString:BDUrl_(model.imageUrl)] forState:UIControlStateNormal];
//        [button sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"y_placeImg"]];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.font = [UIFont systemFontOfSize:11];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.imageView.layer.cornerRadius = kWidthScale(21);
        button.imageView.layer.masksToBounds = YES;
    }
}
- (void)labelButtonClicked:(UIButton *)sender {
//    NSLog(@"%ld", (long)sender.tag);
//    PartOflLabelsController *vc = [[PartOflLabelsController alloc] init];
//    vc.idStr = [NSString stringWithFormat:@"%ld", (long)sender.tag];
//    [self.navigationController pushViewController:vc animated:YES];
    
    FSBaseViewController *vc = [[FSBaseViewController alloc] init];
    vc.rootId = [NSString stringWithFormat:@"%ld", (long)sender.tag];
    vc.hidesBottomBarWhenPushed = YES;
    vc.titleString = sender.currentTitle;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)setSegmentPartView {
    _vcOne = [[LabelsTypeInfoOneController alloc] init];
    LabelsTypeInfoTwoController *vcTwo = [[LabelsTypeInfoTwoController alloc] init];
    LabelsTypeInfoThreeController *vcThree = [[LabelsTypeInfoThreeController alloc] init];
    NSArray *arrayVc = @[_vcOne, vcTwo, vcThree];
    
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, 23+kWidthScale(97) + kWidthScale(154)+17, ScreenW, ScreenH) parentVC:self childVCs:arrayVc];
    self.pageContentView.delegatePageContentView = self;
    [self.mainScrollView addSubview:_pageContentView];
    
    NSArray *arrTitle = @[@"热度", @"距离", @"时间"];
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(10, kWidthScale(154)+17+kWidthScale(75)+14, ScreenW-20, kWidthScale(22.5)) delegate:self titleNames:arrTitle];
    [self.mainScrollView addSubview:self.pageTitleView];
    self.pageTitleView.titleColorStateNormal = RGB(0, 0, 0);
    self.pageTitleView.titleColorStateSelected = ColorHex(@"fab952");
    self.pageTitleView.backgroundColor=[UIColor whiteColor];
    self.pageTitleView.layer.cornerRadius = kWidthScale(9);
    self.pageTitleView.layer.masksToBounds = YES;
    self.pageTitleView.indicatorColor = [UIColor clearColor];
    
}
#pragma mark - SGPageView代理
//每次点击pageView的标题的时候
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    
    [self.pageContentView setPageCententViewCurrentIndex:selectedIndex];
    
}
- (void)pageContentView:(SGPageContentView *)pageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}
- (void)requestHomeLabesData {
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid};
    [SCNetwork postWithURLString:BDUrl_s(@"friendhome/index") parameters:paramet success:^(NSDictionary *dic) {
        NSLog(@"%@", dic);
        if ([dic[@"code"] integerValue] > 0) {
            NSArray *arrLb = dic[@"labels"];
            for (NSDictionary *listDic in arrLb) {
                HomeLabelsModel *model =[[HomeLabelsModel alloc] init];
                [model setValuesForKeysWithDictionary:listDic];
                [self.dataLabel addObject:model];
                
            }
            [self setShowScrollView:self.dataLabel];
            [self refreshAllOfLabelsShow:self.dataLabel];
        
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"wwww%f", scrollView.contentOffset.y);
    if (scrollView.contentOffset.y > kWidthScale(154)+17+kWidthScale(75)+4) {
        _vcOne.listTableView.scrollEnabled = YES;
    }
    
//    _vcOne.listTableView.scrollEnabled = YES;
//    else {
//        _vcOne.listTableView.scrollEnabled = NO;
//    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
