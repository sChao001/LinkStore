//
//  CountriesListController.m
//  Link
//
//  Created by Surdot on 2018/5/28.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "CountriesListController.h"
#import "languageModel.h"

@interface CountriesListController ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic) NSInteger indexpathRow;
@end

@implementation CountriesListController

- (void)viewDidLoad {
    [super viewDidLoad];
    _indexpathRow = -1;
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    self.view.backgroundColor = RGB(239, 239, 239);
    [self setCommonLeftBarButtonItem];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self requestDataOfCountriesList];
    self.tableView.bounces = NO;
    NSLog(@"%@", [UserDefault objectForKey:@"Countries"]);
    self.title = @"选择语言";
}
/**
 * 设置左侧按钮
 */
-(void)setCommonLeftBarButtonItem{
    UIImage *tempImage = [UIImage imageNamed:@"y_back"];
    UIImage *selectedImage = [tempImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//防止系统渲染
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:selectedImage style:UIBarButtonItemStylePlain target:self action:@selector(leftBarItemBack)];
}

/**
 * 返回按钮点击事件，子类可重写
 */
- (void)leftBarItemBack {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    languageModel *model = self.dataArray[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = model.name;
    if (self.indexpathRow == indexPath.row) {
        NSLog(@"%ld", (long)_indexpathRow);
//        model = self.dataArray[_indexpathRow];
        [UserDefault setObject:model.name forKey:@"Countries"];
        [UserDefault setObject:model.logogram forKey:@"likeZH"];
        [UserDefault synchronize];
        NSLog(@"%@", model.name);
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.indexpathRow = indexPath.row;
    [self.tableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)requestDataOfCountriesList {
    NSDictionary *paramet = @{@"sign" : BD_SIGN};
    [SCNetwork postWithURLString:BDUrl_c(@"language/get") parameters:paramet success:^(NSDictionary *dic) {
        NSLog(@"%@", dic);
        NSArray *languaArr = dic[@"languages"];
        for (NSDictionary *listDic in languaArr) {
            languageModel *model = [[languageModel alloc] init];
            [model setValuesForKeysWithDictionary:listDic];
            [self.dataArray addObject:model];
            [self.tableView reloadData];
        }
        
        
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
        [SVProgressHUD dismissWithDelay:0.6];
    }];
}

@end
