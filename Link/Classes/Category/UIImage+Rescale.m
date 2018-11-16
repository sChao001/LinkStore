//
//  UIImage+Rescale.m
//  Link
//
//  Created by Surdot on 2018/7/31.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "UIImage+Rescale.h"

@implementation UIImage (Rescale)
- (UIImage *)rescaleImageToSize:(CGSize)size {
    
    CGRect rect = CGRectMake(0.0, 0.0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    [self drawInRect:rect];  // scales image to rect
    
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resImage;
    
}
@end
