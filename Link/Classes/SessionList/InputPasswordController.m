//
//  InputPasswordController.m
//  Link
//
//  Created by Surdot on 2018/5/28.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "InputPasswordController.h"
#import "PasswordTextView.h"

@interface InputPasswordController ()
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UITextField *passwordText;

@end

@implementation InputPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(239, 239, 239);
    NSLog(@"%@", _targetId);
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
    _titleLb.text = @"请输入当前用户的隐私密码";
    _titleLb.textColor = RGB(115, 214, 53);
    _titleLb.font = [UIFont systemFontOfSize:14];
    
    CGPoint center = self.view.center;
    PasswordTextView *view1 = [[PasswordTextView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    view1.elementCount = 5;
    view1.center = CGPointMake(center.x, kHeightScale(220));
    [self.view addSubview:view1];
    view1.passwordDidChangeBlock = ^(NSString *password) {
        if (password.length >= 5) {
//            UIImage *image = [UIImage imageNamed:@"eye"];
//            UIImage *selectImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//            UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:selectImage style:UIBarButtonItemStylePlain target:self action:@selector(completionHandlered)];
//            self.navigationItem.rightBarButtonItem = rightItem;
            NSLog(@"%@", password);

            
//            if ([password isEqualToString:[UserDefault objectForKey:@"privacyPassword"]]) {
//                self.view.hidden = YES;
//            }else {
//                self.view.hidden = NO;
//            }
            
//            if ([password isEqualToString:[UserDefault objectForKey:[NSString stringWithFormat:@"%@P_%@", self.targetId, [UserInfo sharedInstance].getUserid]]]) {
//                self.view.hidden = YES;
//            }else if ([password isEqualToString:[UserDefault objectForKey:[NSString stringWithFormat:@"group:%@_%@", self.targetId, [UserInfo sharedInstance].getUserid]]]) {
//                self.view.hidden = YES;
//            }else {
//                self.view.hidden = NO;
//            }
            self.view.hidden = NO;
            if ([password isEqualToString:[UserDefault objectForKey:[NSString stringWithFormat:@"%@P_%@", self.targetId, [UserInfo sharedInstance].getUserid]]]) {
                self.view.hidden = YES;
            }
            if ([password isEqualToString:[UserDefault objectForKey:[NSString stringWithFormat:@"group:%@_%@", self.targetId, [UserInfo sharedInstance].getUserid]]]) {
                self.view.hidden = YES;
            }
        }
    };
}
- (void)sureClicked {
    
}
- (void)completionHandlered {

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
