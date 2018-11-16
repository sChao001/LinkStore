//
//  LKMessageListCell.h
//  Link
//
//  Created by Surdot on 2018/4/20.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>

@interface LKMessageListCell : RCConversationBaseCell
@property(nonatomic, strong) UIImageView *iconImgView;
@property(nonatomic, strong) UILabel *titleLb;
@property(nonatomic, strong) UILabel *messageLb;
@property (nonatomic, strong) UIView *lineView;
@end
