//
//  SubIdentifyModel.h
//  Link
//
//  Created by Surdot on 2018/5/30.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubIdentifyModel : NSObject
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *headUrl;
@property (nonatomic, strong) NSNumber *sex;
@end
