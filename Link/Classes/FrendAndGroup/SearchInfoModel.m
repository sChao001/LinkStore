//
//  SearchInfoModel.m
//  Link
//
//  Created by Surdot on 2018/5/21.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "SearchInfoModel.h"

@implementation SearchInfoModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }else {
        [super setValue:value forKey:key];
    }
}
@end
