//
//  MembersCardPayController.h
//  Link
//
//  Created by Surdot on 2018/8/16.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCBaseViewController.h"

@interface MembersCardPayController : SCBaseViewController
@property (nonatomic, strong) NSString *typeId;
@property (nonatomic) NSInteger number;

@property (nonatomic, strong) NSString *conversionRate;
@property (nonatomic, strong) NSString *gold;
@property (nonatomic, strong) NSString *realPrice;
@property (nonatomic, strong) NSString *returnMoney;
@property (nonatomic, strong) NSString *deduction;

//不同的支付页面参数
@property (nonatomic, strong) NSString *shopIdStr;
@property (nonatomic, strong) NSString *totalFeeStr;
@property (nonatomic, strong) NSString *comId;
@property (nonatomic, strong) NSString *returnMoneyTaoCan;
@end
