//
//  YRSearchListViewController.m
//  Link
//
//  Created by Surdot on 2018/7/9.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "YRSearchListViewController.h"
#import "YRPeopleListViewController.h"
#import "YRInfomationViewController.h"

@interface YRSearchListViewController ()<SGPageTitleViewDelegate, SGPageContentViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;
@end

@implementation YRSearchListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setSegmentPartView];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%@", _labelStr);
}
- (void)setSegmentPartView {
    YRPeopleListViewController *vcOne = [[YRPeopleListViewController alloc] init];
    YRInfomationViewController *vcTwo = [[YRInfomationViewController alloc] init];
//    LabelsTypeInfoThreeController *vcThree = [[LabelsTypeInfoThreeController alloc] init];
    NSArray *arrayVc = @[vcTwo, vcOne];
    
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, LK_iPhoneXNavHeight+40, ScreenW, ScreenH - LK_iPhoneXNavHeight) parentVC:self childVCs:arrayVc];
    self.pageContentView.delegatePageContentView = self;
    [self.view addSubview:_pageContentView];
    
    NSArray *arrTitle = @[@"信息", @"用户"];
//    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, LK_iPhoneXNavHeight, ScreenW, 40) delegate:self titleNames:arrTitle];
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, LK_iPhoneXNavHeight, ScreenW, 40) delegate:self titleNames:arrTitle titleFont:[UIFont systemFontOfSize:kWidthScale(16)]];
    [self.view addSubview:self.pageTitleView];
    self.pageTitleView.titleColorStateNormal = [UIColor blackColor];
    self.pageTitleView.titleColorStateSelected = ColorHex(@"fab952");
    self.pageTitleView.backgroundColor=[UIColor whiteColor];
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
