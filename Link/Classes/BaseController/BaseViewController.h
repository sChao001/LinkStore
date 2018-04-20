//
//  BaseViewController.h
//  Link
//
//  Created by Surdot on 2018/4/18.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>

@interface BaseViewController : RCConversationListViewController
{
    NSNumber * pagecount;//总页数
}

//设置导航栏左/右按钮样式
-(void)setCommonLeftBarButtonItem;
-(void)setLeftBarButtonWithNorImgName:(NSString *) norName;
-(void)setLeftBarButtonWithTitle:(NSString *)title font:(CGFloat)font select:(SEL)select;


-(void)setRightBarButtonWithNorImgName:(NSString *)norName select:(SEL)select;
-(void)setRightBarButtonWithTitle:(NSString *)title font:(CGFloat)font select:(SEL)select;

/**
 * 返回按钮点击事件，子类可重写
 */
//- (void)leftBarItemBack;


/**设置导航栏隐藏*/
- (void)setMyNavigationBarHidden;
/**设置导航栏背景颜色*/
- (void)setMyNavigationBarOfBackground:(UIColor *)color;
/**设置图片导航栏*/
- (void)setMyNavigationBarShowOfImage;
/**显示导航栏为纯透明*/
- (void)setMyNavigationBarClear;

/**跳转到子界面*/
- (void)pushChildVC:(UIViewController *)vc animated:(BOOL)animated;
@end
