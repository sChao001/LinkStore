//
//  UIImage+SCImage.h
//  Link
//
//  Created by Surdot on 2018/4/19.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SCImage)
/**
 *  修改图片size
 *
 *  @param image      原图片
 *  @param targetSize 要修改的size
 *
 *  @return 修改后的图片
 */
+ (UIImage *)image:(UIImage *)image byScalingToSize:(CGSize)targetSize;
@end
