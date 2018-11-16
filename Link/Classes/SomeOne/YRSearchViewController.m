//
//  YRSearchViewController.m
//  Link
//
//  Created by Surdot on 2018/7/9.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "YRSearchViewController.h"
#import "CustomTextField.h"
#import "CustomFlowLayout.h"
#import "LabelsCollectionCell.h"
#import "YRSearchListViewController.h"
#import "HotLabelsModel.h"

@interface YRSearchViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) CustomTextField *searchTextField;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UICollectionView *myCollectionView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) YRSearchListViewController *searchListVC;
@property (nonatomic, strong) NSMutableArray *myDataArray;
@property (nonatomic, strong) RImagButton *clearBtn;
@end

@implementation YRSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBarButtonWithNorImgName:@"y_back"];
    self.view.backgroundColor = RGB(245, 245, 245);
    self.myDataArray = [NSMutableArray arrayWithCapacity:0];
    [self makeCollectionView];
    
    _dataArray = @[@"习近平", @"哈哈哈",@"妙手空空",@"马赛克",@"里的",@"人名", @"哈哈哈",@"妙手空空",@"马赛克",@"里的",@"人名", @"哈哈哈",@"妙手空空",@"马赛克",@"里的",@"人名", @"哈哈哈",@"妙手空空",@"马赛克",@"里的",@"人名", @"哈哈哈",@"妙手空空",@"马赛克",@"里的",@"人名", @"哈哈哈",@"妙手空空",@"马赛克",@"里的",@"人名", @"哈哈哈",@"妙手空空",@"马赛克",@"里的",@"人名", @"哈哈哈",@"妙手空空",@"马赛克",@"里的",@"哈哈哈",@"妙手空空",@"马赛克",@"里的",@"人名", @"哈哈哈",@"妙手空空",@"马赛克",@"里的",@"人名", @"哈哈哈",@"妙手空空",@"马赛克",@"里的"];
    [self creatMyAlertlabel];
    [self requestDataList];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self configControlsLayout];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [_searchTextField removeFromSuperview];
    [_clearBtn removeFromSuperview];
}
- (void)configControlsLayout {
    _searchTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(55, 9.5, ScreenW - 110, 25)];
    [self.navigationController.navigationBar addSubview:_searchTextField];
//    _searchTextField = [[CustomTextField alloc] init];
//    [self.navigationController.navigationBar addSubview:_searchTextField];
//    [_searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(50);
//        make.right.equalTo(-70);
//        make.height.equalTo(25);
//        make.centerY.equalTo(0);
//    }];

    _searchTextField.backgroundColor = [ColorHex(@"fff276") colorWithAlphaComponent:0.5];
    _searchTextField.textColor = RGB(28, 28, 28);
    _searchTextField.font = [UIFont systemFontOfSize:kWidthScale(16)];
    _searchTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"选择搜索标签" attributes:@{NSForegroundColorAttributeName:RGBA(100, 100, 100, 0.6), NSFontAttributeName:[UIFont systemFontOfSize:kWidthScale(15)]}];
    _searchTextField.layer.cornerRadius = 6;
    _searchTextField.layer.masksToBounds = YES;
    
//    _clearBtn = [[RImagButton alloc] init];
//    [self.navigationController.navigationBar addSubview:_clearBtn];
//    [_clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.searchTextField.mas_top).equalTo(0);
//        make.left.equalTo(self.searchTextField.mas_right).equalTo(0);
//        make.height.equalTo(30);
//        make.width.equalTo(20);
//    }];
//    _clearBtn.imageRect = CGRectMake(0, 0, 20, 30);
//    [_clearBtn setImage:[UIImage imageNamed:@"叉号2"] forState:UIControlStateNormal];
//    [_clearBtn addTarget:self action:@selector(clearBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    _clearBtn = [[RImagButton alloc] init];
    [self.searchTextField addSubview:_clearBtn];
    [_clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(-5);
//        make.centerY.equalTo(0);
//        make.size.equalTo(CGSizeMake(15, 15));
        make.top.right.bottom.equalTo(0);
        make.width.equalTo(30);
    }];
    _clearBtn.imageRect = CGRectMake(10, 5, 15, 15);
    [_clearBtn setImage:[UIImage imageNamed:@"y_close"] forState:UIControlStateNormal];
    [_clearBtn addTarget:self action:@selector(clearBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(searchEvents)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightItem setTintColor:RGB(28, 28, 28)];
//    UIImage *image = [UIImage imageNamed:@""];
    
    _searchListVC = [[YRSearchListViewController alloc] init];
    [self.view addSubview:_searchListVC.view];
    [self addChildViewController:_searchListVC];
    _searchListVC.labelStr = _searchTextField.text;
    _searchListVC.view.hidden = YES;
}
- (void)clearBtnClicked {
    _searchTextField.text = @"";
    _searchListVC.view.hidden = YES;
}
- (void)makeCollectionView {
    _titleLb = [[UILabel alloc] initWithFrame:CGRectMake(5, 10+LK_iPhoneXNavHeight, ScreenW, 30)];
    [self.view addSubview:_titleLb];
    _titleLb.text = @"热门标签";
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = RGB(28, 28, 28);
    
    CustomFlowLayout *layout = [[CustomFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.maximumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,  45+LK_iPhoneXNavHeight, ScreenW, ScreenH - LK_iPhoneXNavHeight - 20- 150) collectionViewLayout:layout];
    [self.view addSubview:_myCollectionView];
    _myCollectionView.backgroundColor = [UIColor whiteColor];
    [_myCollectionView registerClass:[LabelsCollectionCell class] forCellWithReuseIdentifier:@"labelCell"];
    _myCollectionView.delegate = self;
    _myCollectionView.dataSource = self;
}
- (void)searchEvents {
    NSLog(@"1234");
    if (![CommentTool isBlankString:_searchTextField.text]) {
        _searchListVC.labelStr = _searchTextField.text;
        _searchListVC.view.hidden = NO;
        
    }else {
        NSLog(@"请选择标签或输入内容");
        [self alertShowWithTitle:@"请选择标签或输入内容"];
    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return _dataArray.count;
    return _myDataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LabelsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"labelCell" forIndexPath:indexPath];
    cell.titleLb.text = _myDataArray[indexPath.row];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *string = self.myDataArray[indexPath.row];
    CGSize sizeItem = [string boundingRectWithSize:CGSizeMake(ScreenW - 100, __FLT_MAX__) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    return CGSizeMake(sizeItem.width +20, 30);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    _searchListVC = [[YRSearchListViewController alloc] init];
//    [self.view addSubview:_searchListVC.view];
//    [self addChildViewController:_searchListVC];
//    _searchListVC.labelStr = _searchTextField.text;
//    _searchListVC.view.hidden = YES;
    
    _searchTextField.text = [NSString stringWithFormat:@"%@", _myDataArray[indexPath.row]];
    _searchListVC.labelStr = _searchTextField.text;
    _searchListVC.view.hidden = NO;
    if (_delegate && [_delegate respondsToSelector:@selector(searchText:)]) {
        [_delegate searchText:_myDataArray[indexPath.row]];
    }
   
}

- (void)requestDataList {
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid};
    [SCNetwork postWithURLString:BDUrl_s(@"label/getHotLabel") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSArray *array = dic[@"hotLabels"];
            for (NSDictionary *listDic in array) {
                HotLabelsModel *model = [[HotLabelsModel alloc] init];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
