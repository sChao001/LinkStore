//
//  EditIdentifyViewController.m
//  Link
//
//  Created by Surdot on 2018/5/29.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "EditIdentifyViewController.h"
#import "EditIdentifyCell.h"
#import "EditDetailInfoController.h"
#import "PersonQRCodeViewController.h"

@interface EditIdentifyViewController ()<UITableViewDelegate, UITableViewDataSource, EditDetailInfoControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIButton *imageBtn;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) NSMutableArray *contentArr;
@property (nonatomic, strong) NSString *infoStr;
@property (nonatomic, strong) NSString *nickNameStr;
@property (nonatomic, strong) NSString *customSign;
@property (nonatomic, strong) UIView *sexBackground;
@property (nonatomic, strong) UIView *sexChooseView;
@property (nonatomic, strong) UIButton *manBtn;
@property (nonatomic, strong) UIButton *womanBtn;
@property (nonatomic, strong) UILabel *manLb;
@property (nonatomic, strong) UILabel *womanLb;
@property (nonatomic, strong) NSString *imageString;
@property (nonatomic, strong) NSString *sexString;
@end

@implementation EditIdentifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(239, 239, 239);
    [self setViewLayout];
    [self makeSexViewLayout];
    [self makeContentInfo];
    [self creatMyAlertlabel];
    self.imageString = @"";
    self.sexString = @"";
    self.nickNameStr = @"";
    self.customSign = @"";
    [self creatMyAlertlabel];
    [self setCommonLeftBarButtonItem];
    [self setMyNavigationBarShowOfImage];
//    self.title = @"编辑身份";
    self.title = @"个人资料";
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_listTableView reloadData];
    
    if (![CommentTool isBlankString:_infoStr] || ![CommentTool isBlankString:_nickNameStr] || ![CommentTool isBlankString:_customSign]) {
        UIImage *image = [UIImage imageNamed:@"y_graySure"];
        UIImage *selectImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:selectImage style:UIBarButtonItemStylePlain target:self action:@selector(sureClickedAndRequest)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
- (void)setViewLayout {
    _topView = [[UIView alloc] initWithFrame:CGRectMake(5, LK_iPhoneXNavHeight + 7, ScreenW - 10, kWidthScale(93))];
    [self.view addSubview:_topView];
    _topView.backgroundColor = [UIColor whiteColor];
    
    _titleLb = [[UILabel alloc] init];
    [_topView addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(17);
        make.centerY.equalTo(0);
        make.width.greaterThanOrEqualTo(10);
    }];
    _titleLb.text = @"更换头像";
    _titleLb.textColor = RGB(61, 58, 57);
    _titleLb.font = [UIFont systemFontOfSize:kWidthScale(15)];
    
    _imageBtn = [[UIButton alloc] init];
    [_topView addSubview:_imageBtn];
    [_imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-11);
        make.size.equalTo(CGSizeMake(kWidthScale(66), kWidthScale(66)));
        make.centerY.equalTo(0);
    }];
//    [_imageBtn setImage:[UIImage imageNamed:@"headerImg"] forState:UIControlStateNormal];
    [_imageBtn sd_setImageWithURL:[NSURL URLWithString:BDUrl_(_headUrl)] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"headerImg"]];
    [_imageBtn addTarget:self action:@selector(imageBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, LK_iPhoneXNavHeight + 7 + kWidthScale(93) , ScreenW - 10, ScreenH - (LK_iPhoneXNavHeight + 7 + kWidthScale(93)))];
    [self.view addSubview:_listTableView];
    _listTableView.backgroundColor = RGB(239, 239, 239);
    [_listTableView registerClass:[EditIdentifyCell class] forCellReuseIdentifier:@"cell"];
    _listTableView.bounces = NO;
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    _listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}
- (void)makeSexViewLayout {
    _sexBackground = [[UIView alloc] init];
    [self.view addSubview:_sexBackground];
    _sexBackground.backgroundColor = RGBA(98, 98, 98, 0.6);
    _sexBackground.frame = CGRectMake(0, LK_iPhoneXNavHeight, ScreenW, ScreenH-LK_iPhoneXNavHeight- LK_TabbarSafeBottomMargin);
    _sexBackground.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    [self.sexBackground addGestureRecognizer:tap];
    
    _sexChooseView = [[UIView alloc] init];
    [_sexBackground addSubview:_sexChooseView];
    [_sexChooseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(0);
        make.size.equalTo(CGSizeMake(kWidthScale(200), kWidthScale(150)));
    }];
    _sexChooseView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tapChooseView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapChooseView)];
    [self.sexChooseView addGestureRecognizer:tapChooseView];
    
    UILabel *titleSex = [[UILabel alloc] init];
    [_sexChooseView addSubview:titleSex];
    [titleSex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.top.equalTo(20);
        make.width.greaterThanOrEqualTo(35);
        make.height.equalTo(15);
    }];
    titleSex.textColor = RGB(44, 44, 44);
    titleSex.font = [UIFont systemFontOfSize:kWidthScale(20)];
    titleSex.text = @"性别";
    
    _manLb = [[UILabel alloc] init];
    [_sexChooseView addSubview:_manLb];
    [_manLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(20);
        make.top.equalTo(titleSex.mas_bottom).equalTo(20);
        make.width.greaterThanOrEqualTo(10);
    }];
    _manLb.font = [UIFont systemFontOfSize:kWidthScale(16)];
    _manLb.textColor = RGB(88, 88, 88);
    _manLb.text = @"男";
//    manLb.backgroundColor = [UIColor redColor];
    
    UIView *lineView = [[UIView alloc] init];
    [_sexChooseView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.height.equalTo(1);
        make.right.equalTo(-15);
        make.top.equalTo(self.manLb.mas_bottom).equalTo(10);
    }];
    lineView.backgroundColor = RGB(235, 235, 235);
    
    
    _womanLb = [[UILabel alloc] init];
    [_sexChooseView addSubview:_womanLb];
    [_womanLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).equalTo(10);
        make.left.equalTo(20);
        make.width.greaterThanOrEqualTo(10);
    }];
    _womanLb.text = @"女";
    _womanLb.textColor = RGB(88, 88, 88);
    _womanLb.font = [UIFont systemFontOfSize:kWidthScale(16)];
//    womanLb.backgroundColor = [UIColor orangeColor];
    
    _manBtn = [[RImagButton alloc] init];
    [_sexChooseView addSubview:_manBtn];
    [_manBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-20);
        make.bottom.equalTo(lineView.mas_top).equalTo(-10);
        make.size.equalTo(CGSizeMake(kWidthScale(20), kWidthScale(20)));
    }];
//    manBtn.backgroundColor = [UIColor cyanColor];
    _manBtn.layer.cornerRadius = kWidthScale(10);
    _manBtn.layer.masksToBounds = YES;
    _manBtn.layer.borderWidth = 1;
    _manBtn.layer.borderColor = RGB(162, 162, 162).CGColor;
    [_manBtn addTarget:self action:@selector(chooseMan) forControlEvents:UIControlEventTouchUpInside];
    if ([self.manLb.text isEqualToString:self.sex]) {//
        _manBtn.backgroundColor = RGB(31, 161, 21);
        _manBtn.layer.borderColor = RGB(31, 161, 21).CGColor;
    }
    
    _womanBtn = [[UIButton alloc] init];
    [_sexChooseView addSubview:_womanBtn];
    [_womanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-20);
        make.size.equalTo(CGSizeMake(kWidthScale(20), kWidthScale(20)));
        make.top.equalTo(lineView.mas_bottom).equalTo(10);
    }];
//    womanBtn.backgroundColor = [UIColor cyanColor];
    _womanBtn.layer.cornerRadius = kWidthScale(10);
    _womanBtn.layer.masksToBounds = YES;
    _womanBtn.layer.borderColor = RGB(162, 162, 162).CGColor;
    _womanBtn.layer.borderWidth = 1;
    [_womanBtn addTarget:self action:@selector(chooseWoman) forControlEvents:UIControlEventTouchUpInside];
    if ([self.womanLb.text isEqualToString:self.sex]) {//
        _womanBtn.backgroundColor = RGB(31, 161, 21);
        _womanBtn.layer.borderColor = RGB(31, 161, 21).CGColor;
    }
}
- (void)makeContentInfo {
    self.contentArr = [NSMutableArray arrayWithCapacity:0];
    NSArray *arrOne = @[@"LINK号", @"昵称", @"性别"];
    NSArray *arrTwo = @[@"地区", @"二维码名片", @"个性签名"];
    [_contentArr addObject:arrOne];
    [_contentArr addObject:arrTwo];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_contentArr[section]count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EditIdentifyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLb.text = _contentArr[indexPath.section][indexPath.row];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
//        cell.detailLb.text = [UserDefault objectForKey:@"pubLINK"];
//        cell.detailLb.text = self.infoStr;
        cell.detailLb.text = self.account;
        if (![CommentTool isBlankString:self.infoStr]) {
            cell.detailLb.text = self.infoStr;
        }
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        cell.detailLb.text = self.nickName;
        if (![CommentTool isBlankString:self.nickNameStr]) {
            cell.detailLb.text = self.nickNameStr;
        }
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
//        cell.detailLb.text = [UserDefault objectForKey:@"mySex"];
        cell.detailLb.text = self.sex;
        if (![CommentTool isBlankString:self.sexString]) {
            cell.detailLb.text = self.sexString;
        }
    }
    if (indexPath.section == 1 && indexPath.row == 2) {
        cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);
        cell.detailLb.text = self.signature;
        if (![CommentTool isBlankString:self.customSign]) {
            cell.detailLb.text = self.customSign;
        }
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 13;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 13)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0) {
//        EditDetailInfoController *vc = [[EditDetailInfoController alloc] init];
//        vc.myString = @"LINK号（只能设置一次）";
//        vc.delegate = self;
//        [self.navigationController pushViewController:vc animated:YES];
        [self alertShowWithTitle:@"LINK号创建后不可更改"];
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        EditDetailInfoController *vc = [[EditDetailInfoController alloc] init];
        vc.delegate = self;
        vc.myString = @"昵称";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 1 && indexPath.row == 2) {
        EditDetailInfoController *vc = [[EditDetailInfoController alloc] init];
        vc.delegate = self;
        vc.myString = @"签名";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        _sexBackground.hidden = NO;
        if ([self.manLb.text isEqualToString:self.sexString]) {
            _manBtn.backgroundColor = RGB(31, 161, 21);
            _manBtn.layer.borderColor = RGB(31, 161, 21).CGColor;
            _womanBtn.layer.borderColor = RGB(162, 162, 162).CGColor;
            _womanBtn.backgroundColor = [UIColor whiteColor];
        }
        if ([self.womanLb.text isEqualToString:self.sexString]) {
            _womanBtn.backgroundColor = RGB(31, 161, 21);
            _womanBtn.layer.borderColor = RGB(31, 161, 21).CGColor;
            _manBtn.backgroundColor = [UIColor whiteColor];
            _manBtn.layer.borderColor = RGB(162, 162, 162).CGColor;
        }
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        PersonQRCodeViewController *vc = [[PersonQRCodeViewController alloc] init];
        vc.userId = _userId;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)showText:(NSString *)text {
    self.infoStr = text;
}
- (void)showNickName:(NSString *)nameStr {
    self.nickNameStr = nameStr;
}
- (void)showCustomSign:(NSString *)signStr {
    self.customSign = signStr;
}
- (void)sureClickedAndRequest {
    NSString *path = [self getheadPath];
    UIImage *image = _imageBtn.currentImage;
    //    [self zipNSDataWithImage:image];
    //写入文件
    [UIImagePNGRepresentation(image) writeToFile:path atomically:YES];
    
    UIImage *phoneImg=[UIImage imageWithContentsOfFile:path];
    NSData *imageData = UIImageJPEGRepresentation(phoneImg, 0.5);
    self.imageString = [imageData base64EncodedString];
    NSString *sexNumber;
    if ([_sexString isEqualToString:@"男"]) {
        sexNumber = @"1";
    }else {
        sexNumber = @"0";
    }
    NSLog(@"%@", sexNumber);
    
//    NSDictionary *paramet = @{@"userId" : _userId, @"sex" : @"", @"address" : @"", @"signature" :@"", @"nickName" : _nickNameStr, @"image" : _imageString};
//    NSLog(@"%@", _userId);
    NSLog(@"++%@", _imageString);
    NSString *jmString = [NSString stringWithFormat:@"%@%@%@", BD_key, BD_secret, [UserInfo sharedInstance].getjmToken];
    NSDictionary *paramet = @{@"userId" : [UserInfo sharedInstance].getUserid, @"id" : _userId, @"sex" : sexNumber, @"address" : @"", @"signature" : _customSign, @"nickName" : _nickNameStr, @"image" : _imageString, @"userId" : [UserInfo sharedInstance].getUserid, @"sign" : jmString.md5String};
//    if (paramet != nil) {
//        NSLog(@"怎么回事啊");
//    }
    [SCNetwork postWithURLString:BDUrl_s(@"user/modify") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"dic:%@", dic);
            [self alertShowWithTitle:@"修改成功"];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
    
    
    
}
- (void)imageBtnClicked {
    UIAlertController *alertSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *fromPhotoAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        imagePicker.allowsEditing = YES;
        
        imagePicker.delegate = self;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction* fromCameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault                                                             handler:^(UIAlertAction * action) {
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            
        {
            
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            
            imagePicker.delegate = self;
            
            //            imagePicker.allowsEditing = YES;
            
            imagePicker.allowsEditing = YES;
            
            imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        }
    }];
    [alertSheet addAction:cancelAction];
    
    [alertSheet addAction:fromCameraAction];
    
    [alertSheet addAction:fromPhotoAction];
    [self presentViewController:alertSheet animated:YES completion:nil];
}
//用户选择完毕 头像的选择器的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //头像
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    [self performSelector:@selector(saveImage:) withObject:img afterDelay:0.5];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"用户取消了");
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//裁剪保存头像图片
- (void)saveImage:(UIImage *)image{
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSError *error;
    NSString *path = [self getheadPath];
    BOOL success = [manager fileExistsAtPath:path];
    if (success) {
        success = [manager removeItemAtPath:path error:&error];
    }
    //将图片设置成200*200压缩图片
    UIImage *smallImage = [CommentTool scallImage:image toSize:CGSizeMake(200, 200)];
    //刷新并展示按钮上的头像
    [_imageBtn setImage:smallImage forState:UIControlStateNormal];
    if (image) {
        UIImage *imageIcon = [UIImage imageNamed:@"y_graySure"];
        UIImage *selectImage = [imageIcon imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:selectImage style:UIBarButtonItemStylePlain target:self action:@selector(sureClickedAndRequest)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    
    
    //写入文件
    [UIImagePNGRepresentation(smallImage) writeToFile:path atomically:YES];
    //    [self postImageData:path];
    
    //读取文件
    //    UIImage *photoImg = [UIImage imageWithContentsOfFile:path];
    //    [_headerBtn setBackgroundImage:photoImg forState:(UIControlStateNormal)];
    
}
//再本地获取图片路径啊
-(NSString *)getheadPath
{
    NSString* str=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* path=[str stringByAppendingPathComponent:@"headImage.png"];
    return path;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)handleTap {
    _sexBackground.hidden = YES;
}
- (void)handleTapChooseView {
    
}
- (void)chooseMan {
//    [UserDefault setObject:@"男" forKey:@"mySex"];
    self.sexString = @"男";
    _sexBackground.hidden = YES;
    [_listTableView reloadData];
    UIImage *image = [UIImage imageNamed:@"y_graySure"];
    UIImage *selectImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:selectImage style:UIBarButtonItemStylePlain target:self action:@selector(sureClickedAndRequest)];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)chooseWoman {
//    [UserDefault setObject:@"女" forKey:@"mySex"];
    self.sexString = @"女";
    _sexBackground.hidden = YES;
    [_listTableView reloadData];
    UIImage *image = [UIImage imageNamed:@"y_graySure"];
    UIImage *selectImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:selectImage style:UIBarButtonItemStylePlain target:self action:@selector(sureClickedAndRequest)];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)changeUserInfomation {
    
}
@end
