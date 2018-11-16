//
//  ReportInfoViewController.m
//  Link
//
//  Created by Surdot on 2018/8/24.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "ReportInfoViewController.h"
#import "ReportInfoCell.h"

@interface ReportInfoViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableviewList;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSIndexPath *selectIndex;
@end

@implementation ReportInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(239, 239, 239);
    [self setCommonLeftBarButtonItem];
    self.title = @"举报内容";
    [self configTableViewlayout];
    
    _dataArray = @[@"低俗色情或暴力", @"内容不实", @"涉嫌违法犯罪", @"政治言论", @"内容垃圾", @"其它"];
    [self configTableViewlayout];
    [self creatMyAlertlabel];
}

- (void)configTableViewlayout {
    _tableviewList = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-LK_iPhoneXNavHeight-LK_TabbarSafeBottomMargin) style:UITableViewStylePlain];
    [self.view addSubview:_tableviewList];
    _tableviewList.delegate = self;
    _tableviewList.dataSource = self;
    [_tableviewList registerClass:[ReportInfoCell class] forCellReuseIdentifier:@"cellList"];
    _tableviewList.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableviewList.bounces = NO;
    _tableviewList.backgroundColor = RGB(239, 239, 239);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 100)];
    view.backgroundColor = [UIColor clearColor];
    _tableviewList.tableFooterView = view;
    _sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, ScreenW-100, 40)];
    [view addSubview:_sureBtn];
    _sureBtn.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.5];
    [_sureBtn setTitle:@"提交" forState:UIControlStateNormal];
}
- (void)sureBtnClicked {
    [self alertShowWithTitle:@"举报成功,正在审查"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReportInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellList" forIndexPath:indexPath];
    cell.titleLb.text = _dataArray[indexPath.row];
    if (self.selectIndex == indexPath) {
        cell.leftImg.selected = !cell.leftImg.selected;
        if (cell.leftImg.selected == YES) {
            _sureBtn.backgroundColor = [UIColor orangeColor];
            [_sureBtn addTarget:self action:@selector(sureBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        }else {
            _sureBtn.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.5];
            [_sureBtn removeAllTargets];
//            [_sureBtn addTarget:self action:@selector(sureBtnC) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectIndex = indexPath;
    [_tableviewList reloadData];
}
- (void)sureBtnC {
    NSLog(@"1");
}

@end
