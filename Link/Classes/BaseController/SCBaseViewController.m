//
//  SCBaseViewController.m
//  Link
//
//  Created by Surdot on 2018/4/18.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "SCBaseViewController.h"


@interface SCBaseViewController ()
/**提示语*/
@property (nonatomic,strong) UILabel * alertLabel;

@end

@implementation SCBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

//隐藏导航栏
- (void)setMyNavigationBarHidden
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //    self.navigationController.navigationBar.translucent = YES;//(导航栏半透明)。左边原点为（0,0）
    // 侧滑返回
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
}
//显示导航栏颜色
- (void)setMyNavigationBarOfBackground:(UIColor *)color {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    [self.navigationController.navigationBar setBackgroundColor:color];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17]};
    self.navigationController.navigationBar.barTintColor = color;
    //去掉黑线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

/**显示图片导航栏*/
- (void)setMyNavigationBarShowOfImage
{
    NSString *stringX = @"y_naviBarX";
    NSString *string = @"y_naviBar";
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"y_naviBar"]forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", LK_iPhoneX ? stringX : string]] forBarMetrics:UIBarMetricsDefault];
    //去掉黑线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:RGB(28, 28, 28),NSFontAttributeName:[UIFont boldSystemFontOfSize:17]};
    self.navigationController.navigationBar.translucent = YES;// //translucent 为NO时(导航栏不透明)。左边原点为（0,64） translucent 为YES时，左边原点为 （0，0）
    // 侧滑返回
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

//显示导航栏为纯透明
- (void)setMyNavigationBarClear
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]forBarMetrics:UIBarMetricsDefault];
    //去掉黑线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17]};
    self.navigationController.navigationBar.translucent = YES;//(导航栏透明)。
    // 侧滑返回
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}
/**
 * 设置左侧按钮
 */
-(void)setCommonLeftBarButtonItem{
    
    UIImage *tempImage = [UIImage imageNamed:@"y_back"];
    UIImage *selectedImage = [tempImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//防止系统渲染
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:selectedImage style:UIBarButtonItemStylePlain target:self action:@selector(leftBarItemBack)];
    
}
-(void)setLeftBarButtonWithNorImgName:(NSString *) norName{
    UIImage *tempImage = [UIImage imageNamed:norName];
    UIImage *selectedImage = [tempImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//防止系统渲染
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:selectedImage style:UIBarButtonItemStylePlain target:self action:@selector(leftBarItemBack)];
}

-(void)setLeftBarButtonWithTitle:(NSString *)title font:(CGFloat)font select:(SEL)select{
    UIBarButtonItem *Leftitem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:select];
    //防止系统渲染文字
    NSDictionary *dic = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:font]};
    
    [Leftitem setTitleTextAttributes:dic forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = Leftitem;
}

/**
 * 设置右侧按钮图片
 */
-(void)setRightBarButtonWithNorImgName:(NSString *)norName select:(SEL)select{
    
    UIImage *tempImage = [UIImage imageNamed:norName];
    UIImage *selectedImage = [tempImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//防止系统渲染
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:selectedImage style:UIBarButtonItemStylePlain target:self action:select];
}
/**
 * 设置右侧按钮只有文字
 */
-(void)setRightBarButtonWithTitle:(NSString *)title font:(CGFloat)font select:(SEL)select{
    
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:select];
    
    //防止系统渲染文字
    NSDictionary *dic = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:font]};
    
    [rightitem setTitleTextAttributes:dic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightitem;
    
}


/**
 * 返回按钮点击事件，子类可重写
 */
- (void)leftBarItemBack {
//    [SVProgressHUD dismiss];
//    if (self.showImgView) {
//        [self.showImgView removeFromSuperview];
//        self.showImgView = nil;
//    }

    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [self.navigationController popViewControllerAnimated:YES];
}

/**跳转到子界面*/
- (void)pushChildVC:(UIViewController *)vc animated:(BOOL)animated
{
    [self.navigationController pushViewController:vc animated:animated];
}

- (void)refreshViewsNumberReloadDate {
    
}
/**创建提示语*/
- (void)creatMyAlertlabel
{
    _alertLabel = [[UILabel alloc]initWithFrame:CGRectMake((ScreenW-180)/2, ScreenH/3+30, 180, 30)];
    _alertLabel.backgroundColor = RGBA(30, 30, 30, 0.4);
    _alertLabel.textColor = [UIColor whiteColor];
    _alertLabel.textAlignment = NSTextAlignmentCenter;
    _alertLabel.layer.cornerRadius = 4;
    _alertLabel.layer.masksToBounds = YES;
    _alertLabel.font = [UIFont systemFontOfSize:14];
    _alertLabel.hidden = YES;
    [self.view addSubview:_alertLabel];
    
}

//展示提示语
- (void)alertShowWithTitle:(NSString *)title
{
    _alertLabel.text = title;
    if ([CommentTool textLength:title]>10) {
        _alertLabel.mj_h = 65;
        _alertLabel.numberOfLines = 0;
    } else {
        _alertLabel.mj_h = 30;
        _alertLabel.numberOfLines = 1;
    }
    _alertLabel.hidden = NO;
    [self.view bringSubviewToFront:_alertLabel];
    
    float time = title.length*0.2;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.alertLabel.hidden = YES;
    });
}

@end
