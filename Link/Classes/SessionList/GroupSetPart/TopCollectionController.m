//
//  TopCollectionController.m
//  Link
//
//  Created by Surdot on 2018/5/22.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "TopCollectionController.h"
#import "LKGroupMembersCell.h"

@interface TopCollectionController () < UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
//@property (nonatomic, strong) UICollectionView *membersCollectionView;

@end

@implementation TopCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(239, 239, 239);
    [self creatCollectionViewLayout];
}

- (void)creatCollectionViewLayout {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 25;
    layout.minimumInteritemSpacing = 13;
    layout.sectionInset = UIEdgeInsetsMake(18, 16, 25, 16);
    //像素是不可分割的最小单位. 所有浮点型会被强制转化成整形.为了防止四舍五入. 通过强制转化为整形的方式, 切除掉小数点后面的部分.
    //    CGFloat width = (long)(ScreenW - 4 * 13 - 18 * 2) / 5;
    //    CGFloat height = width + 28 + 2;
    CGFloat width = 58;
    CGFloat height = 83;
    layout.itemSize = CGSizeMake(width, height);
    
    _membersCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) collectionViewLayout:layout];
    [self.view addSubview:_membersCollectionView];
    _membersCollectionView.backgroundColor = [UIColor redColor];
    _membersCollectionView.delegate = self;
    _membersCollectionView.dataSource = self;
    
    _membersCollectionView.bounces = NO;
    [_membersCollectionView registerClass:[LKGroupMembersCell class] forCellWithReuseIdentifier:@"memberCell"];

    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //    if (section == 0) {
    //        return 25;
    //    }
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LKGroupMembersCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"memberCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
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
