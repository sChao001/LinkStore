//
//  SomeOneSymbolController.m
//  Link
//
//  Created by Surdot on 2018/7/11.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "SomeOneSymbolController.h"
#import "HeaderReusableView.h"

@interface SomeOneSymbolController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *mySignCollectionView;
@end

@implementation SomeOneSymbolController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(245, 245, 245);
    [self creatSignCollectionView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)creatSignCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);
    CGFloat width = (ScreenW - 5 * 10) / 4;
    CGFloat height = 40;
    layout.itemSize = CGSizeMake(width, height);
    _mySignCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, LK_iPhoneXNavHeight, ScreenW, ScreenH - LK_iPhoneXNavHeight) collectionViewLayout:layout];
    [self.view addSubview:_mySignCollectionView];
    _mySignCollectionView.backgroundColor = [UIColor whiteColor];
    _mySignCollectionView.delegate = self;
    _mySignCollectionView.dataSource = self;
    [_mySignCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"signCell"];
    //注册头部
    [_mySignCollectionView registerClass:[HeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    layout.headerReferenceSize = CGSizeMake(50, 40);
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"signCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (kind == UICollectionElementKindSectionHeader) {
            HeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
                    headerView.backgroundColor = [UIColor greenColor];
            return headerView;
        }else {
            return nil;
        }
    }else {
        if (kind == UICollectionElementKindSectionHeader) {
            HeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
            headerView.titleLb.text = @"推荐标签";
            //        headerView.backgroundColor = [UIColor greenColor];
            return headerView;
        }else {
            return nil;
        }
    }
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
