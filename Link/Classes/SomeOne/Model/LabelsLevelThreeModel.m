//
//  LabelsLevelThreeModel.m
//  Link
//
//  Created by Surdot on 2018/7/12.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "LabelsLevelThreeModel.h"

@implementation LabelsLevelThreeModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _Id = value;
    }else {
        [super setValue:value forKey:key];
    }
}
@end
