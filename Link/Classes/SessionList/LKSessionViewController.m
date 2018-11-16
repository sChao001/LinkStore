//
//  LKSessionViewController.m
//  Link
//
//  Created by Surdot on 2018/4/19.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "LKSessionViewController.h"
#import <Accelerate/Accelerate.h>
#import "LKMessageListController.h"
#import "LKGroupSetViewController.h"
#import "TopCollectionController.h"
#import "TopViewController.h"
#import "LKGroupMakeViewController.h"
#import "LKPersonalSetViewController.h"
#import "LCNetworking.h"
#import "InputPasswordController.h"
#import "PersonIntroViewController.h"
#import "SessionIconTapViewController.h"
#import "mmmmmViewController.h"
#import "LKTabBarController.h"


@interface LKSessionViewController ()
@property (nonatomic, strong) RCUserInfo *currentUserInfo;
//@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *messageArray;
@property (nonatomic, strong) NSString *messageStr;
@property (nonatomic) BOOL isTrue;
@property (nonatomic, strong) UITextView *inputTextView;
@property (nonatomic) NSInteger count;
@property (nonatomic, strong) NSString *myString;
@property (nonatomic, strong) InputPasswordController *inputVC;

@end

@implementation LKSessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self inputPasswordView];
    [self setCommonLeftBarButtonItem];

    _count = 1;

    self.messageArray = [NSMutableArray arrayWithCapacity:0];
    self.conversationMessageCollectionView.bounces = NO;

    
    // 获取Documents目录路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSLog(@"%@", docDir);

    
    UIImage *image = [UIImage imageNamed:@"y_funcS"];
    UIImage *selectImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    if (self.conversationType == ConversationType_PRIVATE) {
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:selectImage style:UIBarButtonItemStylePlain target:self action:@selector(sureClicked)];
        
        self.navigationItem.rightBarButtonItem = rightItem;
    }else if (self.conversationType == ConversationType_GROUP) {
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:selectImage style:UIBarButtonItemStylePlain target:self action:@selector(toGroupIntroClicked)];
        
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    

    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //关闭键盘工具条
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    // 读取沙盒路径图片
    self.conversationMessageCollectionView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = RGB(245, 245, 245);
    if (![CommentTool isBlankString:[UserDefault objectForKey:[NSString stringWithFormat:@"POfBackgrounds%@_%@", self.targetId, [UserInfo sharedInstance].getUserid]]]) {
        NSString *quString = [NSString stringWithFormat:@"PBG%@_%@.png", self.targetId, [UserInfo sharedInstance].getUserid];
        NSString *aPath3 = [NSString stringWithFormat:@"%@/Documents/%@.png",NSHomeDirectory(), quString];
        if (![CommentTool isBlankString:aPath3]) {
            self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:aPath3]];
        }
    }
    if (![CommentTool isBlankString:[UserDefault objectForKey:[NSString stringWithFormat:@"GOfBackgrounds%@_%@", self.targetId, [UserInfo sharedInstance].getUserid]]]) {
        NSString *quString = [NSString stringWithFormat:@"GBG%@_%@.png", self.targetId, [UserInfo sharedInstance].getUserid];
        NSString *aPath3 = [NSString stringWithFormat:@"%@/Documents/%@.png",NSHomeDirectory(), quString];
        if (![CommentTool isBlankString:aPath3]) {
            self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:aPath3]];
        }
    }
//    NSString *aPath3=[NSString stringWithFormat:@"%@/Documents/%@.png",NSHomeDirectory(),@"headImage"];
//    if (![CommentTool isBlankString:aPath3]) {
//        self.conversationMessageCollectionView.backgroundColor = [UIColor clearColor];
//        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:aPath3]];
//    }else {
//        self.view.backgroundColor = [UIColor whiteColor];
//    }
    
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[self blurryImage:[UIImage imageWithContentsOfFile:aPath3] withBlurLevel:0.1]];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}

/**
 * 设置左侧按钮
 */
-(void)setCommonLeftBarButtonItem{
    UIImage *tempImage = [UIImage imageNamed:@"y_back"];
    UIImage *selectedImage = [tempImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//防止系统渲染
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:selectedImage style:UIBarButtonItemStylePlain target:self action:@selector(leftBarItemBack)];
}

/**
 * 返回按钮点击事件，子类可重写
 */
- (void)leftBarItemBack {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [self.navigationController popViewControllerAnimated:YES];
    
    
////    LKTabBarController *tabbar = [[LKTabBarController alloc] init];
////    [UIApplication sharedApplication].keyWindow.rootViewController = tabbar;
//
////    UIViewController *vc = self.navigationController.viewControllers[2];
////    [self.navigationController popToViewController:tabbar animated:YES];
//
//    for (UIViewController *controller in self.navigationController.viewControllers) {
//        if ([controller isKindOfClass:[mmmmmViewController class]]) {
//            mmmmmViewController *vc = (mmmmmViewController *)controller;
//            [self.navigationController popToViewController:vc animated:YES];
//        }
//    }
}


- (void)inputPasswordView {
 
    NSLog(@"%@", [UserDefault objectForKey:[NSString stringWithFormat:@"group:%@_%@",self.targetId, [UserInfo sharedInstance].getUserid]]);
    _inputVC = [[InputPasswordController alloc] init];
    _inputVC.targetId = self.targetId;
    [self.view addSubview:_inputVC.view];
    _inputVC.view.hidden = YES;
    if (![CommentTool isBlankString:[UserDefault objectForKey:[NSString stringWithFormat:@"%@P_%@", self.targetId, [UserInfo sharedInstance].getUserid]]]) {
        _inputVC.view.hidden = NO;
    }
    if (![CommentTool isBlankString:[UserDefault objectForKey:[NSString stringWithFormat:@"group:%@_%@",self.targetId, [UserInfo sharedInstance].getUserid]]]) {
        _inputVC.view.hidden = NO;
    }
    
    [self addChildViewController:_inputVC];

}
- (void)requestBaiBuTranslationSign:(NSString *)stringSign transContent:(NSString *)content backInfo:(void(^)(NSString *content))backInfo{
    NSLog(@"%@", [UserDefault objectForKey:@"likeZH"]);
    NSString *toString = @"";
    if ([CommentTool isBlankString:[UserDefault objectForKey:@"likeZH"]]) {
        toString = @"bfy";
    }else {
        toString = [UserDefault objectForKey:@"likeZH"];
    }
        NSDictionary *paramet = @{@"q" : content, @"from" : @"zh", @"to" : toString, @"appid" : @"20170219000039382", @"salt" : @"1435660288", @"sign" : stringSign};
        [LCNetworking PostWithURL:@"https://fanyi-api.baidu.com/api/trans/vip/translate" Params:paramet success:^(id responseObject) {
            NSLog(@"%@", responseObject);
            NSArray *transArr = responseObject[@"trans_result"];
            backInfo(transArr[0][@"dst"]);
        } failure:^(NSString *error) {
            [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
            [SVProgressHUD dismissWithDelay:0.7];
        }];
    
}

- (void)sureClicked {
    NSLog(@"个人聊天设置");
    LKPersonalSetViewController *VC = [[LKPersonalSetViewController alloc] init];
    VC.useridStr = self.targetId;
    [self.navigationController pushViewController:VC animated:YES];
    
}
- (void)toGroupIntroClicked {
    NSLog(@"群组聊天设置");
    LKGroupMakeViewController *vc = [[LKGroupMakeViewController alloc] init];
    vc.groupIdStr = self.targetId;

    [self.navigationController pushViewController:vc animated:YES];
}


- (void)inputTextView:(UITextView *)inputTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSLog(@"text:%@", text);

    NSLog(@"111%@", inputTextView.text);
    NSLog(@"range:%lu", (unsigned long)range.length);
    NSLog(@"location:%lu", (unsigned long)range.location);
    
    self.inputTextView = inputTextView;
    
    if ([CommentTool isBlankString:text]) {
        NSLog(@"哈%@", inputTextView.text);
    }
}

//准备发送消息的回调
- (RCMessageContent *)willSendMessage:(RCMessageContent *)messageContent {
    
    if ([[UserDefault objectForKey:@"likeZH"] isEqualToString:@"bfy"]||[CommentTool isBlankString:[UserDefault objectForKey:@"likeZH"]]) {
        return messageContent;
    }
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t  sema = dispatch_semaphore_create(0);
    if ([messageContent isMemberOfClass:[RCTextMessage class]]) {
        
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            RCTextMessage *txtMsg = (RCTextMessage *)messageContent;
            NSString *string = [NSString stringWithFormat:@"20170219000039382%@1435660288Q3k9TWWRnJY2RfarU4Cc", txtMsg.content];
            
            [self requestBaiBuTranslationSign:string.md5String transContent:txtMsg.content backInfo:^(NSString *content) {
                dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    dispatch_semaphore_signal(sema);
                });
                NSLog(@"content:%@", content);
                txtMsg.content = [NSString stringWithFormat:@"%@\n%@", txtMsg.content, content];
            }];
        });
        
        
    }else {
        return messageContent;
    }
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    return messageContent;
}
- (void)didTapCellPortrait:(NSString *)userId {
    NSLog(@"%@", userId);
//    PersonIntroViewController *vc = [[PersonIntroViewController alloc] init];
    SessionIconTapViewController *vc = [[SessionIconTapViewController alloc] init];
    vc.targetId = userId;
    [self.navigationController pushViewController:vc animated:YES];
}


- (UIImage *)blurryImage:(UIImage *)image withMaskImage:(UIImage *)maskImage blurLevel:(CGFloat)blur {
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"CIMaskedVariableBlur"];
    // 指定过滤照片
    [filter setValue:ciImage forKey:kCIInputImageKey];
    CIImage *mask = [CIImage imageWithCGImage:maskImage.CGImage];
    // 指定 mask image
    [filter setValue:mask forKey:@"inputMask"];
    // 指定模糊值  默认为10, 范围为0-100
    [filter setValue:[NSNumber numberWithFloat:blur] forKey: @"inputRadius"];
    // 生成图片
    CIContext *context = [CIContext contextWithOptions:nil];
    // 创建输出
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage = [context createCGImage: result fromRect:CGRectMake(0, 0, 320.0 * 2, 334.0 * 2)]; UIImage * blurImage = [UIImage imageWithCGImage:outImage];
    return blurImage;
    
}

// 添加通用模糊效果 // image是图片，blur是模糊度
- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    if (image==nil) {
        NSLog(@"error:为图片添加模糊效果时，未能获取原始图片"); return nil;
    }
    //模糊度,
    if (blur < 0.025f) {
        blur = 0.025f;
        
    } else if (blur > 1.0f) {
        blur = 1.0f;
        
    }
    //boxSize必须大于0
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    NSLog(@"boxSize:%i",boxSize);
    //图像处理
    CGImageRef img = image.CGImage;
    //需要引入#import <Accelerate/Accelerate.h>
    //图像缓存,输入缓存，输出缓存
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    //像素缓存
    void *pixelBuffer;
    //数据源提供者，Defines an opaque type that supplies Quartz with data.
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    // provider’s data.
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    //宽，高，字节/行，data
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    //像数缓存，字节行*图片高
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    // 第三个中间的缓存区,抗锯齿的效果
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    //Convolves a region of interest within an ARGB8888 source image by an implicit M x N kernel that has the effect of a box filter.
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) { NSLog(@"error from convolution %ld", error);
        
    }
    // NSLog(@"字节组成部分：%zu",CGImageGetBitsPerComponent(img));
    //颜色空间DeviceRGB
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //用图片创建上下文,CGImageGetBitsPerComponent(img),7,8
    CGContextRef ctx = CGBitmapContextCreate( outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));
    //根据上下文，处理过的图片，重新组件
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    //CGColorSpaceRelease(colorSpace); //多余的释放
    CGImageRelease(imageRef);
    return returnImage;
    
}


@end
