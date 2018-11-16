//
//  PartOflLabelsController.m
//  Link
//
//  Created by Surdot on 2018/7/16.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "PartOflLabelsController.h"
#import "PartOfLabelsPublishController.h"

@interface PartOflLabelsController ()
@property (nonatomic, strong) UIView *bannerView;
@end

@implementation PartOflLabelsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    UIImage *imageRight = [UIImage imageNamed:@"y_add"];
    UIImage *imageOriginal= [imageRight imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:imageOriginal style:UIBarButtonItemStylePlain target:self action:@selector(toPublish)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self setViewLayout];
}
- (void)toPublish {
    PartOfLabelsPublishController *vc = [[PartOfLabelsPublishController alloc] init];
    vc.idStr = _idStr;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)setViewLayout {
    _bannerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, kWidthScale(150))];
    [self.view addSubview:_bannerView];
    _bannerView.backgroundColor = [UIColor redColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
