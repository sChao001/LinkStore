//
//  SignUpViewController.h
//  Link
//
//  Created by Surdot on 2018/5/7.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "SCBaseViewController.h"
#import "LoginViewController.h"

@interface SignUpViewController : SCBaseViewController
@property (nonatomic, strong) LoginViewController *loginVC;
@property (nonatomic, strong) NSString *useridStr;
@end
