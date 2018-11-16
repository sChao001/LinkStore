//
//  AppDelegate+LogIn.h
//  Link
//
//  Created by Surdot on 2018/8/6.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (LogIn) <RCIMUserInfoDataSource, RCIMGroupInfoDataSource, RCIMConnectionStatusDelegate>
//@property (nonatomic, strong) RCUserInfo *currentUserInfo;
@property (nonatomic, strong) NSMutableArray *dataArray;
- (void)configLogInSettings;
@end
