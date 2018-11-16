//
//  HotLabelsModel.m
//  Link
//
//  Created by Surdot on 2018/7/17.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "HotLabelsModel.h"

@implementation HotLabelsModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }else {
        [super setValue:value forKey:key];
    }
}
@end
