//
//  UserInfo.h
//  Link
//
//  Created by Surdot on 2018/5/7.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import <Foundation/Foundation.h>

/**性别*/
extern NSString *const k_sex;
/**姓名*/
extern NSString *const k_name;
/**昵称*/
extern NSString *const k_nickname;
/**融云 id*/
extern NSString *const k_id;
/**融云token*/
extern NSString *const k_token;
/**头像链接*/
extern NSString *const k_headImg;
/**头像占位图*/
extern NSString *const k_placeholder;
/**手机号*/
extern NSString *const k_mobile;
/**account*/
extern NSString *const k_account;
/**jmToken*/
extern NSString *const k_jmToken;

@interface UserInfo : NSObject

+ (UserInfo *)sharedInstance;

/**保存用户信息*/
- (void)initUserInfo:(NSDictionary *)info;


//获取用户信息
/**用户id*/
- (NSString *)getUserid;
/**融云 token*/
- (NSString *)getRCtoken;
/**用户头像链接*/
- (NSString *)getHeadImgUrl;
/**用户头像图片*/
- (UIImage *)getPlaceholder;
/**昵称*/
- (NSString *)getNickName;
/**手机号*/
- (NSString *)getMobile;
/**性别*/
- (NSString *)getSex;
/**手机号或LINK号*/
- (NSString *)getAccount;
/**加密token*/
- (NSString *)getjmToken;



@end
