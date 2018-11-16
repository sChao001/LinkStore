//
//  FrendListModel.m
//  Link
//
//  Created by Surdot on 2018/5/18.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "FrendListModel.h"

@implementation FrendListModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

/**此方法属于YYModel协议方法，需要让 model 遵从<YYModel>协议 才会有代码提示*/
//+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
//    //@{@"属性名": @"key"}
//    return @{@"iD": @"id"};
//}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _iD = value;
    }else {
        [super setValue:value forKey:key];
    }
}

@end
