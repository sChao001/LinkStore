//
//  QRImmageViewController.m
//  Link
//
//  Created by Surdot on 2018/4/27.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "QRImmageViewController.h"
#import <CoreImage/CoreImage.h>

@interface QRImmageViewController ()
@property (nonatomic, strong) UIImageView *QRImageView;
@end

@implementation QRImmageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.QRImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, ScreenW - 20, ScreenH - 50)];
    [self.view addSubview:_QRImageView];
//    self.QRImageView.backgroundColor = [UIColor whiteColor];
    [self makeQRCode];
}

//生成二维码
- (void)makeQRCode {
    //创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQCodeGenerator"];
    //恢复默认
    [filter setDefaults];
    //给过滤器添加数据
    NSString *dataString = @"我是谁";
    NSData *data = [dataString dataUsingEncoding:NSUnicodeStringEncoding];
    NSLog(@"%@", data);
    //通过KVO设置滤镜inputMessage
    [filter setValue:data forKeyPath:@"inputMessage"];
        NSLog(@"%@", filter);
    //获取二维码输出
    CIImage *outputImage = [filter outputImage];
    //将CIImage转换成UIImage，并放大显示
    self.QRImageView.image = [UIImage imageWithCIImage:outputImage];
    NSLog(@"%@", outputImage);
}

@end
