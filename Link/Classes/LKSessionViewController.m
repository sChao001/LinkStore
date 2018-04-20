//
//  LKSessionViewController.m
//  Link
//
//  Created by Surdot on 2018/4/19.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "LKSessionViewController.h"

@interface LKSessionViewController ()

@end

@implementation LKSessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    //新建一个聊天会话View Controller对象,建议这样初始化
//    RCConversationViewController *chat = [[RCConversationViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:@"11"];
////
////    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
////    chat.conversationType = ConversationType_PRIVATE;
////    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
////    chat.targetId = @"targetIdYouWillChatIn";
//
//    //设置聊天会话界面要显示的标题
//    chat.title = @"想显示的会话标题";
//    //显示聊天会话界面
//    [self.navigationController pushViewController:chat animated:YES];
    
    self.conversationMessageCollectionView.backgroundColor = RGB(245, 245, 0);
//    self.title = @"会话";
    
//    RCTextMessage *textMsg = [RCTextMessage messageWithContent:@"哈哈"];
    
}


@end
