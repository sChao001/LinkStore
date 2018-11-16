//
//  AddgroupMemberController.m
//  Link
//
//  Created by Surdot on 2018/5/20.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "AddgroupMemberController.h"
#import "AddGroupmemberCell.h"
#import "FrendListModel.h"
#import "LKSessionViewController.h"

@interface AddgroupMemberController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *ListTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic) NSInteger indexPathRow;
@property (nonatomic, strong) NSMutableArray *GroupId;
@property (nonatomic, strong) NSMutableArray *useridsOfNickname;
@property (nonatomic, strong) UIButton *sureBtn;
@end

@implementation AddgroupMemberController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(239, 239, 239);
    [self creatListTableView];
    [self.ListTableView registerClass:[AddGroupmemberCell class] forCellReuseIdentifier:@"GroupList"];
    
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    self.GroupId = [NSMutableArray arrayWithCapacity:0];
    self.useridsOfNickname = [NSMutableArray arrayWithCapacity:0];
    [self requestData];
    _indexPathRow = -1;
    [self creatMyAlertlabel];
    [self setCommonLeftBarButtonItem];
    self.title = @"选择联系人";


//    UIImage *image = [UIImage imageNamed:@"sureGroup"];
//    UIImage *selectImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:selectImage style:UIBarButtonItemStylePlain target:self action:@selector(sureClicked)];
//
//    self.navigationItem.rightBarButtonItem = rightItem;
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.sureBtn.hidden = YES;
//    self.tabBarController.tabBar.hidden = YES;
}
- (void)sureClicked {
    [self alertShowWithTitle:@"建群需要选择2人以上"];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (void)creatListTableView {
    self.ListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - LK_iPhoneXNavHeight-kHeightScale(73)) style:UITableViewStylePlain];
    [self.view addSubview:_ListTableView];
    self.ListTableView.delegate = self;
    self.ListTableView.dataSource = self;
    self.ListTableView.showsVerticalScrollIndicator = NO;
    self.ListTableView.backgroundColor = RGB(239, 239, 239);
    self.ListTableView.bounces = NO;
    self.ListTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"dataArrayCount:%lu", (unsigned long)_dataArray.count);
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddGroupmemberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupList" forIndexPath:indexPath];
    FrendListModel *model = self.dataArray[indexPath.row];
    [cell.headerImg sd_setImageWithURL:[NSURL URLWithString:BDUrl_(model.headUrl)]];
    cell.nameLb.text = model.nickName;
//    if (cell.selected == YES) {
//        cell.sureImg.backgroundColor = [UIColor redColor];
//    }
    
    NSLog(@"<<%ld, %ld", (long)_indexPathRow, (long)indexPath.row);
    if (self.indexPathRow == indexPath.row) {
        cell.sureImg.selected = !cell.sureImg.selected;
        if (cell.sureImg.selected == YES) {
            [_GroupId addObject:model.iD];
            [_useridsOfNickname addObject:model.nickName];
            
            if (_GroupId.count >= 2) {
                UIImage *image = [UIImage imageNamed:@"y_graySure"];
                UIImage *selectImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:selectImage style:UIBarButtonItemStylePlain target:self action:@selector(completionChoose)];

                self.navigationItem.rightBarButtonItem = rightItem;
            }
        }else {
            [_GroupId removeObject:model.iD];
            [_useridsOfNickname removeObject:model.nickName];
            if (_GroupId.count < 2) {
                UIImage *image = [UIImage imageNamed:@""];
                UIImage *selectImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:selectImage style:UIBarButtonItemStylePlain target:self action:@selector(notCompletionChoose)];

                self.navigationItem.rightBarButtonItem = rightItem;
            }
        }
    }

    return cell;
}
- (void)notCompletionChoose {
    NSLog(@"123");
}
//网络请求建群
- (void)completionChoose {
    NSString * parameString = @"";
    for (int i = 0; i < _GroupId.count; i++) {
        NSString * userid = @"";
//        if (i==0) {
//            userid= [NSString stringWithFormat:@"%@",_GroupId[i]];
//        } else {
//            userid = [NSString stringWithFormat:@",%@,",_GroupId[i]];
//        }
        userid = [NSString stringWithFormat:@"%@,",_GroupId[i]];
        NSLog(@"%@", userid);
        parameString = [parameString stringByAppendingString:userid];
    }
    NSLog(@"parameString:%@", parameString);
    
    NSString *nicknameStr = @"";
    for (int i = 0; i < _useridsOfNickname.count; i++) {
        NSString * name = @"";
        if (i==0) {
            name = [NSString stringWithFormat:@"%@",_useridsOfNickname[i]];
        } else {
            name = [NSString stringWithFormat:@"、%@",_useridsOfNickname[i]];
        }
        NSLog(@"%@", name);
        nicknameStr = [nicknameStr stringByAppendingString:name];
    }
    NSLog(@"nameString:%@", nicknameStr);

    NSString *jmString = [NSString stringWithFormat:@"%@%@%@", BD_key, BD_secret, [UserInfo sharedInstance].getjmToken];
    NSDictionary *paramet = @{@"userId" : [UserInfo sharedInstance].getUserid, @"groupName" : nicknameStr, @"userIds" : parameString, @"nickName" : [UserInfo sharedInstance].getNickName, @"sign" : jmString.md5String};
    [SVProgressHUD show];
    [SCNetwork postWithURLString:BDUrl_s(@"group/add") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {

            NSLog(@"建群成功:%@", dic);
            NSDictionary *groupDic = dic[@"groups"];
            LKSessionViewController *sessionVC = [[LKSessionViewController alloc] initWithConversationType:ConversationType_GROUP targetId:[NSString stringWithFormat:@"%@", groupDic[@"id"]]];
            sessionVC.title = groupDic[@"name"];
            [self.navigationController pushViewController:sessionVC animated:YES];
        }else {
            [self alertShowWithTitle:dic[@"result"]];
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
        [SVProgressHUD dismissWithDelay:0.6];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kWidthScale(54);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO]; //取消点击状态
    
    self.indexPathRow = indexPath.row;
    [self.ListTableView reloadData];
    
}
- (void)requestData {
    NSLog(@"==%@", [UserInfo sharedInstance].getUserid);
    NSString *jmString = [NSString stringWithFormat:@"%@%@%@", BD_key, BD_secret, [UserInfo sharedInstance].getjmToken];
    NSDictionary *paramet = @{@"userId" : [UserInfo sharedInstance].getUserid, @"sign" : jmString.md5String};
    [SCNetwork postWithURLString:BDUrl_s(@"userRelation/getfriendList") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"请求成功");
            //            [self.dataArray removeAllObjects];
            NSArray *dicArr = dic[@"friends"];
            NSLog(@"%@", dic);
            for (NSDictionary *friendDic in dicArr) {
                FrendListModel *model = [[FrendListModel alloc] init];
                [model setValuesForKeysWithDictionary:friendDic];
                [self.dataArray addObject:model];
                [self.ListTableView reloadData];
                NSLog(@"%@__%@++ID:%@___ %lu,==%@", model.headUrl, model.nickName, model.iD,self.dataArray.count, model);
            }
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"请求失败，请查看网络"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
