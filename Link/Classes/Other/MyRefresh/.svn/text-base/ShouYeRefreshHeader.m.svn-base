//
//  ShouYeRefreshHeader.m
//  直播FHE
//
//  Created by 付洪恩 on 17/3/1.
//  Copyright © 2017年 FHE. All rights reserved.
//

#import "ShouYeRefreshHeader.h"

@interface ShouYeRefreshHeader ()
@property (nonatomic, strong) NSMutableArray *refreshingArr;
@property (nonatomic, strong) NSMutableArray *idleArr;
@end

@implementation ShouYeRefreshHeader
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
        [self setImages:_refreshingArr  duration:1.6 forState:MJRefreshStateIdle];
        
        
        for (int i = 0; i < 8; i++) {
            [self.idleArr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loding%d", i]]];
        }
        [self setImages:_idleArr  duration:1.6 forState:MJRefreshStatePulling];
        

    }
    return self;
}
@end
