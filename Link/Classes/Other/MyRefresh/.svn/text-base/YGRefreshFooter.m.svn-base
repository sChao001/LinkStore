//
//  YGRefreshFooter.m
//  Gxj
//
//  Created by 马永刚 on 2017/11/8.
//  Copyright © 2017年 马永刚. All rights reserved.
//

#import "YGRefreshFooter.h"

@implementation YGRefreshFooter

#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    
    self.refreshingTitleHidden = YES;
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (int i = 0; i < 8; i++) {
        [refreshingImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loding%d", i]]];
    }
    [self setImages:refreshingImages  duration:1 forState:MJRefreshStateRefreshing];
    

}

@end
