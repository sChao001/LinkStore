//
//  IMDataSource.m
//  Link
//
//  Created by Surdot on 2018/4/20.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "IMDataSource.h"

@implementation IMDataSource

static IMDataSource *_instance = nil;
+ (instancetype)sharedInstance {
    @synchronized(self){
        if (_instance == nil) {
            _instance = [self alloc];
        }
    }
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    });
    return _instance;
}
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion {
    NSLog(@"userId:%@", userId);
    RCUserInfo *user = [RCUserInfo new];
    user.name = userId;
    user.portraitUri = @"https://api.joint-think.com/uploads/face/20180201/15174910619319.png";
    completion(user);
}

//群组
- (void)getGroupInfoWithGroupId:(NSString *)groupId completion:(void (^)(RCGroup *))completion {
    NSLog(@"群组Id:%@", groupId);
}
















@end
