//
//  KnowHomeViewController.m
//  Link
//
//  Created by Surdot on 2018/6/14.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "KnowHomeViewController.h"

@interface KnowHomeViewController ()

@end

@implementation KnowHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestMessageOfSignData];
}

- (instancetype)initWithMsgType:(NSInteger)msgType {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)requestMessageOfSignData {
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid};
    [SCNetwork postWithURLString:BDUrl_s(@"label/getLabelList") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"dic:%@",dic);
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
        [SVProgressHUD dismiss];
    }];
}
















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
