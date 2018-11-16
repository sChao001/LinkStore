//
//  LKTabBarController.h
//  Link
//
//  Created by Surdot on 2018/4/18.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LKTabBarController : UITabBarController
//纪录上次的item
@property (nonatomic,strong) UITabBarItem *lastItem;
//是否要跳页的状态，默认值给NO
@property (nonatomic,assign) CGFloat itemState;

/**设置tabBar的title颜色*/
- (void)setSelectedTitleColor:(UIColor *)color;

@end
