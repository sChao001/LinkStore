//
//  SomeOneLabelsController.m
//  Link
//
//  Created by Surdot on 2018/7/4.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "SomeOneLabelsController.h"
#import "ChooseSomeLabelsController.h"
#import "ShowLabelsListCell.h"
#import "LabelsLevelOneModel.h"
#import "LabelsLevelTwoModel.h"

@interface SomeOneLabelsController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *myDataArray;
@property (nonatomic, strong) NSMutableArray *myDataArrayT;
@property (nonatomic, strong) NSMutableArray *testArray;
@property (nonatomic, assign) int cellheight;
@end

@implementation SomeOneLabelsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置标签";
    [self setLeftBarButtonWithNorImgName:@"y_back"];
    self.view.backgroundColor = [UIColor cyanColor];
    [self creatMyTableView];
    _myDataArray = [NSMutableArray arrayWithCapacity:0];
    _myDataArrayT = [NSMutableArray arrayWithCapacity:0];
    _testArray = [NSMutableArray arrayWithCapacity:0];
    _dataArray = @[@"都是", @"地方",@"12", @"都是", @"地方", @"666", @"惊声尖叫", @"收到", @"地方",@"12", @"都是"];
    [self requestMylabelsData];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self requestMylabelsData];
//    [self.listTableView reloadData];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)creatMyTableView {
    UILabel *headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 30)];
//    headerView.backgroundColor = [UIColor orangeColor];
    headerView.text = @"  兴趣爱好";
    headerView.textColor = RGB(28, 28, 28);
    headerView.font = [UIFont systemFontOfSize:kWidthScale(15)];
    UIView *line = [[UIView alloc] init];
    [headerView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(0);
        make.left.equalTo(15);
        make.height.equalTo(1);
    }];
    line.backgroundColor = RGB(200, 200, 200);
    
    
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStylePlain];
    [self.view addSubview:_listTableView];
    _listTableView.backgroundColor = RGB(245, 245, 245);
    _listTableView.bounces = NO;
    _listTableView.tableHeaderView = headerView;
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    _listTableView.tableFooterView = [[UIView alloc] init];
    [_listTableView registerClass:[ShowLabelsListCell class] forCellReuseIdentifier:@"listCell"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _myDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LabelsLevelOneModel *model = self.myDataArray[indexPath.row];
    ShowLabelsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell" forIndexPath:indexPath];
//        cell.MycontentView.tagArray = _dataArray;
    cell.titleLb.text = model.name;
    
    [self.testArray removeAllObjects];
    NSArray *array = model.children;
    for (NSDictionary *chirldList in array) {
        LabelsLevelOneDataModel *dataModel = [[LabelsLevelOneDataModel alloc] init];
        [dataModel setValuesForKeysWithDictionary:chirldList];
        [self.testArray addObject:dataModel.labelName];
    }
    cell.MycontentView.tagArray = self.testArray;
    
    NSLog(@"totalHeight:%d", cell.MycontentView.totalHeight);
    _cellheight = cell.MycontentView.totalHeight;
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_cellheight > 70) {
        return _cellheight;
    }else {
        return 70;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LabelsLevelOneModel *model = self.myDataArray[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ChooseSomeLabelsController *vc = [[ChooseSomeLabelsController alloc] init];
    vc.fatherId = [NSString stringWithFormat:@"%@", model.Id];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)requestMylabelsData {
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid};
    [SCNetwork postWithURLString:BDUrl_s(@"label/getRootNodeLabel") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSArray *labelsArray = dic[@"labels"];
            [self.myDataArray removeAllObjects];
            for (NSDictionary *listDic in labelsArray) {
                LabelsLevelOneModel *model = [[LabelsLevelOneModel alloc] init];
                [model setValuesForKeysWithDictionary:listDic];
                [self.myDataArray addObject:model];
            }
            [self.listTableView reloadData];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
