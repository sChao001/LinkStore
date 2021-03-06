//
//  LKSessionViewController.h
//  Link
//
//  Created by Surdot on 2018/4/19.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>

@interface LKSessionViewController : RCConversationViewController
/**
 *  会话数据模型
 */
@property(strong, nonatomic) RCConversationModel *conversation;
@property (nonatomic, strong) NSString *backImgStr;

@end
