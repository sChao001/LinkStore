//
//  LabelsLevelOneModel.m
//  Link
//
//  Created by Surdot on 2018/7/11.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "LabelsLevelOneModel.h"

@implementation LabelsLevelOneModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}
    
- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _Id = value;
    }else {
        [super setValue:value forKey:key];
    }
}

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    //@{属性名: 此数组中元素的解析类型}
    return @{@"liveList": [LabelsLevelOneDataModel class]};
}
@end

@implementation LabelsLevelOneDataModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _Id = value;
    }else {
        [super setValue:value forKey:key];
    }
}

@end
