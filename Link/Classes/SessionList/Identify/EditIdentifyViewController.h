//
//  EditIdentifyViewController.h
//  Link
//
//  Created by Surdot on 2018/5/29.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCBaseViewController.h"

@interface EditIdentifyViewController : SCBaseViewController
@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *headUrl;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *signature;
@end
