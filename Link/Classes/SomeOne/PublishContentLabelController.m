//
//  PublishContentLabelController.m
//  Link
//
//  Created by Surdot on 2018/7/18.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "PublishContentLabelController.h"
#import "CustomFlowLayout.h"
#import "LabelsCollectionCell.h"
#import "LabelsLevelTwoModel.h"
#import "ChooseSubLabelsModel.h"

@interface PublishContentLabelController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *myCollectionView;
@property (nonatomic, strong) NSMutableArray *myDataArray;
@end

@implementation PublishContentLabelController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(245, 245, 245);
    self.myDataArray = [NSMutableArray arrayWithCapacity:0];
    [self makeCollectionView];
//    [self requestDataList];
    [self requestChooseLabelList];
    [self setCommonLeftBarButtonItem];
    self.title = @"选择标签";
}

- (void)makeCollectionView {
    CustomFlowLayout *layout = [[CustomFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.maximumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,  0, ScreenW, ScreenH - LK_iPhoneXNavHeight - 20- 150) collectionViewLayout:layout];
    [self.view addSubview:_myCollectionView];
    _myCollectionView.backgroundColor = [UIColor whiteColor];
    [_myCollectionView registerClass:[LabelsCollectionCell class] forCellWithReuseIdentifier:@"labelCell"];
    _myCollectionView.delegate = self;
    _myCollectionView.dataSource = self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //    return _dataArray.count;
    return _myDataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    LabelsLevelTwoModel *model = self.myDataArray[indexPath.row];
    LabelsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"labelCell" forIndexPath:indexPath];
    cell.titleLb.text = self.myDataArray[indexPath.row];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *string = self.myDataArray[indexPath.row];
    CGSize sizeItem = [string boundingRectWithSize:CGSizeMake(ScreenW - 100, __FLT_MAX__) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    return CGSizeMake(sizeItem.width +20, 30);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(labelTitle:)]) {
        [_delegate labelTitle:self.myDataArray[indexPath.row]];
    }
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)requestDataList {
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"labelId" : @"46"};
    [SCNetwork postWithURLString:BDUrl_s(@"label/getLabelByRootNodeId") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSArray *array = dic[@"userLabels"];
            for (NSDictionary *listDic in array) {
                LabelsLevelTwoModel *model = [[LabelsLevelTwoModel alloc] init];
                [model setValuesForKeysWithDictionary:listDic];
                [self.myDataArray addObject:model.labelName];
            }
            NSLog(@"%ld", self.myDataArray.count);
            [self.myCollectionView reloadData];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络加载失败"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}

- (void)requestChooseLabelList {
    NSLog(@"%@==%@", _rootId, [UserInfo sharedInstance].getUserid);
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"rootNodeId" : _rootId};
    [SCNetwork postWithURLString:BDUrl_s(@"label/getLabelsByRootNodeId") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"%@", dic);
            NSArray *array = dic[@"labels"];
            for (NSDictionary *listDic in array) {
                ChooseSubLabelsModel *model = [[ChooseSubLabelsModel alloc] init];
                [model setValuesForKeysWithDictionary:listDic];
                [self.myDataArray addObject:model.name];

            }
            NSLog(@"%ld", self.myDataArray.count);
            [self.myCollectionView reloadData];

        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络加载失败"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}













@end
