//
//  IMDataSource.m
//  Link
//
//  Created by Surdot on 2018/4/20.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "IMDataSource.h"

@implementation IMDataSource

static IMDataSource *_instance = nil;

+ (instancetype)sharedInstance {
    @synchronized(self){
        if (_instance == nil) {
            _instance = [self alloc];
        }
        return _instance;
    }
}
@end
