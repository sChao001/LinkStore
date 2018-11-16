//
//  LKLittleSessionViewController.m
//  Link
//
//  Created by Surdot on 2018/5/24.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "LKLittleSessionViewController.h"

@interface LKLittleSessionViewController ()

@end

@implementation LKLittleSessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor redColor];
    self.conversationMessageCollectionView.backgroundColor = [UIColor redColor];
//    self.conversationMessageCollectionView.frame = CGRectMake(60, 200, ScreenW - 80, 300);
//    self.view.frame = CGRectMake(60, 200, ScreenW - 80, 300);
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
