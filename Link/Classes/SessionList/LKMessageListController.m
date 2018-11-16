//
//  LKMessageListController.m
//  Link
//
//  Created by Surdot on 2018/4/18.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "LKMessageListController.h"
#import "LKSessionViewController.h"
#import "SpeechViewController.h"
#import "ViewController.h"
#import "LKTabBarController.h"
#import "LkSearchViewController.h"
#import "SearchUserViewController.h"
#import "LKMessageListCell.h"
#import "LKUserInfo.h"
#import "ListViewCell.h"
#import "AddSubIdentifyController.h"
#import <Accelerate/Accelerate.h>
#import "TopShowOfIdedtifyController.h"



@interface LKMessageListController () ///<RCConversationCellDelegate>
@property (nonatomic, strong) RCUserInfo *currentUserInfo;
@property (nonatomic, strong) SpeechViewController *speechVC;
@property (nonatomic, strong) ViewController *vc;
@property (nonatomic, strong) LKTabBarController *tabBarVC;
@property (nonatomic, strong) ViewController *vC;
@property(nonatomic, assign) BOOL isClick;
@property (nonatomic, strong) UIImageView *showImageView;
@property (nonatomic, strong) UITableView *identityTableView;
@property (nonatomic, strong) RImagButton *setBtn;
@property (nonatomic, strong) UIView *lineViewOne;
@property (nonatomic, strong) RImagButton *homeBtn;
@property (nonatomic, strong) TopShowOfIdedtifyController *showVC;
@end

@implementation LKMessageListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    _showVC = [[TopShowOfIdedtifyController alloc] init];
    [self.view addSubview:_showVC.view];
    [self addChildViewController:_showVC];
    _showVC.view.hidden = YES;
    
//    [self setRightBarButtonWithNorImgName:@"add" select:@selector(showMenu:)];
//    [self setMyNavigationBarShowOfImage];
//    [self setNavigationCustomBarView];//自定义的导航栏

    [self setMyNavigationBarOfBackground:RGB(2, 133, 193)];
    [self setNavigationBarItem];
    
//    self.title = @"会话";//
    
//    [[RCIMClient sharedRCIMClient] setConversationToTop:ConversationType_PRIVATE targetId:@"5" isTop:NO];
    
    
    
//    [[RCIMClient sharedRCIMClient] setConversationNotificationStatus:ConversationType_PRIVATE targetId:@"5" isBlocked:NO success:^(RCConversationNotificationStatus nStatus) {
//        NSLog(@"%lu", (unsigned long)nStatus);
////        [UserDefault setObject:@"" forKey:[NSString stringWithFormat:@"NoMessage_%@_%@", self.useridStr, [UserInfo sharedInstance].getUserid]];
//
//    } error:^(RCErrorCode status) {
//        NSLog(@"%ld", (long)status);
//    }];
    
    [self makeSessionType];
//    self.emptyConversationView.backgroundColor = [UIColor yellowColor];
//    self.emptyConversationView.frame = CGRectMake(0, 0, 0, 0);
    
//    self.conversationListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.conversationListTableView.bounces = NO;
    self.conversationListTableView.backgroundColor = RGB(215, 215, 215);
    self.conversationListTableView.showsVerticalScrollIndicator = NO;
    self.conversationListTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//    self.conversationListTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];//去掉空白cell的分割线
    //设置会话列表cell的背景颜色
//    self.cellBackgroundColor = [UIColor redColor];
    
    
    //设置tableView样式
//    self.conversationListTableView.separatorColor = RGB(10, 100, 10);
//    self.conversationListTableView.tableFooterView = [UIView new];
 
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//    });

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //保证token连接成功后刷新消息列表
        [self refreshConversationTableViewIfNeeded];
        
        //设置当前用户自己的名字和头像
        self.currentUserInfo = [RCUserInfo new];
        //    self.currentUserInfo.name = userId;
        self.currentUserInfo.portraitUri = @"https://api.joint-think.com/uploads/face/20180312/15208274169226.png";
        [[RCIM sharedRCIM] refreshUserInfoCache:self.currentUserInfo withUserId:[UserInfo sharedInstance].getRCtoken];
    });
//    [[RCIM sharedRCIM] setReceiveMessageDelegate:self];
    
    
//    self.vC = [[ViewController alloc] init];
//    [self.view addSubview:_vC.view];
//    [self addChildViewController:_vC];
//    _vC.view.hidden = YES;
    
//    [self setIdentityLayoutView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _isClick = YES;
    
    self.tabBarController.tabBar.hidden = NO;
    [RCIM sharedRCIM].globalMessagePortraitSize = CGSizeMake(kWidthScale(36), kWidthScale(36));
    [RCIM sharedRCIM].globalConversationPortraitSize = CGSizeMake(50, 50);
    
    
}
- (void)setNavigationBarItem {
    UIImage *imageLeft = [UIImage imageNamed:@"accountSign"];
    UIImage *selectImage0 = [imageLeft imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:selectImage0 style:UIBarButtonItemStylePlain target:self action:@selector(switchSubAccount)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    UIImage *image = [UIImage imageNamed:@"add"];
    UIImage *selectImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightBarItemOne = [[UIBarButtonItem alloc] initWithImage:selectImage style:UIBarButtonItemStylePlain target:self action:@selector(showMenu:)];
    
//    UIImage *image1 = [UIImage imageNamed:@"search"];
//    UIImage *selectImage1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem *rightBarItemTwo = [[UIBarButtonItem alloc] initWithImage:selectImage1 style:UIBarButtonItemStylePlain target:self action:@selector(clicked)];
//    self.navigationItem.rightBarButtonItems = @[rightBarItemOne, rightBarItemTwo];
    self.navigationItem.rightBarButtonItem = rightBarItemOne;
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
        make.top.equalTo(LK_iPhoneXNavHeight+10);
        make.size.equalTo(CGSizeMake(kWidthScale(151), kWidthScale(220)));
    }];
    _identityTableView.backgroundColor = [UIColor clearColor];
    _identityTableView.hidden = YES;


    UIView *footView = [[UIView alloc] init];
    _identityTableView.tableFooterView = footView;
//    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.right.equalTo(0);
//        make.height.equalTo(kWidthScale(81));
//    }];
    
    footView.frame = CGRectMake(0, 0, kWidthScale(151), 81);
    footView.backgroundColor = [RGB(2, 133, 193) colorWithAlphaComponent:0.9];
    footView.backgroundColor = [UIColor colorWithPatternImage:[self blurryImage:[UIImage imageWithColor:[RGB(2, 133, 193) colorWithAlphaComponent:0.9]] withBlurLevel:0.1]];
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
}
//#pragma mark - 子账号弹框
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (tableView.tag == 100) {
//        return _usersArray.count;
//    }
//    return self.conversationListDataSource.count;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (tableView.tag == 100) {
//        return kWidthScale(45);
//    }
//    return 50;
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (tableView.tag == 100) {
//        SubIdentifyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifyCell" forIndexPath:indexPath];
//        SubIdentifyModel *model = self.usersArray[indexPath.row];
//        [cell.iconImg sd_setImageWithURL:[NSURL URLWithString:BDUrl_(model.headUrl)]];
//
//        cell.titleLb.text = model.nickName;
//        return cell;
//    }else {
//        return [RCConversationBaseCell new];
//    }
//
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}
//- (void)requestIdentifiesData {
//    NSDictionary *paramet = @{@"userId" : [UserInfo sharedInstance].getUserid};
//    [SCNetwork postWithURLString:BDUrl_(@"user/getAllUser") parameters:paramet success:^(NSDictionary *dic) {
//        if ([dic[@"code"] integerValue] > 0) {
//            NSLog(@"dic:%@", dic);
//            NSArray *usersArr = dic[@"users"];
//            [self.usersArray removeAllObjects];
//            for (NSDictionary *listDic in usersArr) {
//                SubIdentifyModel *model = [[SubIdentifyModel alloc] init];
//                [model setValuesForKeysWithDictionary:listDic];
//                [self.usersArray addObject:model];
//                [self.identityTableView reloadData];
//            }
//        }
//
//    } failure:^(NSError *error) {
//        [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
//        [SVProgressHUD dismissWithDelay:0.7];
//    }];
//}

- (void)toSetSubIdentify {
    AddSubIdentifyController *vc = [[AddSubIdentifyController alloc] init];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)customShowIdentifyView {
    
}
//自定义导航栏
- (void)setNavigationCustomBarView {
    [self setMyNavigationBarClear];
    _navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, LK_iPhoneXNavHeight)];
    [self.view addSubview:_navigationView];
    _navigationView.backgroundColor = RGB(2, 133, 193);
//    [self.view bringSubviewToFront:_navigationView];
    

//    _navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, LK_iPhoneXNavHeight)];
//    _navigationView.backgroundColor = [UIColor orangeColor];
//    [[[UIApplication sharedApplication].delegate window] addSubview:_navigationView];
    
    
}
- (void)switchSubAccount {
//    if (_identityTableView.hidden) {
//        _identityTableView.hidden = NO;
////        [self requestIdentifiesData];
//    }else {
//        _identityTableView.hidden = YES;
//    }
    
    if (_showVC.view.hidden) {
        _showVC.view.hidden = NO;
    }else {
        _showVC.view.hidden = YES;
    }
}

- (void)add {
    NSLog(@"被点击了");
    
//    NSDictionary *paramet = @{@"userId" : @"001", @"groupName" : @"你真牛逼", @"userIds" :@"3,4,5,6"};
//    [SCNetwork postWithURLString:@"" parameters:paramet success:^(NSDictionary *dic) {
//        if ([dic[@"code"] integerValue] > 0) {
//            <#statements#>
//        }
//    } failure:^(NSError *error) {
//
//    }];
}

- (void)clicked {
    NSLog(@"点击搜索");
    //搜索用户添加好友
    NSDictionary *paramet = @{@"account" : @"15201152903", @"userId" : @"3"};
    [SCNetwork postWithURLString:@"http://192.168.3.9:8080/user/get" parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"请求成功%@, result:%@", dic[@"code"], dic[@"result"]);
        }else {
            NSLog(@"请求失败%@, result:%@", dic[@"code"], dic[@"result"]);
        }
    } failure:^(NSError *error) {
        NSLog(@"网络连接失败");
    }];
    
}


- (void)showMenu:(UIButton *)sender {
//    //新建一个聊天会话View Controller对象,建议这样初始化
    LKSessionViewController *chatVC = [[LKSessionViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:@"5"];
    self.tabBarController.tabBar.hidden = YES;
////    //设置聊天会话界面要显示的标题
    chatVC.title = @"会话详情";
////    //显示聊天会话界面
    [self.navigationController pushViewController:chatVC animated:YES];
//    self.tabBarController.tabBar.hidden = YES;
//    [[RCCall sharedRCCall] isVideoCallEnabled:ConversationType_PRIVATE];
//    [[RCCall sharedRCCall] isAudioCallEnabled:ConversationType_PRIVATE];
////    [[RCCall sharedRCCall] startSingleCall:@"002" mediaType:RCCallMediaVideo];
//    [[RCCall sharedRCCall] startSingleCall:@"004" mediaType:RCCallMediaVideo];
    
//    [[RCCall sharedRCCall] startMultiCall:3 targetId:@"" mediaType:RCCallMediaAudio];
    
    
//    self.speechVC = [[SpeechViewController alloc] init];
//    [self.navigationController pushViewController:_speechVC animated:YES];
    
//    //- (NSArray<RCExtensionPluginItemInfo *> *)getPluginBoardItemInfoList
    
    //查询用户
    
    
    
    
    
}



- (void)makeSessionType {
    //设置需要显示哪些类型的会话
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                        @(ConversationType_DISCUSSION),
                                        @(ConversationType_CHATROOM),
                                        @(ConversationType_GROUP),
                                        @(ConversationType_APPSERVICE),
                                        @(ConversationType_SYSTEM)]];
    //设置需要将哪些类型的会话在会话列表中聚合显示
//    [self setCollectionConversationType:@[@(ConversationType_DISCUSSION),
//                                          @(ConversationType_GROUP)]];
    [self setCollectionConversationType:@[@(ConversationType_SYSTEM)]];
}
//即将显示的cell回调
- (void)willDisplayConversationTableCell:(RCConversationBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath {
//    RCConversationCell *concell = (RCConversationCell *)cell;
    
    
////    ((RCConversationCell *)cell).headerImageViewBackgroundView.backgroundColor = [UIColor redColor];
////    ((RCConversationCell *)cell).conversationTagView.size = CGSizeMake(20, 10);
////    concell.conversationTagView.backgroundColor = [UIColor redColor];
//    concell.enableNotification = YES;
//
//    concell.isShowNotificationNumber = YES;
////    concell.bubbleTipView.backgroundColor = [UIColor yellowColor];
//    concell.conversationTitle.textColor = [UIColor redColor];
//    concell.conversationTitle.backgroundColor = [UIColor yellowColor];
    
    
//    concell.conversationTitle.font = [UIFont systemFontOfSize:kWidthScale(16)];
//    [concell.conversationTitle setTextColor:RGB(61, 58, 57)];
//    [concell.conversationTitle mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(30 + kWidthScale(43));
//    }];
//    [concell.messageContentLabel setTextColor:RGB(71, 71, 71)];
//    concell.messageContentLabel.font = [UIFont systemFontOfSize:kWidthScale(13)];
//    [concell.messageContentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(10);
//    }];


//    UIView *viewBottom = [[UIView alloc] init];
//    [concell addSubview:viewBottom];
//    [viewBottom mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(0);
//        make.bottom.mas_equalTo(1);
//        make.height.mas_equalTo(kWidthScale(6));
//    }];
//    viewBottom.backgroundColor = RGB(215, 215, 215);
////    [concell setSelectionStyle:UITableViewCellSelectionStyleNone];
//
////    LKMessageListCell *listCell = (LKMessageListCell *)cell;
////    listCell.iconImgView.backgroundColor = [UIColor orangeColor];
//
//    UIView *viewleft = [[UIView alloc] init];
//    [concell addSubview:viewleft];
//    [viewleft mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.bottom.top.mas_equalTo(0);
//        make.width.mas_equalTo(5);
//    }];
//    viewleft.backgroundColor = RGB(215, 215, 215);
//
//    UIView *viewRight = [[UIView alloc] init];
//    [concell addSubview:viewRight];
//    [viewRight mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.right.bottom.mas_equalTo(0);
//        make.width.mas_equalTo(5);
//    }];
//    viewRight.backgroundColor = RGB(215, 215, 215);
//
//    if (indexPath.row == 0) {
//        UIView *topView = [[UIView alloc] init];
//        [concell addSubview:topView];
//        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.right.mas_equalTo(0);
//            make.height.mas_equalTo(kWidthScale(6));
//        }];
//        topView.backgroundColor = RGB(215, 215, 215);
//    }
    
}
//点击cell头像回调
- (void)didTapCellPortrait:(RCConversationModel *)model {
//    LKLittleSessionViewController *vc = [[LKLittleSessionViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
//    self.tabBarController.tabBar.hidden = YES;
    
//    self.vC.view.hidden = NO;

}

//点击消息列表中的cell
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath {
//    LKSessionViewController *session = [[LKSessionViewController alloc] init];
//    session.conversationType = model.conversationType;
//    session.targetId = model.targetId;
//    session.title = @"好友会话";
//    self.tabBarController.tabBar.hidden = YES;
//    [self.navigationController pushViewController:session animated:YES];
    
//    if (conversationModelType == RC_CONVERSATION_MODEL_TYPE_COLLECTION) {
//        LKMessageListController *tempVC = [[LKMessageListController alloc] init];
//        NSArray *array = [NSArray arrayWithObject:[NSNumber numberWithInt:model.conversationModelType]];
//        [tempVC setDisplayConversationTypes:array];
//        [tempVC setCollectionConversationType:nil];
//        tempVC.isEnteredToCollectionViewController = YES;
//        [self.navigationController pushViewController:tempVC animated:YES];
//    }
    
    if (_isClick) {
        _isClick = NO;
        if (model.conversationModelType == RC_CONVERSATION_MODEL_TYPE_PUBLIC_SERVICE) {//service 公共服务的会话显示
            LKSessionViewController *_conversationVC = [[LKSessionViewController alloc] init];
            _conversationVC.conversationType = model.conversationType;
            _conversationVC.targetId = model.targetId;
            
//            _conversationVC.userName = model.conversationTitle;
            _conversationVC.title = model.conversationTitle;
            _conversationVC.conversation = model;
            [self.navigationController pushViewController:_conversationVC animated:YES];
        }
        
        if (conversationModelType == RC_CONVERSATION_MODEL_TYPE_NORMAL) {// normal 默认显示
            LKSessionViewController *_conversationVC = [[LKSessionViewController alloc] init];
            _conversationVC.conversationType = model.conversationType;
            _conversationVC.targetId = model.targetId;
            NSLog(@"%@", model.targetId);
              //获取当前用户id
//            _conversationVC.userName = model.conversationTitle;
            _conversationVC.title = model.conversationTitle;
            _conversationVC.conversation = model;
            _conversationVC.unReadMessage = model.unreadMessageCount;
            _conversationVC.enableNewComingMessageIcon = YES; //开启消息提醒
            _conversationVC.enableUnreadMessageIcon = YES;
            if (model.conversationType == ConversationType_SYSTEM) {//系统会话
//                _conversationVC.userName = @"系统消息";
                _conversationVC.title = @"系统消息";
                NSLog(@"收到了系统消息");
            }
            if ([model.objectName isEqualToString:@"RC:ContactNtf"]) {
//                RCDAddressBookViewController *addressBookVC = [RCDAddressBookViewController addressBookViewController];
//                addressBookVC.needSyncFriendList = YES;
//
//                [self.navigationController pushViewController:addressBookVC animated:YES];
//                return;
                
                ViewController *vc = [[ViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            //如果是单聊，不显示发送方昵称
            if (model.conversationType == ConversationType_PRIVATE) {
            
                _conversationVC.displayUserNameInCell = NO;
            }
            self.tabBarController.tabBar.hidden = YES;
            
            [self.navigationController pushViewController:_conversationVC animated:YES];
        }
        
        //聚合会话类型，此处自定设置。
        if (conversationModelType == RC_CONVERSATION_MODEL_TYPE_COLLECTION) {
            
            LKMessageListController *temp = [[LKMessageListController alloc] init];
            NSArray *array = [NSArray arrayWithObject:[NSNumber numberWithInt:model.conversationType]];
            [temp setDisplayConversationTypes:array];
            NSLog(@"%@", array);
            [temp setCollectionConversationType:nil];
            temp.isEnteredToCollectionViewController = YES;

            NSLog(@"%@000%@", [NSThread currentThread], self.navigationController);
            [self.navigationController pushViewController:temp animated:YES];
            
            NSLog(@"你牛逼");
        }
        
        //自定义会话类型
        if (conversationModelType == RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION) {
            RCConversationModel *model = self.conversationListDataSource[indexPath.row];
            
            if ([model.objectName isEqualToString:@"RC:ContactNtf"]) {
//                RCDAddressBookViewController *addressBookVC = [RCDAddressBookViewController addressBookViewController];
//                [self.navigationController pushViewController:addressBookVC animated:YES];
                
                ViewController *vc = [[ViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }
}
//插入自定义会话model
- (NSMutableArray *)willReloadTableData:(NSMutableArray *)dataSource {
    for (int i = 0; i < dataSource.count; i++) {
        RCConversationModel *model = dataSource[i];
        
        
//        if (model.conversationType == ConversationType_PRIVATE) {
//            model.conversationModelType = RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION;
//        }
        //筛选请求添加好友的系统消息，用于生成自定义会话类型的cell
        //RCContactNotificationMessage 好友请求消息类
        if (model.conversationType == ConversationType_SYSTEM &&
            [model.lastestMessage isMemberOfClass:[RCContactNotificationMessage class]]) {
            model.conversationModelType = RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION;
        }
//        if (model.conversationType == ConversationType_SYSTEM &&
//            [model.lastestMessage isMemberOfClass:[RCContactNotificationMessage class]]) {
//            model.conversationModelType = 3; //自定义会话显示
//            RCContactNotificationMessage *_contactNotificationMsg = nil;
//            _contactNotificationMsg = (RCContactNotificationMessage *)model.lastestMessage;
//        }
        //群组
        if ([model.lastestMessage isKindOfClass:[RCGroupNotificationMessage class]]) {
            RCGroupNotificationMessage *groupNotification = (RCGroupNotificationMessage *)model.lastestMessage;
            if ([groupNotification.operation isEqualToString:@"Quit"]) {
                NSData *jsonData = [groupNotification.data dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *dictionary =
                [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                NSDictionary *data =
                [dictionary[@"data"] isKindOfClass:[NSDictionary class]] ? dictionary[@"data"] : nil;
                NSString *nickName =
                [data[@"operatorNickname"] isKindOfClass:[NSString class]] ? data[@"operatorNickname"] : nil;
                if ([nickName isEqualToString:[RCIM sharedRCIM].currentUserInfo.name]) {
                    [[RCIMClient sharedRCIMClient] removeConversation:model.conversationType targetId:model.targetId];
                    [self refreshConversationTableViewIfNeeded];
                }
            }
        }
    }
    return dataSource;
}
//左滑删除 自定义cell
- (void)rcConversationListTableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //可以从数据库删除数据
    RCConversationModel *model = self.conversationListDataSource[indexPath.row];
    [[RCIMClient sharedRCIMClient] removeConversation:ConversationType_SYSTEM targetId:model.targetId];
    [self.conversationListDataSource removeObjectAtIndex:indexPath.row];
    [self.conversationListTableView reloadData];
}
//删除会话cell
- (void)didDeleteConversationCell:(RCConversationModel *)model {
    [[RCIMClient sharedRCIMClient] removeConversation:ConversationType_PRIVATE targetId:model.targetId];
    [[RCIMClient sharedRCIMClient] clearMessages:ConversationType_PRIVATE targetId:model.targetId];
    // [[RCIMClient sharedRCIMClient] deleteMessages:ConversationType_PRIVATE targetId:model.targetId success:nil error:nil];
    [[RCIMClient sharedRCIMClient] deleteMessages:ConversationType_PRIVATE targetId:model.targetId success:^{
        
        NSLog(@"删除成功");
    } error:^(RCErrorCode status) {
        
        NSLog(@"删除失败");
    }];
    [self.conversationListTableView reloadData];

}

//////高度
//- (CGFloat)rcConversationListTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 67.0f;
//}
//自定义会话cell的显示回调
- (RCConversationBaseCell *)rcConversationListTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RCConversationModel *model = self.conversationListDataSource[indexPath.row];
    NSLog(@"自定义扩展数据%@", model.extend);

    __block NSString *userName = nil;
    __block NSString *portraitUri = nil;
    RCContactNotificationMessage *_contactNotificationMsg = nil;
//    NSLog(@"%@", _contactNotificationMsg);
//    __weak LKMessageListController *weakSelf = self;
    //此处需要添加根据userid来获取用户信息的逻辑，extend字段不存在于DB中，当数据来自db时没有extend字段内容，只有userid
    if (nil == model.extend) {
        // Not finished yet, To Be Continue...
        if (model.conversationType == ConversationType_SYSTEM &&
            [model.lastestMessage isMemberOfClass:[RCContactNotificationMessage class]]) {
            _contactNotificationMsg = (RCContactNotificationMessage *)model.lastestMessage;
            NSLog(@"%@", _contactNotificationMsg.message);
            if (_contactNotificationMsg.sourceUserId == nil) {
                LKMessageListCell *cell =
                [[LKMessageListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
                cell.messageLb.text = _contactNotificationMsg.message;
                cell.titleLb.text = @"好友请求";
                [cell.iconImgView sd_setImageWithURL:[NSURL URLWithString:portraitUri]
                              placeholderImage:[UIImage imageNamed:@"xitong"]];
                return cell;
            }
            NSDictionary *_cache_userinfo =
            [[NSUserDefaults standardUserDefaults] objectForKey:_contactNotificationMsg.sourceUserId];
            if (_cache_userinfo) {
                userName = _cache_userinfo[@"username"];
                portraitUri = _cache_userinfo[@"portraitUri"];
            } else {
                NSDictionary *emptyDic = @{};
                [[NSUserDefaults standardUserDefaults] setObject:emptyDic forKey:_contactNotificationMsg.sourceUserId];
                [[NSUserDefaults standardUserDefaults] synchronize];
//                [RCDHTTPTOOL
//                 getUserInfoByUserID:_contactNotificationMsg.sourceUserId
//                 completion:^(RCUserInfo *user) {
//                     if (user == nil) {
//                         return;
//                     }
//                     RCDUserInfo *rcduserinfo_ = [RCDUserInfo new];
//                     rcduserinfo_.name = user.name;
//                     rcduserinfo_.userId = user.userId;
//                     rcduserinfo_.portraitUri = user.portraitUri;
//
//                     model.extend = rcduserinfo_;
//
//                     // local cache for userInfo
//                     NSDictionary *userinfoDic =
//                     @{@"username" : rcduserinfo_.name, @"portraitUri" : rcduserinfo_.portraitUri};
//                     [[NSUserDefaults standardUserDefaults] setObject:userinfoDic
//                                                               forKey:_contactNotificationMsg.sourceUserId];
//                     [[NSUserDefaults standardUserDefaults] synchronize];
//
//                     [weakSelf.conversationListTableView
//                      reloadRowsAtIndexPaths:@[ indexPath ]
//                      withRowAnimation:UITableViewRowAnimationAutomatic];
//                 }];
            }
        }
        
    } else {
        LKUserInfo *user = (LKUserInfo *)model.extend;
        userName = user.name;
        portraitUri = user.portraitUri;
    }
    
    LKMessageListCell *cell = [[LKMessageListCell alloc] init];
//    RCMessageContent *content = [[RCMessageContent alloc] init];
    
    NSString *operation = _contactNotificationMsg.operation;
    NSString *operationContent;
    if ([operation isEqualToString:@"Request"]) {
        operationContent = [NSString stringWithFormat:@"来自%@的好友请求", userName];
        NSLog(@"Request: %@", operationContent);
    } else if ([operation isEqualToString:@"AcceptResponse"]) {
        operationContent = [NSString stringWithFormat:@"%@通过了你的好友请求", userName];
        NSLog(@"AcceptResponse: %@", operationContent);
    }
    cell.messageLb.text = _contactNotificationMsg.message;
    NSLog(@"%@", _contactNotificationMsg.message);
    cell.titleLb.text = @"好友请求消息";
    NSLog(@"%@", operationContent);
//    [cell.iconImgView sd_setImageWithURL:[NSURL URLWithString:portraitUri]
//                  placeholderImage:[UIImage imageNamed:@"xitong"]];
//    cell.labelTime.text = [RCKitUtility ConvertMessageTime:model.sentTime / 1000];
    
    cell.model = model;
    return cell;

}

#pragma mark - 收到消息监听
//收到个人消息、群消息会、系统消息走这个方法
- (void)didReceiveMessageNotification:(NSNotification *)notification {
    [super didReceiveMessageNotification:notification];
    RCMessage *message = notification.object;
    NSLog(@"消息消息 %@", message.content.senderUserInfo);
//    if ([message.content isMemberOfClass:[RCContactNotificationMessage class]]) {
//        if (message.conversationType != ConversationType_SYSTEM) {
//            NSLog(@"好友消息要发系统消息！！！");
//#if DEBUG
//            @throw [[NSException alloc] initWithName:@"error" reason:@"好友消息要发系统消息！！！" userInfo:nil];
//#endif
//        }
//    }
    
//    if (notification) {
//        [self refreshConversationTableViewIfNeeded]; //刷新消息列表
//        [RCIM sharedRCIM].disableMessageNotificaiton = YES;
//    }
}
//设置消息提示音
- (BOOL)onRCIMCustomAlertSound:(RCMessage *)message {
    NSLog(@"%@", message.senderUserId);
    [RCIM sharedRCIM].disableMessageAlertSound = NO;
    return NO;
}

//- (void)messageSomething {
//    if (<#condition#>) {
//        <#statements#>
//    }
//}


// 添加通用模糊效果 // image是图片，blur是模糊度
- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    if (image==nil) {
        NSLog(@"error:为图片添加模糊效果时，未能获取原始图片"); return nil;
    }
    //模糊度,
    if (blur < 0.025f) {
        blur = 0.025f;
        
    } else if (blur > 1.0f) {
        blur = 1.0f;
        
    }
    //boxSize必须大于0
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    NSLog(@"boxSize:%i",boxSize);
    //图像处理
    CGImageRef img = image.CGImage;
    //需要引入#import <Accelerate/Accelerate.h>
    //图像缓存,输入缓存，输出缓存
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    //像素缓存
    void *pixelBuffer;
    //数据源提供者，Defines an opaque type that supplies Quartz with data.
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    // provider’s data.
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    //宽，高，字节/行，data
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    //像数缓存，字节行*图片高
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    // 第三个中间的缓存区,抗锯齿的效果
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    //Convolves a region of interest within an ARGB8888 source image by an implicit M x N kernel that has the effect of a box filter.
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) { NSLog(@"error from convolution %ld", error);
        
    }
    // NSLog(@"字节组成部分：%zu",CGImageGetBitsPerComponent(img));
    //颜色空间DeviceRGB
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //用图片创建上下文,CGImageGetBitsPerComponent(img),7,8
    CGContextRef ctx = CGBitmapContextCreate( outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));
    //根据上下文，处理过的图片，重新组件
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    //CGColorSpaceRelease(colorSpace); //多余的释放
    CGImageRelease(imageRef);
    return returnImage;
}
@end
