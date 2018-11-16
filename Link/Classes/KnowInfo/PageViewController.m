//
//  PageViewController.m
//  Link
//
//  Created by Surdot on 2018/6/14.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "PageViewController.h"
#import "LKConnecterViewController.h"
#import "SignTypeModel.h"
#import "AddSignModel.h"
#import "ChooseedSignController.h"
#import "MyChannelViewController.h"
#import "PublishHomeController.h"
#import "HistoryInfoViewController.h"
#import "EditContentViewController.h"

@interface PageViewController ()
@property (nonatomic, strong) NSArray *recommendArr;
@property (nonatomic, strong) NSMutableArray *signArray;
@property (nonatomic, strong) NSMutableArray *toAddSignArray;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, strong) MyChannelViewController *channelVC;
@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setSundry];
    self.signArray = [NSMutableArray arrayWithCapacity:0];
    self.toAddSignArray = [NSMutableArray arrayWithCapacity:0];
    [self creatMoreSignBtn];
    self.titleColorNormal = ColorHex(@"656565");
    self.titleColorSelected = ColorHex(@"f8b643");
    self.titleSizeNormal = 17;
    self.titleSizeSelected = 17;
    self.menuItemWidth = 70;
    if (![UserDefault boolForKey:@"SecondLogin"]) {
        [self touristsRequesData];
    }else {
        [self requestMessageOfSignData];
    }
    

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated]; 
    if (![UserDefault boolForKey:@"SecondLogin"]) {
        [self touristsRequesData];
    }else {
        [self requestMessageOfSignData];
    }
}
- (void)setSundry {
    if ([UserDefault boolForKey:@"SecondLogin"]) {
        UIImage *imageLeft = [UIImage imageNamed:@"k_history"];
        UIImage *selectImage0 = [imageLeft imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:selectImage0 style:UIBarButtonItemStylePlain target:self action:@selector(personalBtnClicked)];
        self.navigationItem.leftBarButtonItem = leftBarItem;
        
        UIImage *image = [UIImage imageNamed:@"y_add"];
        UIImage *selectImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *rightBarItemOne = [[UIBarButtonItem alloc] initWithImage:selectImage style:UIBarButtonItemStylePlain target:self action:@selector(publishBtnClicked)];
        self.navigationItem.rightBarButtonItem = rightBarItemOne;
    }
}
- (void)personalBtnClicked {
    HistoryInfoViewController *vc = [[HistoryInfoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)publishBtnClicked {
    NSLog(@"去发布");
    
    EditContentViewController *vc = [[EditContentViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (NSArray<NSString *> *)titles {
//    NSLog(@"_signArray:%lu", (unsigned long)_signArray.count);
//    if (_signArray.count == 0) {
//        return _recommendArr;
//    }else {
//        return _signArray;
//    }
    return _signArray;
}

//- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {

//}
- (void)creatMoreSignBtn {
    _moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 40, LK_iPhoneXNavHeight, 40, 44)];
//    _moreBtn.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.4];
    [_moreBtn setImage:[UIImage imageNamed:@"z_more"] forState:UIControlStateNormal];
    [self.view addSubview:_moreBtn];
    [_moreBtn addTarget:self action:@selector(moreBtnClicked) forControlEvents:UIControlEventTouchUpInside];
}
- (void)moreBtnClicked {
    MyChannelViewController *vc = [[MyChannelViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    vc.signArray = _signArray;
    vc.belowArray = _toAddSignArray;
}
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    if (_signArray.count == 0) {
        return 5;
    }else {
        return _signArray.count;
    }
}
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    self.recommendArr = @[@"娱乐", @"财经", @"体育", @"军事", @"88"];

    if (self.signArray.count == 0) {
        return [[LKConnecterViewController alloc] initWithMessageType:_recommendArr[index]];
    }else {
        return [[LKConnecterViewController alloc] initWithMessageType:_signArray[index]];
    }
}
//标题View
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
//    CGFloat originY = self.showOnNavigationBar ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
    
    return CGRectMake(0, LK_iPhoneXNavHeight, ScreenW - 40, 44);
}
//内容View
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    return CGRectMake(0, originY, ScreenW, ScreenH - originY - 49);
}

- (void)requestMessageOfSignData {
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid};
    [self.signArray removeAllObjects];
    [self.toAddSignArray removeAllObjects];
    [SCNetwork postWithURLString:BDUrl_s(@"label/getLabelList") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"dic:%@",dic);
            NSArray *userLabelsArr = dic[@"userLabels"];
            NSArray *labesArr = dic[@"lables"];
            [self.signArray removeAllObjects];
            for (NSDictionary *listDic in userLabelsArr) {
                SignTypeModel *model = [[SignTypeModel alloc] init];
                [model setValuesForKeysWithDictionary:listDic];
                [self.signArray addObject:model.labelName];
            }
            NSLog(@"%@", self.signArray);
            [self reloadData];  //刷新PageViewController   该方法用于重置刷新父控制器，该刷新包括顶部 MenuView 和 childViewControllers.
            for (NSDictionary *listLabels in labesArr) {
                AddSignModel *model = [[AddSignModel alloc] init];
                [model setValuesForKeysWithDictionary:listLabels];
                [self.toAddSignArray addObject:model.name];
            }

        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}

//游客进入数据请求
- (void)touristsRequesData{
    NSDictionary *paramet = @{@"sign" : Un_LogInSign.md5String};
    [self.signArray removeAllObjects];
    [self.toAddSignArray removeAllObjects];
    [SCNetwork postWithURLString:BDUrl_s(@"label/getLabelList") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"dic:%@",dic);
            NSArray *userLabelsArr = dic[@"userLabels"];
            NSArray *labesArr = dic[@"lables"];
            [self.signArray removeAllObjects];
            for (NSDictionary *listDic in userLabelsArr) {
                SignTypeModel *model = [[SignTypeModel alloc] init];
                [model setValuesForKeysWithDictionary:listDic];
                [self.signArray addObject:model.labelName];
            }
            NSLog(@"%@", self.signArray);
            [self reloadData];  //刷新PageViewController   该方法用于重置刷新父控制器，该刷新包括顶部 MenuView 和 childViewControllers.
            for (NSDictionary *listLabels in labesArr) {
                AddSignModel *model = [[AddSignModel alloc] init];
                [model setValuesForKeysWithDictionary:listLabels];
                [self.toAddSignArray addObject:model.name];
            }
            
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
