//
//  PersonIntroViewController.h
//  Link
//
//  Created by Surdot on 2018/5/21.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCBaseViewController.h"

@interface PersonIntroViewController : SCBaseViewController
@property (nonatomic, strong) NSString *headerStr;
@property (nonatomic, strong) NSString *naameStr;
@property (nonatomic, strong) NSString *friendId;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSString *accountStr;
@end
