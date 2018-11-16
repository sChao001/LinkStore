//
//  ReceiveMoneyModel.m
//  Link
//
//  Created by Surdot on 2018/8/27.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "ReceiveMoneyModel.h"

@implementation ReceiveMoneyModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _Id = value;
    }else {
        [super setValue:value forKey:key];
    }
}
@end



