//
//  EditDetailInfoController.m
//  Link
//
//  Created by Surdot on 2018/5/30.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "EditDetailInfoController.h"

@interface EditDetailInfoController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *inputTextFeild;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) NSString *setString;
@property (nonatomic, strong) NSString *nickNameStr;
@property (nonatomic, strong) NSString *customSign;
@end

@implementation EditDetailInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(239, 239, 239);
//    UIImage *image = [UIImage imageNamed:@"sureGroup"];
//    UIImage *selectImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:selectImage style:UIBarButtonItemStylePlain target:self action:@selector(sureClicked)];
//    self.navigationItem.rightBarButtonItem = rightItem;
    [self setCommonLeftBarButtonItem];
    self.title = @"设置昵称";

    
    _inputTextFeild = [[UITextField alloc] initWithFrame:CGRectMake(10, LK_iPhoneXNavHeight + 10, ScreenW - 20, 40)];
    [self.view addSubview:_inputTextFeild];
    _inputTextFeild.placeholder = [NSString stringWithFormat:@"请输入%@", _myString];
//    [UserDefault setObject:_inputTextFeild.text forKey:[NSString stringWithFormat:@"LINK号%@", _inputTextFeild.text]];
    
    _inputTextFeild.delegate = self;

    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(10, LK_iPhoneXNavHeight + 50, ScreenW - 20, 1)];
    [self.view addSubview:_lineView];
    _lineView.backgroundColor = RGB(117, 214, 55);
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"%@", textField.text);
    
    if (![CommentTool isBlankString:_inputTextFeild.text] && [_myString isEqualToString:@"LINK号（只能设置一次）"]) {
        UIImage *image = [UIImage imageNamed:@"y_graySure"];
        UIImage *selectImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:selectImage style:UIBarButtonItemStylePlain target:self action:@selector(completionChoose)];
        self.navigationItem.rightBarButtonItem = rightItem;
//        [UserDefault setObject:_inputTextFeild.text forKey:@"pubLINK"];
        self.setString = textField.text;
        NSLog(@"%@", _setString);
    }
    if (![CommentTool isBlankString:_inputTextFeild.text] && [_myString isEqualToString:@"昵称"]) {
        UIImage *image = [UIImage imageNamed:@"y_graySure"];
        UIImage *selectImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:selectImage style:UIBarButtonItemStylePlain target:self action:@selector(completionChoose)];
        self.navigationItem.rightBarButtonItem = rightItem;
        self.nickNameStr = textField.text;
    }
    if (![CommentTool isBlankString:_inputTextFeild.text] && [_myString isEqualToString:@"签名"]) {
        UIImage *image = [UIImage imageNamed:@"y_graySure"];
        UIImage *selectImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:selectImage style:UIBarButtonItemStylePlain target:self action:@selector(completionChoose)];
        self.navigationItem.rightBarButtonItem = rightItem;
        self.customSign = textField.text;
    }
}
- (void)sureClicked {
    [self.view endEditing:YES];
}
- (void)completionChoose {
    if (![CommentTool isBlankString:self.setString]) {
        if (_delegate && [_delegate respondsToSelector:@selector(showText:)]) {
            [_delegate showText:self.setString];
        }
    }
    if (![CommentTool isBlankString:self.nickNameStr]) {
        if (_delegate && [_delegate respondsToSelector:@selector(showNickName:)]) {
            [_delegate showNickName:self.nickNameStr];
        }
    }
    if (![CommentTool isBlankString:self.customSign]) {
        if (_delegate && [_delegate respondsToSelector:@selector(showCustomSign:)]) {
            [_delegate showCustomSign:self.customSign];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}
//- (void)backInfo:(void(^)(NSString *))something {
//
//}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
