//
//  UserInfo.m
//  Link
//
//  Created by Surdot on 2018/5/7.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "UserInfo.h"

/**性别*/
NSString *const k_sex         = @"sex";
/**姓名*/
NSString *const k_name        = @"name";
/**昵称*/
NSString *const k_nickname    = @"nickName";
/**融云 id*/
NSString *const k_id       = @"id";
/**融云token*/
NSString *const k_token    = @"token";
/**头像链接*/
NSString *const k_headImg    = @"headUrl";
/**头像占位图*/
NSString *const k_placeholder    = @"k_head_placeholder";
/**手机号*/
NSString *const k_mobile      = @"mobile";
/**account*/
NSString *const k_account     = @"account";


@implementation UserInfo

static UserInfo *_instance = nil;
+ (UserInfo *)sharedInstance {
    @synchronized (self) {
        if (_instance == nil) {
            [self new];
        }
    }
    return _instance;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    @synchronized (self) {
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
            return _instance;
        }
    }
    return _instance;
}

- (void)initUserInfo:(NSDictionary *)info {
    //性别
    NSString *sex_string = [NSString stringWithFormat:@"%@", info[k_sex]];
    [UserDefault setObject:sex_string forKey:k_sex];
    
    //昵称
    NSString *nick_name = [NSString stringWithFormat:@"%@", info[k_nickname]];
    [UserDefault setObject:nick_name forKey:k_nickname];
    
    //账号及电话
    NSString *accout = [NSString stringWithFormat:@"%@", info[k_mobile]];
    [UserDefault setObject:accout forKey:k_mobile];
    
    //账号
    NSString *zhangHao = [NSString stringWithFormat:@"%@", info[k_account]];
    [UserDefault setObject:zhangHao forKey:k_account];
    
    //融云id
    NSString *RC_id = [NSString stringWithFormat:@"%@", info[k_id]];
    [UserDefault setObject:RC_id forKey:k_id];
    
    //融云token
    NSString *RC_token = [NSString stringWithFormat:@"%@", info[k_token]];
    [UserDefault setObject:RC_token forKey:k_token];
    
    //头像url
    NSString *iconUrl = [NSString stringWithFormat:@"%@", info[k_headImg]];
    [UserDefault setObject:iconUrl forKey:k_headImg];
    
    [UserDefault synchronize];
}


- (NSString *)getMobile {
    return [UserDefault objectForKey:k_mobile];
}
- (NSString *)getAccount {
    return [UserDefault objectForKey:k_account];
}
- (NSString *)getUserid {
    return [UserDefault objectForKey:k_id];
}
- (NSString *)getRCtoken {
    return [UserDefault objectForKey:k_token];
}
- (NSString *)getNickName {
    return [UserDefault objectForKey:k_nickname];
}
- (NSString *)getSex {
    return [UserDefault objectForKey:k_sex];
}
- (NSString *)getHeadImgUrl {
    return [UserDefault objectForKey:k_headImg];
}
- (UIImage *)getPlaceholder {
    return [UserDefault objectForKey:k_placeholder];
}
- (NSString *)getjmToken {
    return [UserDefault objectForKey:@"jmToken"];
}







@end
