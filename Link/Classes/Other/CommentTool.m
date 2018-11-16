//
//  CommentTool.m
//  Link
//
//  Created by Surdot on 2018/5/8.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "CommentTool.h"

@implementation CommentTool
static CommentTool * shareInstance = nil;

+(CommentTool *) Instance {
    @synchronized(self)
    {
        if(nil == shareInstance) {
            [self new];
        }
    }
    return shareInstance;
}

+(id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if(shareInstance == nil)
        {
            shareInstance = [super allocWithZone:zone];
            return shareInstance;
        }
    }
    return nil;
}

//测量文字长度，汉字是一个，英文是半个
+(NSUInteger)textLength:(NSString *)text {
    
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    
    NSUInteger unicodeLength = asciiLength;
    return unicodeLength/2;
}
+ (BOOL)isBlankString:(NSString *)string {
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isKindOfClass:[NSString class]] && [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    
    return NO;
}
//改变图像尺寸,方便上传服务器
+ (UIImage *)scallImage:(UIImage *)image toSize:(CGSize )size{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
/**时间戳转换为日和时间*/
+ (NSString *)dayWithTimeIntervalOfHours:(NSInteger)timeInterval
{
    NSString * timeString = [NSString stringWithFormat:@"%ld",timeInterval];
    if ([timeString isEqualToString:@"<null>"]) {
        return @"时间格式有误";
    }
    if ([CommentTool isBlankString:timeString]) {
        return @"时间格式有误";
    }
    NSDate *date  = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd  HH:mm:ss"]; // yyyy-MM-dd HH:mm:ss
    NSString *dateString  = [formatter stringFromDate: date];
    
    return dateString;
}
@end
