//
//  ChooseedSignController.m
//  Link
//
//  Created by Surdot on 2018/6/20.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "ChooseedSignController.h"
#import "LKGroupMembersCell.h"
#import "ChooseedSignCell.h"
#import "HeaderReusableView.h"

@interface ChooseedSignController () <UICollectionViewDelegate, UICollectionViewDataSource>///<UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *mySignCollectionView;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation ChooseedSignController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(245, 245, 245);
    [self creatSignCollectionView];
    _array = [[NSMutableArray alloc] initWithObjects:@"a", @"b", @"c", @"d",
                                                    @"e", @"f", @"g", @"h",
                                                      @"i", @"j", nil];
    NSLog(@"signArray:%@", _signArray);
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
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    CGFloat width = (ScreenW - 5 * 10) / 4;
    CGFloat height = 40;
    layout.itemSize = CGSizeMake(width, height);
    _mySignCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, LK_iPhoneXNavHeight, ScreenW, ScreenH - LK_iPhoneXNavHeight) collectionViewLayout:layout];
    [self.view addSubview:_mySignCollectionView];
    _mySignCollectionView.backgroundColor = [UIColor whiteColor];
    _mySignCollectionView.delegate = self;
    _mySignCollectionView.dataSource = self;
    [_mySignCollectionView registerClass:[ChooseedSignCell class] forCellWithReuseIdentifier:@"signCell"];
    _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressMoving:)];
    [_mySignCollectionView addGestureRecognizer:_longPress];
    //注册头部
    [_mySignCollectionView registerClass:[HeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    layout.headerReferenceSize = CGSizeMake(50, 40);
    
}
//长按cell
- (void)longPressMoving:(UILongPressGestureRecognizer *)longPress
{
    switch (_longPress.state) {
        case UIGestureRecognizerStateBegan: {
            {
                // 判断手势落点位置是否在路径上(长按cell时,显示对应cell的位置,如path = 1 - 0,即表示长按的是第1组第0个cell). 点击除了cell的其他地方皆显示为null
                NSIndexPath *selectIndexPath = [self.mySignCollectionView indexPathForItemAtPoint:[_longPress locationInView:self.mySignCollectionView]];
                
                // 找到当前的cell
//                ChooseedSignCell *cell = (ChooseedSignCell *)[self.mySignCollectionView cellForItemAtIndexPath:selectIndexPath];
                // 定义cell的时候btn是隐藏的, 在这里设置为NO
//                [cell.btnDelete setHidden:NO];
                
                // 如果点击的位置不是cell,break
                if (nil == selectIndexPath) {
                    break;
                }
                NSLog(@"%@",selectIndexPath);
                // 在路径上则开始移动该路径上的cell
                if (@available(iOS 9.0, *)) {
                    [_mySignCollectionView beginInteractiveMovementForItemAtIndexPath:selectIndexPath];
                } else {
                    // Fallback on earlier versions
                }
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            // 移动过程当中随时更新cell位置
            if (@available(iOS 9.0, *)) {
                [self.mySignCollectionView updateInteractiveMovementTargetPosition:[longPress locationInView:_longPress.view]];
            } else {
                // Fallback on earlier versions
            }
            break;
        }
        case UIGestureRecognizerStateEnded: {
            // 移动结束后关闭cell移动
            if (@available(iOS 9.0, *)) {
                [self.mySignCollectionView endInteractiveMovement];
            } else {
                // Fallback on earlier versions
            }
            break;
        }
        default: if (@available(iOS 9.0, *)) {
            [self.mySignCollectionView cancelInteractiveMovement];
        } else {
            // Fallback on earlier versions
        }
            break;
    }
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return 10;
    if (section == 0) {
        return _signArray.count;
    }else {
        return 20;
    }
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChooseedSignCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"signCell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor redColor];
//    cell.titleLb.text = self.array[indexPath.row];
//    cell.titleLb.text = self.signArray[indexPath.row];
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (kind == UICollectionElementKindSectionHeader) {
            HeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
            //        headerView.backgroundColor = [UIColor greenColor];
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
//移动cell方法
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
//    NSIndexPath *selectIndexPath = [self.mySignCollectionView indexPathForItemAtPoint:[_longPress locationInView:self.mySignCollectionView]];
    // 找到当前的cell
//    ChooseedSignCell *cell = (ChooseedSignCell *)[self.mySignCollectionView cellForItemAtIndexPath:selectIndexPath];
//    [cell.btnDelete setHidden:YES];
    
//    [self.array exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
    
    [self.array exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
   
    [self.mySignCollectionView reloadData];
    
}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(10, 10, 10, 10);
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return 10;
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 10;
//}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
