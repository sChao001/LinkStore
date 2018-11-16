//
//  TopViewController.m
//  BM
//
//  Created by hackxhj on 15/9/7.
//  Copyright (c) 2015年 hackxhj. All rights reserved.
//


#import "TopViewController.h"
#import "LKGroupMembersCell.h"
#import "PersonIntroViewController.h"

 static NSString *kcellIdentifier = @"collectionCellID";
@interface TopViewController ()


@end


@implementation TopViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _signStr = @"0";

    // Do any additional setup after loading the view.
    [self.collectionView registerClass:[LKGroupMembersCell class] forCellWithReuseIdentifier:kcellIdentifier];
    self.collectionView.backgroundColor= [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.bounces = NO;
    self.collectionView.scrollEnabled = NO;

    _dataArr=[NSMutableArray new];
    _arrayTemp=[NSMutableArray new];
    
    NSLog(@"数组：%lu, %lu", (unsigned long)_dataArr.count, (unsigned long)_arrayTemp.count);
}


-(void)isInputDelMoudle:(BOOL)isDel
{
    _isdelM=isDel;
    [self.collectionView reloadData];
}

//-(void)delGroupOneTximg:(PersonModel*)person
//{
//    _arrayTemp = _dataArr;
//    NSArray * array = [NSArray arrayWithArray: _arrayTemp];
//    for (PersonModel *pp in array) {
//        if([pp.friendId isEqualToString:person.friendId])
//        {
//            [_arrayTemp removeObject:pp];
//        }
//    }
//    
//    _dataArr=[_arrayTemp mutableCopy];
//    [self.collectionView reloadData];
//}


-(void)delOneTximg:(PersonModel*)person
{
    _arrayTemp = _dataArr;
    NSArray * array = [NSArray arrayWithArray: _arrayTemp];
    for (PersonModel *pp in array) {
        if([pp.friendId isEqualToString:person.friendId])
        {
            [_arrayTemp removeObject:pp];
        }
    }
    
    _dataArr=[_arrayTemp mutableCopy];
    [self.collectionView reloadData];
}

-(void)addOneTximg:(PersonModel*)person
 {
   [_dataArr insertObject:person atIndex:0];
   [self.collectionView reloadData];
}

- (void)deleteSomeOne:(GroupMembersModel *)person {
    _arrayTemp = _dataArr;
    NSArray * array = [NSArray arrayWithArray: _arrayTemp];
    for (GroupMembersModel *model in array) {
        if([[model.ID stringValue] isEqualToString:[person.ID stringValue]])
        {
            [_arrayTemp removeObject:model];
        }
    }
    
    _dataArr=[_arrayTemp mutableCopy];
    [self.collectionView reloadData];
}

- (void)addSomeOne:(NSArray *)person {
//    NSLog(@"%@", person);
//    [_dataArr insertObject:person atIndex:0];
//    NSLog(@"%ld", _dataArr.count);
    _dataArr = (NSMutableArray *)person;
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
 
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"===数组%lu", (unsigned long)_dataArr.count);
    return _dataArr.count+1;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld", _dataArr.count);
    LKGroupMembersCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kcellIdentifier forIndexPath:indexPath];
//    GroupMembersModel *model = self.dataArr[indexPath.row];
//    [cell.iconImg sd_setImageWithURL:[NSURL URLWithString:BDUrl_(model.headUrl)]];
//    cell.nameLb.text = model.nickName;
    
//    cell.delagate=self;
    if (indexPath.row == 0) {
        cell.nameLb.hidden = NO;
    }
    if(indexPath.row == _dataArr.count)
    {
        cell.iconImg.image = [UIImage imageNamed:@"addfriend"];
        cell.nameLb.hidden = YES;
    }else {
        GroupMembersModel *model = self.dataArr[indexPath.row];
        [cell.iconImg sd_setImageWithURL:[NSURL URLWithString:BDUrl_(model.headUrl)]];
        cell.nameLb.text = model.nickName;
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.dataArr.count) {
        if (_delagate && [_delagate respondsToSelector:@selector(addBtnClick)]) {
            [_delagate addBtnClick];
        }
    }else if (_delagate && [_delagate respondsToSelector:@selector(cellOfItemClicked:)]) {
        GroupMembersModel *model = self.dataArr[indexPath.row];
        NSLog(@"%@", model.ID);
        [_delagate cellOfItemClicked:model];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    return CGSizeMake(60, 75);
    return CGSizeMake(58, 83);
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
//    return UIEdgeInsetsMake(8, 8, 8, 8);//分别为上、左、下、右
    return UIEdgeInsetsMake(18, 16, 25, 16);
}






@end
