//
//  KxMenu.h
//  Link
//
//  Created by Surdot on 2018/4/19.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface KxMenuItem : NSObject

@property(readwrite, nonatomic, strong) UIImage *image;
@property(readwrite, nonatomic, strong) NSString *title;
@property(readwrite, nonatomic, weak) id target;
@property(readwrite, nonatomic) SEL action;
@property(readwrite, nonatomic, strong) UIColor *foreColor;
@property(readwrite, nonatomic) NSTextAlignment alignment;

+ (instancetype)menuItem:(NSString *)title image:(UIImage *)image target:(id)target action:(SEL)action;

@end

@interface KxMenu : NSObject
+ (void)showMenuInView:(UIView *)view fromRect:(CGRect)rect menuItems:(NSArray *)menuItems;

+ (void)dismissMenu;

+ (UIColor *)tintColor;
+ (void)setTintColor:(UIColor *)tintColor;

+ (UIFont *)titleFont;
+ (void)setTitleFont:(UIFont *)titleFont;
@end
