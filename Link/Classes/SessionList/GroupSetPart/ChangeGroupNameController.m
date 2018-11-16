//
//  ChangeGroupNameController.m
//  Link
//
//  Created by Surdot on 2018/5/24.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "ChangeGroupNameController.h"

@interface ChangeGroupNameController () <UITextFieldDelegate>
@property (nonatomic, strong) UILabel *groupName;
@property (nonatomic, strong) UITextField *enterTextField;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation ChangeGroupNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(245, 245, 245);
    [self setMyView];
    [self creatMyAlertlabel];
    [self setCommonLeftBarButtonItem];
}

- (void)setMyView {
    _groupName = [[UILabel alloc] initWithFrame:CGRectMake(15, 14, 50, 20)];
//    _groupName.backgroundColor = [UIColor redColor];
    [self.view addSubview:_groupName];
    _groupName.text = @"群聊名称";
    _groupName.textColor = RGB(113, 112, 113);
    _groupName.font = [UIFont systemFontOfSize:kWidthScale(12)];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 74, ScreenW - 20, 1)];
    [self.view addSubview:_lineView];
    _lineView.backgroundColor = RGB(112, 240, 59);
    
    _enterTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 44, ScreenW - 30, 30)];
    [self.view addSubview:_enterTextField];
//    _enterTextField.backgroundColor = [UIColor orangeColor];
    _enterTextField.font = [UIFont systemFontOfSize:15];
    // 设置placeholder的字体颜色和大小
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"修改群聊名称" attributes:
                                      @{NSForegroundColorAttributeName:RGBA(113, 112, 113, 0.6),
                                        NSFontAttributeName:_enterTextField.font
                                        }];
    _enterTextField.attributedPlaceholder = attrString;
    _enterTextField.delegate = self;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (![CommentTool isBlankString:textField.text]) {
        UIImage *image = [UIImage imageNamed:@"y_graySure"];
        UIImage *selectImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:selectImage style:UIBarButtonItemStylePlain target:self action:@selector(completionSet)];
        self.navigationItem.rightBarButtonItem = rightItem;
        //        [UserDefault setObject:_inputTextFeild.text forKey:@"pubLINK"];
//        self.setString = textField.text;
//        NSLog(@"%@", _setString);
    }
}
- (void)completionSet {
    NSLog(@"%@", _enterTextField.text);
    NSString *jmString = [NSString stringWithFormat:@"%@%@%@", BD_key, BD_secret, [UserInfo sharedInstance].getjmToken];
    NSDictionary *paramet = @{@"userId" : [UserInfo sharedInstance].getUserid, @"groupId" : _groupIdStr, @"groupName" : _enterTextField.text, @"sign" : jmString.md5String};
    [SCNetwork postWithURLString:BDUrl_s(@"group/modify") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"dic:%@", dic);
            [self alertShowWithTitle:@"修改成功"];

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else {
            [self alertShowWithTitle:dic[@"result"]];
        }

    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接是失败"];
        [SVProgressHUD dismissWithDelay:0.7];

    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (![CommentTool isBlankString:_enterTextField.text]) {
        UIImage *image = [UIImage imageNamed:@"y_graySure"];
        UIImage *selectImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:selectImage style:UIBarButtonItemStylePlain target:self action:@selector(completionSet)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
