//
//  YGRefreshHeader.m
//  Gxj
//
//  Created by 马永刚 on 2017/11/8.
//  Copyright © 2017年 马永刚. All rights reserved.
//

#import "YGRefreshHeader.h"

@interface YGRefreshHeader ()

@property (nonatomic, strong) NSMutableArray *refreshingArr;
@property (nonatomic, strong) NSMutableArray *idleArr;
@end

@implementation YGRefreshHeader

- (NSMutableArray *)refreshingArr {
    if (!_refreshingArr) {
        _refreshingArr = [NSMutableArray array];
    }
    return _refreshingArr;
}
- (NSMutableArray *)idleArr {
    if (!_idleArr) {
        _idleArr = [NSMutableArray array];
    }
    return _idleArr;
}

- (instancetype)init {
    
    if (self = [super init]) {
        self.lastUpdatedTimeLabel.hidden = YES;
        self.stateLabel.hidden = YES;
        for (int i = 0; i < 8; i++) {
            [self.refreshingArr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loding%d", i]]];
        }
        [self setImages:_refreshingArr  duration:1.6f forState:MJRefreshStateIdle];
        
        
        for (int i = 0; i < 8; i++) {
            [self.idleArr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loding%d",i]]];
        }
        [self setImages:_idleArr  duration:1.6f forState:MJRefreshStatePulling];
                
    }
    return self;
}
@end

