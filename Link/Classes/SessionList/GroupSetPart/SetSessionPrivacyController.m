//
//  SetSessionPrivacyController.m
//  Link
//
//  Created by Surdot on 2018/5/28.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "SetSessionPrivacyController.h"
#import "PasswordTextView.h"

@interface SetSessionPrivacyController ()
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UITextField *passwordText;
@property (nonatomic, strong) NSMutableArray *useridArray;
@property (nonatomic, strong) NSString *recordPasswordStr;
@end

@implementation SetSessionPrivacyController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@__%@", _groupSign, _useridStr);
    self.title = @"设置密码";
    self.view.backgroundColor = RGB(239, 239, 239);
    [self setCommonLeftBarButtonItem];

//    UIImage *image = [UIImage imageNamed:@"sureGroup"];
//    UIImage *selectImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:selectImage style:UIBarButtonItemStylePlain target:self action:@selector(sureClicked)];
//    self.navigationItem.rightBarButtonItem = rightItem;
    
    _titleLb = [[UILabel alloc] init];
    [self.view  addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kHeightScale(130));
        make.centerX.equalTo(0);
        make.width.greaterThanOrEqualTo(10);
    }];
    _titleLb.text = @"请设置对当前用户的密码";
    _titleLb.textColor = RGB(115, 214, 53);
    _titleLb.font = [UIFont systemFontOfSize:14];
    
    CGPoint center = self.view.center;
    PasswordTextView *view1 = [[PasswordTextView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    view1.elementCount = 5;
    view1.center = CGPointMake(center.x, kHeightScale(220));
    [self.view addSubview:view1];
    view1.passwordDidChangeBlock = ^(NSString *password) {
        if (password.length >= 5) {
            UIImage *image = [UIImage imageNamed:@"y_graySure"];
            UIImage *selectImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:selectImage style:UIBarButtonItemStylePlain target:self action:@selector(completionHandlered)];
        
            self.navigationItem.rightBarButtonItem = rightItem;
            
//            [UserDefault setObject:password forKey:@"privacyPassword"];
           
            NSLog(@"%@", password);
            self.recordPasswordStr = password;
            
            
        }
    };
}
/**
 * 设置左侧按钮
 */
//-(void)setCommonLeftBarButtonItem{
//    UIImage *tempImage = [UIImage imageNamed:@"back"];
//    UIImage *selectedImage = [tempImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//防止系统渲染
//
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:selectedImage style:UIBarButtonItemStylePlain target:self action:@selector(leftBarItemBack)];
//}
//
///**
// * 返回按钮点击事件，子类可重写
// */
//- (void)leftBarItemBack {
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
//    [self.navigationController popViewControllerAnimated:YES];
//}
- (void)sureClicked {
    
}
- (void)completionHandlered {
    NSLog(@"%@", _recordPasswordStr);
    if (![CommentTool isBlankString:self.groupSign]) {
        [UserDefault setObject:@"该群已设置密码" forKey:[NSString stringWithFormat:@"M%@_%@", self.groupSign, [UserInfo sharedInstance].getUserid]];
        [UserDefault setObject:_recordPasswordStr forKey:[NSString stringWithFormat:@"%@_%@", self.groupSign, [UserInfo sharedInstance].getUserid]];
    }else{
        [UserDefault setObject:@"已设置密码" forKey:[NSString stringWithFormat:@"setedPassword_%@_%@", self.useridStr, [UserInfo sharedInstance].getUserid]];
        [UserDefault setObject:_recordPasswordStr forKey:[NSString stringWithFormat:@"%@P_%@", self.useridStr, [UserInfo sharedInstance].getUserid]];
    }

    [UserDefault synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
