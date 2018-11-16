//
//  CommentTool.h
//  Link
//
//  Created by Surdot on 2018/5/8.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentTool : NSObject
+ (CommentTool *) Instance;

/**输入了多少“字节”长度*/
+(NSUInteger)textLength:(NSString *)text;
//检测是不是空白字符串,是返回YES，非空返回NO
+(BOOL)isBlankString:(NSString *)string;
/**改变图像尺寸,方便上传服务器*/
+ (UIImage *)scallImage:(UIImage *)image toSize:(CGSize )size;
/**时间戳转换为日和时间*/
+ (NSString *)dayWithTimeIntervalOfHours:(NSInteger)timeInterval;

@end
