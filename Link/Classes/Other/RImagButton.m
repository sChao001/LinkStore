//
//  RImagButton.m
//  Link
//
//  Created by Surdot on 2018/5/16.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "RImagButton.h"

@implementation RImagButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = _imageRect.origin.x;
    CGFloat imageY = _imageRect.origin.y;
    CGFloat imageW = CGRectGetWidth(_imageRect);
    CGFloat imageH = CGRectGetHeight(_imageRect);
    return CGRectMake(imageX, imageY, imageW, imageH);
}

//自定义按钮的文字在左边
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = _titleRect.origin.x;
    CGFloat titleY = _titleRect.origin.y;
    
    CGFloat titleW = CGRectGetWidth(_titleRect);
    
    CGFloat titleH = CGRectGetHeight(_titleRect);
    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end
