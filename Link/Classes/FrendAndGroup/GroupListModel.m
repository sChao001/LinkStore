//
//  GroupListModel.m
//  Link
//
//  Created by Surdot on 2018/5/20.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "GroupListModel.h"

@implementation GroupListModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}
//
//+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
//    return @{@"groupid" : @"id"};
//}
- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _groupid = value;
    }else {
        [super setValue:value forKey:key];
    }
}
@end
