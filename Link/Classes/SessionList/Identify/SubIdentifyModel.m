//
//  SubIdentifyModel.m
//  Link
//
//  Created by Surdot on 2018/5/30.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "SubIdentifyModel.h"

@implementation SubIdentifyModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }else {
        [super setValue:value forKey:key];
    }
}
@end
