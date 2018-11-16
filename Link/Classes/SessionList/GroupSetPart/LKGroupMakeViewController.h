//
//  LKGroupMakeViewController.h
//  Link
//
//  Created by Surdot on 2018/5/23.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCBaseViewController.h"

@interface LKGroupMakeViewController : SCBaseViewController
@property (nonatomic, strong) NSString *groupIdStr;
@property (nonatomic, strong) NSMutableArray *memberArray;
@end
