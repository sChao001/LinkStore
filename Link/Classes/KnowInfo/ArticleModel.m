//
//  ArticleModel.m
//  Link
//
//  Created by Surdot on 2018/11/19.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "ArticleModel.h"

@implementation ArticleModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _iD = value;
    }else {
        [super setValue:value forKey:key];
    }
}
@end
