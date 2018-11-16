//
//  PlatformAccountModel.h
//  Link
//
//  Created by Surdot on 2018/9/6.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlatformAccountModel : NSObject
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *moneyStr;
@property (nonatomic, strong) NSDictionary *userEntity;
@end
