//
//  HomeLabelsModel.m
//  Link
//
//  Created by Surdot on 2018/7/13.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "HomeLabelsModel.h"

@implementation HomeLabelsModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _Id = value;
    }else {
        [super setValue:value forKey:key];
    }
}
@end
