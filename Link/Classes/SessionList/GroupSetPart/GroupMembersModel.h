//
//  GroupMembersModel.h
//  Link
//
//  Created by Surdot on 2018/5/23.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupMembersModel : NSObject
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *headUrl;
@end
