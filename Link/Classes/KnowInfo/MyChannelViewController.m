//
//  MyChannelViewController.m
//  Link
//
//  Created by Surdot on 2018/6/22.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "MyChannelViewController.h"
#import "ChannelView.h"

@interface MyChannelViewController () <ChannelViewDelegate>
@property (nonatomic, strong) ChannelView *channelView;
@property (nonatomic, strong) NSMutableArray *allSignDataArray;
@property (nonatomic, strong) NSString *parametStr;
@end

@implementation MyChannelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSundry];
    [self setCommonLeftBarButtonItem];
    self.title = @"编辑频道";
    self.view.backgroundColor = [UIColor whiteColor];
    self.channelView = [[ChannelView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, ScreenH - LK_TabbarSafeBottomMargin)];
    self.channelView.backgroundColor = [UIColor whiteColor];
    self.channelView.delegate = self;
    //添加数据
    self.channelView.upBtnDataArr = _signArray;
    self.channelView.belowBtnDataArr = _belowArray;
    //每行按钮个数
//    self.channelView.btnNumber = 5;
    //允许第一个按钮参与编辑
    self.channelView.IS_compileFirstBtn = NO;
    //设置按钮字体Font
    self.channelView.btnTextFont = 13.0f;
    //获取数据Block
    _parametStr = @"";
    __block typeof(self)weakSelf = self;
    self.channelView.dataBlock = ^(NSMutableArray *dataArr) {
//        for (NSString *upBtnText in dataArr) {
//            NSLog(@"dataBlock_upBtnText:%@",upBtnText);
//        }
        for (int i = 0; i<dataArr.count; i++) {
            NSLog(@"%@", dataArr[i]);
            NSString *sign = [NSString stringWithFormat:@"%@,", dataArr[i]];
            weakSelf.parametStr = [weakSelf.parametStr stringByAppendingString:sign];
        }
        NSLog(@"%@", weakSelf.parametStr);
    };
    [self.view addSubview:self.channelView];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)setSundry {
    self.allSignDataArray = [NSMutableArray arrayWithCapacity:0];
}

- (void)completionBtnClicked:(UIButton *)sender {
    NSLog(@"pop出去");
//    [self.navigationController popViewControllerAnimated:YES];
    [self requestSignArrayData];
}

- (void)requestSignArrayData {
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"labelNames" : _parametStr};
    [SCNetwork postWithURLString:BDUrl_s(@"label/setLabel") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"%@", dic[@"result"]);
            [self.navigationController popViewControllerAnimated:YES];
//            if (self.delegate && [self.delegate respondsToSelector:@selector(sendMessage:)]) {
//                [self.delegate sendMessage:@"1"];
//            }
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"网络连接失败，检查网络"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
