//
//  HomeInfoModel.m
//  Link
//
//  Created by Surdot on 2018/7/13.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "HomeInfoModel.h"

@implementation HomeInfoModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _iD = value;
    }else {
        [super setValue:value forKey:key];
    }
}
@end

@implementation HomeInfoUserModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

@end
