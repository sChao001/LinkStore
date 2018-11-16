//
//  ChooseSomeLabelsController.m
//  Link
//
//  Created by Surdot on 2018/7/4.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "ChooseSomeLabelsController.h"
#import "CustomFlowLayout.h"
#import "LabelsCollectionCell.h"
#import "SCTagView.h"
#import "CustomTextField.h"
#import "LabelsLevelOneModel.h"
#import "LabelsLevelThreeModel.h"
#import "LabelsLevelFourModel.h"
#import "UploadLabelsModel.h"


#define t_hegiht 90
@interface ChooseSomeLabelsController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *addView;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UICollectionView *topCollectionView;
@property (nonatomic, strong) UICollectionView *myCollectionView;
@property (nonatomic, assign) CGFloat maximumInteritemSpacing;
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *myDataArray;
@property (nonatomic, strong) NSMutableArray *dataArrayThree;
@property (nonatomic, strong) NSMutableArray *dataFour;
@property (nonatomic, strong) UIScrollView *labelScrollView;
@property (nonatomic, strong) NSMutableArray *tempArray;
@property (nonatomic, strong) CustomTextField *addlabelsFeild;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) SCTagView *tagView;
@property (nonatomic, strong) NSArray *myArray;
@property (nonatomic, assign) CGFloat ItemWide;
@property (nonatomic, assign) CGFloat totalWide;
@property (nonatomic, assign) CGFloat tempWide;
@property (nonatomic, assign) CGFloat addHegiht;
@property (nonatomic, strong) UITableView *typeTableView;
@property (nonatomic, strong) NSString *titleId;
@end

@implementation ChooseSomeLabelsController

- (void)viewDidLoad {
    [super viewDidLoad];
    _addHegiht = 0;
    self.titleId = @"";
    [self setLeftBarButtonWithNorImgName:@"y_back"];
    self.view.backgroundColor = RGB(200, 200, 200);
    self.tempArray = [NSMutableArray arrayWithCapacity:0];
    self.myDataArray = [NSMutableArray arrayWithCapacity:0];
    self.dataArrayThree = [NSMutableArray arrayWithCapacity:0];
    self.dataFour = [NSMutableArray arrayWithCapacity:0];
    [self makeTopLabelsView];
    [self creatMyCollectionView];
//    [self makeLeftPartOfBtnlayout];
    [self creatLeftListTableView];
    _dataArray = @[@"人名", @"哈哈",@"妙手",@"马赛克",@"里的",@"人名", @"哈哈哈",@"妙手空空",@"马赛克",@"里的",@"人名", @"哈哈哈",@"妙手空空",@"马赛克",@"里的",@"人名", @"哈哈哈",@"妙手空空",@"马赛克",@"里的",@"人名", @"哈哈哈",@"妙手空空",@"马赛克",@"里的",@"人名", @"哈哈哈",@"妙手空空",@"马赛克",@"里的",@"人名", @"哈哈哈",@"妙手空空",@"马赛克",@"里的",@"人名", @"哈哈哈",@"妙手空空",@"马赛克",@"里的"];
    
    _myArray = @[@"佛罗里达"];
    
    _tagView = [[SCTagView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0)];
    _tagView.backgroundColor = RGB(200, 200, 200);
    [_topView addSubview:_tagView];
    
    [self requestLabelsOfLevelTwoData];
//    [self requestLabelsOfLeveThreeData];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(requestAddAndDeleteData)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self.navigationItem.rightBarButtonItem setTintColor:RGB(38, 38, 38)];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)makeTopLabelsView {
//    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, LK_iPhoneXNavHeight, ScreenW, 0)];
//    _topView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:_topView];
    
    CustomFlowLayout *layout = [[CustomFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.maximumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    _topCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0) collectionViewLayout:layout];
    _topCollectionView.tag = 1011;
    [self.view addSubview:_topCollectionView];
    _topCollectionView.delegate = self;
    _topCollectionView.dataSource = self;
    [_topCollectionView registerClass:[LabelsCollectionCell class] forCellWithReuseIdentifier:@"cell"];
}
- (void)creatMyCollectionView {
    _addView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    [self.view addSubview:_addView];
    _addView.backgroundColor = [UIColor whiteColor];
    UIView *lineView = [[UIView alloc] init];
    [_addView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(0);
        make.height.equalTo(2);
    }];
    lineView.backgroundColor = RGB(245, 245, 245);
    UIView *lineViewTop = [[UIView alloc] init];
    [_addView addSubview:lineViewTop];
    [lineViewTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(0);
        make.height.equalTo(2);
    }];
    lineViewTop.backgroundColor = RGB(245, 245, 245);
    
//    _addView = [[UIView alloc] init];
//    [self.view addSubview:_addView];
//    [_addView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.topView.mas_botto m);
//        make.left.right.equalTo(0);
//        make.height.equalTo(50);
//    }];
    
    _addButton = [[UIButton alloc] init];
    [_addView addSubview:_addButton];
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-15);
        make.centerY.equalTo(0);
        make.size.equalTo(CGSizeMake(kWidthScale(70), kWidthScale(40)));
    }];
    [_addButton setTitle:@"添加" forState:UIControlStateNormal];
    [_addButton setTitleColor:RGB(26, 26, 26) forState:UIControlStateNormal];
    _addButton.layer.cornerRadius = kWidthScale(20);
    _addButton.layer.masksToBounds = YES;
    _addButton.layer.borderColor = RGB(202, 202, 202).CGColor;
    _addButton.layer.borderWidth = 1;
    [_addButton addTarget:self action:@selector(addBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    _addButton.titleLabel.font = [UIFont systemFontOfSize:16];
    
    
//    _addView.backgroundColor = [UIColor yellowColor];
    _addlabelsFeild = [[CustomTextField alloc] init];
    [_addView addSubview:_addlabelsFeild];
    [_addlabelsFeild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.centerY.equalTo(0);
        make.right.equalTo(self.addButton.mas_left).equalTo(-15);
        make.height.equalTo(kWidthScale(40));
    }];
    _addlabelsFeild.backgroundColor = RGB(230, 230, 230);
    _addlabelsFeild.layer.cornerRadius = kWidthScale(20);
    _addlabelsFeild.layer.masksToBounds = YES;
    _addlabelsFeild.placeholder = @"自定义输入标签";
    
    
    
    CustomFlowLayout *layout = [[CustomFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.maximumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);

//    CGFloat width = ((ScreenW - 100)-4*10)/3;
//    CGFloat height = 30;
//    layout.itemSize = CGSizeMake(width, height);
    _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(100, 50, ScreenW-100, ScreenH - 50) collectionViewLayout:layout];
    _myCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_myCollectionView];
    _myCollectionView.dataSource = self;
    _myCollectionView.delegate = self;
    [_myCollectionView registerClass:[LabelsCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    _myCollectionView.bounces = NO;
    
//    _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
//    [self.view addSubview:_myCollectionView];
////    _myCollectionView.collectionViewLayout = layout;
//    [_myCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.addView.mas_bottom);
//        make.right.equalTo(0);
//        make.bottom.equalTo(0);
//        make.width.equalTo(ScreenW-100);
//    }];
//    _myCollectionView.backgroundColor = [UIColor whiteColor];
//    _myCollectionView.dataSource = self;
//    _myCollectionView.delegate = self;
}
- (void)addBtnClicked {
    NSLog(@"adedf");
    if (_tempArray.count < 6) {
        if (![CommentTool isBlankString:_addlabelsFeild.text] && _addlabelsFeild.text.length <6) {
            [self.tempArray addObject:_addlabelsFeild.text];
            [self updateTopViewFrame];
            _addlabelsFeild.text = nil;
        }
    }
}
- (void)makeLeftPartOfBtnlayout {
    _leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 100, ScreenH - 50)];
    [self.view addSubview:_leftView];
    _leftView.backgroundColor = RGB(235, 235, 235);
    
//    NSArray *titleArray = @[@"热门", @"外貌", @"性格", @"星座", @"血型", @"颜色"];
    for (int i = 0; i<_myDataArray.count; i++) {
        LabelsLevelOneModel *model = _myDataArray[i];
        UIButton *titleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, i*30 + 10, 100, 30)];
        [_leftView addSubview:titleBtn];
        [titleBtn setTitle:[NSString stringWithFormat:@"%@", model.name] forState:UIControlStateNormal];
        [titleBtn setTitleColor:RGB(28, 28, 28) forState:UIControlStateNormal];
        [titleBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateSelected];
//        [titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        titleBtn.tag = i*11;
        if (i == 0) {
            self.selectedBtn = titleBtn;
            self.selectedBtn.selected = YES;
            self.titleString = titleBtn.currentTitle;
            self.titleId = [NSString stringWithFormat:@"%@", model.Id];
        }
        [titleBtn addTarget:self action:@selector(titleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [titleBtn setTitleColor:RGB(43, 43, 43) forState:UIControlStateNormal];
    }
}
- (void)creatLeftListTableView {
    _typeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, 100, ScreenH - 50) style:UITableViewStylePlain];
    [self.view addSubview:_typeTableView];
    _typeTableView.backgroundColor = RGB(235, 235, 235);
    _typeTableView.bounces = NO;
    _typeTableView.tableFooterView = [[UIView alloc] init];
    _typeTableView.delegate = self;
    _typeTableView.dataSource = self;
    [_typeTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"typeCell"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _myDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LabelsLevelOneModel *model = _myDataArray[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"typeCell" forIndexPath:indexPath];
    cell.textLabel.text = model.name;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.backgroundColor = RGB(235, 235, 235);
    UIView *view = [[UIView alloc]init];
    view.backgroundColor=[UIColor whiteColor];
    cell.selectedBackgroundView=view;

    if (indexPath.row == 0) {
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        self.titleId = [NSString stringWithFormat:@"%@", model.Id];
//        [self requestLabelsOfLeveThreeData];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LabelsLevelOneModel *model = _myDataArray[indexPath.row];
    self.titleId = [NSString stringWithFormat:@"%@", model.Id];
    NSLog(@"%@", [NSString stringWithFormat:@"%@", model.Id]);
    [self requestLabelsOfLeveThreeData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView.tag == 1011) {
        NSLog(@"%lu", (unsigned long)_tempArray.count);
        return _tempArray.count;
        
    }
    NSLog(@"%lu", (unsigned long)_dataArrayThree.count);
    return _dataArrayThree.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == 1011) {
        LabelsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//        cell.backgroundColor = [UIColor cyanColor];
        cell.titleLb.text = _tempArray[indexPath.row];
        return cell;
    }
    LabelsLevelThreeModel *modelTh = self.dataArrayThree[indexPath.row];
    LabelsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor redColor];
    
    
//    cell.titleLb.text = _dataArray[indexPath.row];
    cell.titleLb.text = modelTh.name;
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == 1011) {
//        if (_tempArray.count > 6) {
//            NSLog(@"标签最多设置六个");
//        }
        NSLog(@"qww");
        [self.tempArray removeObjectAtIndex:indexPath.row];
        [_topCollectionView reloadData];
        if (_tempArray.count < 1) {
            [self updatedDeleteTopViewState];
        }
    }else {
        NSLog(@"%@", self.tempArray);
        if (_tempArray.count < 6) {
            LabelsLevelThreeModel *model = _dataArrayThree[indexPath.row];
            [self.tempArray addObject:model.name];
            [self updateTopViewFrame];
        }
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView.tag == 1011) {
        NSString *string = self.tempArray[indexPath.row];
        CGSize sizeItem = [string boundingRectWithSize:CGSizeMake(ScreenW - 100, __FLT_MAX__) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        _ItemWide = sizeItem.width +30;
        
        _totalWide += _ItemWide;
//        NSLog(@"tempWide:%f", tempWide);
        NSLog(@"ff%f", _totalWide);
        NSLog(@"%f", _ItemWide);
        return CGSizeMake(_ItemWide, 30);
   }
    
    
        
    NSString *string = self.dataArray[indexPath.row];
    CGSize sizeItem = [string boundingRectWithSize:CGSizeMake(ScreenW - 100, __FLT_MAX__) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    return CGSizeMake(sizeItem.width +30+20, 30);
}
- (void)requestLabelsData {
    NSLog(@"titleString:%@======%@", self.titleString, self.titleId);
//    NSDictionary *paramet = @{};
//    [SCNetwork postWithURLString:BDUrl_s(@"") parameters:paramet success:^(NSDictionary *dic) {
//
//    } failure:^(NSError *error) {
//        [SVProgressHUD showWithStatus:@"检查网络问题"];
//        [SVProgressHUD dismissWithDelay:0.7];
//    }];
    
}
- (void)titleBtnClicked:(UIButton *)sender {
    if (sender != self.selectedBtn) {
        self.selectedBtn.selected = NO;
        sender.selected = YES;
        self.selectedBtn = sender;
        self.titleString = sender.currentTitle;
        
        [self requestLabelsData];
    }else {
        self.selectedBtn.selected = YES;
    }
}

- (void)updateTopViewFrame {
    if (self.tempArray.count > 0) {
//        _topView.frame = CGRectMake(0, LK_iPhoneXNavHeight, ScreenW, 50);
        _addView.frame = CGRectMake(0,  t_hegiht, ScreenW, 50);
        _myCollectionView.frame = CGRectMake(100, 50 + t_hegiht, ScreenW-100, ScreenH  - 50 - t_hegiht);
//        _leftView.frame = CGRectMake(0, LK_iPhoneXNavHeight + 50 + t_hegiht, 100, ScreenH - LK_iPhoneXNavHeight - t_hegiht);
        _typeTableView.frame = CGRectMake(0,  50 + t_hegiht, 100, ScreenH - t_hegiht);
        

//        _tagView.frame = CGRectMake(0, 0, ScreenW, 50);
//        [_tagView setTagArray:_tempArray];
//        _tagView.backgroundColor = [UIColor purpleColor];
//        NSLog(@"顶部%@", _tempArray);
        
        
        
        _topCollectionView.frame = CGRectMake(0, 0, ScreenW, t_hegiht);
        _topCollectionView.backgroundColor = [UIColor whiteColor];
        _totalWide = 0;
        [_topCollectionView reloadData];
        
    }
}
- (void)updatedDeleteTopViewState {
    _addView.frame = CGRectMake(0, 0, ScreenW, 50);
    _myCollectionView.frame = CGRectMake(100, 50, ScreenW-100, ScreenH - 50);
//    _leftView.frame = CGRectMake(0, LK_iPhoneXNavHeight + 50, 100, ScreenH - LK_iPhoneXNavHeight);
    _typeTableView.frame = CGRectMake(0, 50, 100, ScreenH - 50);
    _topCollectionView.frame = CGRectMake(0, 0, ScreenW, 0);
}
- (void)requestLabelsOfLevelTwoData {
    NSLog(@"_fatherId:%@", _fatherId);
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"labelId" : _fatherId};
    [SCNetwork postWithURLString:BDUrl_s(@"label/getLabelByRootNodeId") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSArray *labelsArray = dic[@"labels"];
            for (NSDictionary *labelsDic in labelsArray) {
                LabelsLevelOneModel *model = [[LabelsLevelOneModel alloc] init];
                [model setValuesForKeysWithDictionary:labelsDic];
                [self.myDataArray addObject:model];
                NSLog(@"%@", [NSString stringWithFormat:@"%@", model.Id]);
            }
            [self.typeTableView reloadData];
//            [self makeLeftPartOfBtnlayout];
            [self requestLabelsData];
            NSArray *arraythree = dic[@"childrenLabels"];
            for (NSDictionary *threeList in arraythree) {
                LabelsLevelThreeModel *model = [[LabelsLevelThreeModel alloc] init];
                [model setValuesForKeysWithDictionary:threeList];
                [self.dataArrayThree  addObject:model];
            }
            [self.myCollectionView reloadData];
            
            NSArray *arrayFour = dic[@"userLabels"];
            for (NSDictionary *fourList in arrayFour) {
                LabelsLevelFourModel *model = [[LabelsLevelFourModel alloc] init];
                [model setValuesForKeysWithDictionary:fourList];
                [self.dataFour addObject:model.labelName];
            }
            self.tempArray = self.dataFour;
            [self updateTopViewFrame];
        }

    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}
- (void)requestLabelsOfLeveThreeData {
    NSLog(@"%@", _titleId);
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"labelId" : _titleId};
    [SCNetwork postWithURLString:BDUrl_s(@"label/getChildrenLabelsByParentId") parameters:paramet success:^(NSDictionary *dic) {
        [self.dataArrayThree removeAllObjects];
        if ([dic[@"code"] integerValue] > 0) {
            NSArray *array = dic[@"labels"];
            for (NSDictionary *listDic in array) {
                LabelsLevelThreeModel *modelTh = [[LabelsLevelThreeModel alloc] init];
                [modelTh setValuesForKeysWithDictionary:listDic];
                [self.dataArrayThree addObject:modelTh];
            }
            [self.myCollectionView reloadData];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}

- (void)requestAddAndDeleteData {
    NSMutableArray *arrM = [NSMutableArray array];
    for (int i = 0; i<_tempArray.count; i++) {
        UploadLabelsModel *model = [[UploadLabelsModel alloc] init];
        model.rootNodeId = [_fatherId integerValue];
        model.labelName = _tempArray[i];
        [arrM addObject:model];
    }
    NSString *jsonStr = [arrM modelToJSONString];
    NSLog(@"%@", jsonStr);
    NSLog(@"%@", BD_MD5Sign.md5String);
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"labelJSONArray" : jsonStr, @"rootNodeId" : _fatherId};
    [SCNetwork postWithURLString:BDUrl_s(@"label/setHobbyLabel") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"%@", dic[@"result"]);
            [self.navigationController popViewControllerAnimated:YES];
        }

    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}















@end
