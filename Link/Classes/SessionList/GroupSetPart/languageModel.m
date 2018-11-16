//
//  languageModel.m
//  Link
//
//  Created by Surdot on 2018/5/28.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "languageModel.h"

@implementation languageModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }else {
        [super setValue:value forKey:key];
    }
}
@end
