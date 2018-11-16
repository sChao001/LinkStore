//
//  EditDetailInfoController.h
//  Link
//
//  Created by Surdot on 2018/5/30.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCBaseViewController.h"

@protocol EditDetailInfoControllerDelegate<NSObject>
@optional
- (void)showText:(NSString *)text;
- (void)showNickName:(NSString *)nameStr;
- (void)showCustomSign:(NSString *)signStr;
@end

@interface EditDetailInfoController : SCBaseViewController
@property (nonatomic, strong) NSString *myString;
//@property (nonatomic, copy) void(^block)(NSString *text);
@property (nonatomic, weak) id<EditDetailInfoControllerDelegate> delegate;
@end
