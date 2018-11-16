//
//  LKGroupSetViewController.m
//  Link
//
//  Created by Surdot on 2018/5/22.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "LKGroupSetViewController.h"
#import "LKGroupMembersCell.h"
#import "TopCollectionController.h"
#import "TopViewController.h"
#import "GroupInfoCell.h"

@interface LKGroupSetViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *_groupAll;
}
@property (nonatomic, strong) UITableView *wholeTableView;
@property (nonatomic, strong) TopCollectionController *collectionVC;

@end

@implementation LKGroupSetViewController

- (void)viewDidLoad {
    self.view.backgroundColor = RGB(235, 235, 235);
    [self setMyTableView];
    [self initCreateData];
}

- (void)setMyTableView {
//    _wholeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, ScreenW, ScreenH)];
    _wholeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, ScreenW, ScreenH) style:UITableViewStylePlain];
    [self.view addSubview:_wholeTableView];
    _wholeTableView.backgroundColor = [UIColor redColor];
    _wholeTableView.delegate = self;
    _wholeTableView.dataSource = self;
    
    _collectionVC = [[TopCollectionController alloc] init];
//    _collectionVC.view.frame = CGRectMake(0, 0, ScreenW, 100);
    [_wholeTableView.tableHeaderView addSubview:_collectionVC.membersCollectionView];
}
-(void)initCreateData
{
    _groupAll=[NSMutableArray new];
//    _arrPer=[NSMutableArray new];
    
    NSArray *arr1=@[@"群聊名称",@"群二维码"];
    NSArray *arr2=@[@"消息免打扰"];
    NSArray *arr4=@[@"共享我的邮件在本群"];
    NSArray *arr5=@[@"清空聊天记录"];
    [_groupAll addObject:arr1];
    [_groupAll addObject:arr2];
    [_groupAll addObject:arr4];
    [_groupAll addObject:arr5];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _groupAll.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_groupAll[section]count] ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 6;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    view.backgroundColor = [UIColor purpleColor];
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static  NSString *idfCell=@"grouptopcell";
    GroupInfoCell *topcell=(GroupInfoCell*)[tableView dequeueReusableCellWithIdentifier:idfCell];
    if(topcell==nil)
    {
        topcell=[[[NSBundle mainBundle]loadNibNamed:@"GroupInfoCell" owner:self options:nil] lastObject];
    }
    topcell.titleShow.text=_groupAll[indexPath.section][indexPath.row];
    
    
    if(indexPath.section==0&&indexPath.row==0)//名字标签的显示
    {
        topcell.nameShow.hidden=NO;
    }else
    {
        topcell.nameShow.hidden=YES;
    }
    if(indexPath.section==0||indexPath.section==2)//此行要显示点击
    {
        topcell.clickimg.hidden=NO;
    }else
    {
        topcell.clickimg.hidden=YES;
    }
    if(indexPath.section==1||indexPath.section==2)//要显示开关按钮
    {
        topcell.switchClickimg.hidden=NO;
    }
    else{
        topcell.switchClickimg.hidden=YES;
    }
    
    //以上控制显示和不显示的控件
    
    if(indexPath.section==0&&indexPath.row==0)
    {
        topcell.nameShow.text=@"ios交流群";
    }
    
    
    return topcell;
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
