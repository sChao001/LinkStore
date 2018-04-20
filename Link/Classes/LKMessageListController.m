//
//  LKMessageListController.m
//  Link
//
//  Created by Surdot on 2018/4/18.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "LKMessageListController.h"
#import "LKSessionViewController.h"

@interface LKMessageListController ()

@end

@implementation LKMessageListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(245, 245, 245);
    [self setRightBarButtonWithNorImgName:@"add" select:@selector(showMenu:)];
    [self setMyNavigationBarShowOfImage];
    [[RCIM sharedRCIM] initWithAppKey:@"pwe86ga5pv916"];
    [[RCIM sharedRCIM] connectWithToken:@"7mTAUkJS1N+qOENhRt6ZjqM6qVKrzzxklJgs+adIwEJT2sbSB20jeehgl9kmntxJ3GRSLQy6wDaw8VV3s7Ri3A==" success:^(NSString *userId) {
        NSLog(@"用户 %@登录成功", userId);
    } error:^(RCConnectErrorCode status) {
        NSLog(@"错误状态 %ld", (long)status);
    } tokenIncorrect:^{
        NSLog(@"token错误");
    }];
    
    [[RCIM sharedRCIM].userInfoDataSource getUserInfoWithUserId:@"001" completion:^(RCUserInfo *userInfo) {
        
    }];
    self.title = @"会话";//
    
    [self makeSessionType];
//    self.emptyConversationView.backgroundColor = [UIColor yellowColor];
//    self.emptyConversationView.frame = CGRectMake(0, 0, 0, 0);
    self.conversationListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.conversationListTableView.bounces = NO;
    
    
//    self.navigationController.navigationBar.backgroundColor = [UIColor blueColor];
//    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
//    self.navigationController.navigationBar.translucent = YES;
    
    
    //设置tableView样式
//    self.conversationListTableView.separatorColor = RGB(10, 100, 10);
//    self.conversationListTableView.tableFooterView = [UIView new];
//    self.conversationListTableView.backgroundColor = [UIColor yellowColor];

    
}
- (void)showMenu:(UIButton *)sender {
    //新建一个聊天会话View Controller对象,建议这样初始化
    LKSessionViewController *chatVC = [[LKSessionViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:@"002"];

    //设置聊天会话界面要显示的标题
    chatVC.title = @"会话详情";
    //显示聊天会话界面
    [self.navigationController pushViewController:chatVC animated:YES];

    
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
    [self setCollectionConversationType:@[@(ConversationType_DISCUSSION),
                                          @(ConversationType_GROUP)]];
}

- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath {
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType = model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.title = @"会话详情";
    [self.navigationController pushViewController:conversationVC animated:YES];
}
@end
