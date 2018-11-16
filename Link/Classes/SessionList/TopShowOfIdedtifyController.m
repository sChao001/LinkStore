//
//  TopShowOfIdedtifyController.m
//  Link
//
//  Created by Surdot on 2018/5/30.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "TopShowOfIdedtifyController.h"
#import "AddSubIdentifyController.h"
#import "SubIdentifyCell.h"
#import "SubIdentifyModel.h"
#import "TopShowIdViewCell.h"
#import "FakeLaunchViewController.h"

@interface TopShowOfIdedtifyController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) RCUserInfo *currentUserInfo;
@property (nonatomic, strong) UITableView *identityTableView;
@property (nonatomic, strong) NSMutableArray *usersArray;
@property (nonatomic, strong) RImagButton *setBtn;
@property (nonatomic, strong) UIView *lineViewOne;
@property (nonatomic, strong) RImagButton *homeBtn;
@property (nonatomic, strong) NSArray *myArray;
@property (nonatomic, strong) NSDictionary *homeDic;
@property (nonatomic, strong) NSString *jmToken;
@end

@implementation TopShowOfIdedtifyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.usersArray = [NSMutableArray arrayWithCapacity:0];
    [self setIdentityLayoutView];
    [self creatMyAlertlabel];

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestIdentifiesData];
}

- (void)setIdentityLayoutView {
    //    _identityTableView = [[UITableView alloc] initWithFrame:CGRectMake(12, LK_iPhoneXNavHeight + 10, kWidthScale(151), kWidthScale(220)) style:UITableViewStylePlain];
    //    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //    [window addSubview:_identityTableView];
    //
    ////    [self.view bringSubviewToFront:_identityTableView];
    //    _identityTableView.backgroundColor = [UIColor blueColor];
    //
    //    UIView *txtfootview=[[UIView alloc]init];
    //    txtfootview.frame=CGRectMake(0, 0, kWidthScale(151), 100);
    //    txtfootview.backgroundColor=[UIColor redColor];
    //    UIButton *btnRegis=[[UIButton alloc]initWithFrame:CGRectMake(10, 10,40, 44)];
    //    btnRegis.backgroundColor = [UIColor brownColor];
    //    _setBtn=btnRegis;
    //    [txtfootview addSubview:_setBtn];
    //    _identityTableView.tableFooterView=txtfootview;
    
    
    _identityTableView = [[UITableView alloc] init];
    //    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self.view addSubview:_identityTableView];
    [_identityTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(12);
        make.top.equalTo(LK_iPhoneXNavHeight+3);
        make.size.equalTo(CGSizeMake(kWidthScale(151), kWidthScale(220)));
    }];
    _identityTableView.backgroundColor = [UIColor clearColor];
    _identityTableView.delegate = self;
    _identityTableView.dataSource = self;
    [_identityTableView registerClass:[TopShowIdViewCell class] forCellReuseIdentifier:@"subCell"];
    _identityTableView.showsVerticalScrollIndicator = NO;
    _identityTableView.showsHorizontalScrollIndicator = NO;
    _identityTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    
    UIView *footView = [[UIView alloc] init];
    _identityTableView.tableFooterView = footView;
    //    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.top.right.equalTo(0);
    //        make.height.equalTo(kWidthScale(81));
    //    }];
    
    footView.frame = CGRectMake(0, 0, kWidthScale(151), 81);
    footView.backgroundColor = [RGB(2, 133, 193) colorWithAlphaComponent:0.9];
//    footView.backgroundColor = [UIColor colorWithPatternImage:[self blurryImage:[UIImage imageWithColor:[RGB(2, 133, 193) colorWithAlphaComponent:0.9]] withBlurLevel:0.1]];
    //    _setBtn =[[RImagButton alloc]initWithFrame:CGRectMake((kWidthScale(151)-13)/2, 12 + 41, 13, 13)];
    _setBtn = [[RImagButton alloc] initWithFrame:CGRectMake(0, 42, kWidthScale(151), 39)];
    _setBtn.imageRect = CGRectMake((kWidthScale(151) - 13) / 2, 12, 13, 13);
    [_setBtn setImage:[UIImage imageNamed:@"setBtn"] forState:UIControlStateNormal];
    [footView addSubview:_setBtn];
    [_setBtn addTarget:self action:@selector(toSetSubIdentify) forControlEvents:UIControlEventTouchUpInside];
    
    _lineViewOne = [[UIView alloc] initWithFrame:CGRectMake(13, 41, kWidthScale(151) - 26, 1)];
    _lineViewOne.backgroundColor = RGB(94, 170, 208);
    [footView addSubview:_lineViewOne];
    _identityTableView.bounces = NO;
    
    _homeBtn = [[RImagButton alloc]initWithFrame:CGRectMake(0, 0, kWidthScale(151), 41)];
    [footView addSubview:_homeBtn];
    _homeBtn.imageRect = CGRectMake(kWidthScale(17), 10, 20, 20);
    [_homeBtn setImage:[UIImage imageNamed:@"homeLink"] forState:UIControlStateNormal];
    _homeBtn.titleRect = CGRectMake(30 + kWidthScale(17), 10, 35, 20);
    [_homeBtn setTitle:@"Link" forState:UIControlStateNormal];
    _homeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_homeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_homeBtn addTarget:self action:@selector(switchHomeAccount) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 子账号弹框
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _usersArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kWidthScale(42);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TopShowIdViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"subCell" forIndexPath:indexPath];
    SubIdentifyModel *model = self.usersArray[indexPath.row];
    [cell.iconImg sd_setImageWithURL:[NSURL URLWithString:BDUrl_(model.headUrl)]];
    
    cell.nameLb.text = model.nickName;
    return cell;

}
//进行切换账号操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SubIdentifyModel *model = self.usersArray[indexPath.row];
    NSLog(@"%@===%@", _usersArray[indexPath.row], model.nickName);
    
    NSLog(@"777%@", _myArray[indexPath.row]);
    [SVProgressHUD show];
    [[RCIM sharedRCIM] disconnect]; //融云退出登录
//    [[UserInfo sharedInstance] initUserInfo:self.myArray[indexPath.row]];
    
//    [UserDefault setObject:dic[@"token"] forKey:@"jmToken"]; //加密token
//    [[RCIM sharedRCIM] initWithAppKey:@"pwe86ga5pv916"];
    NSLog(@"%@////%@", [UserInfo sharedInstance].getRCtoken, [UserInfo sharedInstance].getUserid);
    NSLog(@"%@", _myArray[indexPath.row][@"id"]);
    [self requestChooseAccountOfData:_myArray[indexPath.row][@"id"]];
    
    [[UserInfo sharedInstance] initUserInfo:self.myArray[indexPath.row]];
//    [[RCIM sharedRCIM] connectWithToken:[UserInfo sharedInstance].getRCtoken success:^(NSString *userId) {
//        NSLog(@"子账号用户 %@登录成功", userId); //userId 001
//        //设置当前用户自己的名字和头像
//        self.currentUserInfo = [RCUserInfo new];
//        self.currentUserInfo.name = userId;
//        self.currentUserInfo.portraitUri = [UserInfo sharedInstance].getHeadImgUrl;
//        [[RCIM sharedRCIM] refreshUserInfoCache:self.currentUserInfo withUserId:[UserInfo sharedInstance].getUserid];
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            LKTabBarController *tabbar = [[LKTabBarController alloc] init];
//            [UIApplication sharedApplication].keyWindow.rootViewController = tabbar;
//            [SVProgressHUD dismiss];
//        });
//    } error:^(RCConnectErrorCode status) {
//        NSLog(@"错误状态 %ld", (long)status);
//    } tokenIncorrect:^{
//        NSLog(@"token错误");
//    }];
    
    FakeLaunchViewController *launchVC = [[FakeLaunchViewController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = launchVC;
}
- (void)requestIdentifiesData {
    NSString *jmString = [NSString stringWithFormat:@"%@%@%@", BD_key, BD_secret, [UserInfo sharedInstance].getjmToken];
    NSDictionary *paramet = @{@"userId" : [UserInfo sharedInstance].getUserid, @"sign" : jmString.md5String};
    [SCNetwork postWithURLString:BDUrl_s(@"user/getAllUser") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"dic:%@", dic);
            NSArray *usersArr = dic[@"users"];
            self.homeDic = dic[@"user"];
            self.myArray = dic[@"users"];
            [self.usersArray removeAllObjects];
            for (NSDictionary *listDic in usersArr) {
                SubIdentifyModel *model = [[SubIdentifyModel alloc] init];
                [model setValuesForKeysWithDictionary:listDic];
                [self.usersArray addObject:model];
                [self.identityTableView reloadData];

            }
        }

    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}

//切换账号
- (void)requestChooseAccountOfData:(NSString *)cutUserId {
    NSString *jmString = [NSString stringWithFormat:@"%@%@%@", BD_key, BD_secret, [UserInfo sharedInstance].getjmToken];
    NSDictionary *paramet = @{@"userId" : [UserInfo sharedInstance].getUserid, @"sign" : jmString.md5String, @"cutUserId" : cutUserId};
    [SCNetwork postWithURLString:BDUrl_s(@"user/cutAccount") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"%@", dic);
            [UserDefault setObject:dic[@"token"] forKey:@"jmToken"];
            [UserDefault synchronize];
        }else {
            NSLog(@"失败%@", dic[@"result"]);
            [self alertShowWithTitle:dic[@"result"]];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}
- (void)toSetSubIdentify {
    AddSubIdentifyController *vc = [[AddSubIdentifyController alloc] init];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)switchHomeAccount {
    NSLog(@"%@", _homeDic);
    [SVProgressHUD show];
    [[RCIM sharedRCIM] disconnect]; //融云退出登录
    [self requestChooseAccountOfData:[UserDefault objectForKey:@"mainId"]];


    [[UserInfo sharedInstance] initUserInfo:self.homeDic];


//    //    [[RCIM sharedRCIM] initWithAppKey:@"pwe86ga5pv916"];
//
//    NSLog(@"%@////%@", [UserInfo sharedInstance].getRCtoken, [UserInfo sharedInstance].getUserid);
//    [[RCIM sharedRCIM] connectWithToken:[UserInfo sharedInstance].getRCtoken success:^(NSString *userId) {
//        NSLog(@"子账号用户 %@登录成功", userId); //userId 001
//        //设置当前用户自己的名字和头像
//        self.currentUserInfo = [RCUserInfo new];
//        self.currentUserInfo.name = userId;
//        self.currentUserInfo.portraitUri = [UserInfo sharedInstance].getUserid;
//        [[RCIM sharedRCIM] refreshUserInfoCache:self.currentUserInfo withUserId:[UserInfo sharedInstance].getUserid];
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            LKTabBarController *tabbar = [[LKTabBarController alloc] init];
//            [UIApplication sharedApplication].keyWindow.rootViewController = tabbar;
//            [SVProgressHUD dismiss];
//        });
//    } error:^(RCConnectErrorCode status) {
//        NSLog(@"错误状态 %ld", (long)status);
//    } tokenIncorrect:^{
//        NSLog(@"token错误");
//    }];
    
    FakeLaunchViewController *launchVC = [[FakeLaunchViewController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = launchVC;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.view.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
