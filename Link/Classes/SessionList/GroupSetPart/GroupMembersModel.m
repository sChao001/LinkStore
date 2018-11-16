//
//  GroupMembersModel.m
//  Link
//
//  Created by Surdot on 2018/5/23.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "GroupMembersModel.h"

@implementation GroupMembersModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }else {
        [super setValue:value forKey:key];
    }
}
@end
