//
//  SCTagView.h
//  Link
//
//  Created by Surdot on 2018/7/5.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCTagView : UIView
/**
 *  初始化
 */
- (instancetype)initWithFrame:(CGRect)frame;

// 标签数组
@property (nonatomic,retain) NSArray* tagArray;

// 选中标签文字颜色
@property (nonatomic,retain) UIColor* textColorSelected;
// 默认标签文字颜色
@property (nonatomic,retain) UIColor* textColorNormal;

// 选中标签背景颜色
@property (nonatomic,retain) UIColor* backgroundColorSelected;
// 默认标签背景颜色
@property (nonatomic,retain) UIColor* backgroundColorNormal;
// 标签的所在view的总高度
@property (nonatomic, assign) int totalHeight;
@end
