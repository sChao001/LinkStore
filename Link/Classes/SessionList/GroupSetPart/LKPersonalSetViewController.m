//
//  LKPersonalSetViewController.m
//  Link
//
//  Created by Surdot on 2018/5/25.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "LKPersonalSetViewController.h"
#import "LKPersonalSetCell.h"
#import "CountriesListController.h"
#import "SetSessionPrivacyController.h"

@interface LKPersonalSetViewController () <UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *accountLb;
@property (nonatomic, strong) UILabel *signLb;
@property (nonatomic, strong) NSMutableArray *titleArr;
@property (nonatomic) NSInteger indexPathRow;
@property (nonatomic) NSInteger indexSection;
@property (nonatomic, strong) UIButton *deleteBtn;

@end

@implementation LKPersonalSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(239, 239, 239);
    [self setCommonLeftBarButtonItem];
    [self creatMyTableView];
    [self requestData];
    [self initCreatData];
    self.indexPathRow = -1;
    NSLog(@"targetId%@", _useridStr);
    self.title = @"聊天信息";
    [self creatMyAlertlabel];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_myTableView reloadData];
//    NSLog(@"555%@", [UserDefault objectForKey:@"likeZH"]);
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
- (void)creatMyTableView {
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 7, ScreenW, kWidthScale(89))];
    _topView.backgroundColor  = [UIColor whiteColor];
    [self.view addSubview:_topView];
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kWidthScale(89) + 19, ScreenW, ScreenH - kWidthScale(89)-19-LK_TabbarSafeBottomMargin-LK_iPhoneXNavHeight-70) style:UITableViewStyleGrouped];
    [self.view addSubview:_myTableView];
//    _myTableView.backgroundColor = [UIColor cyanColor];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [_myTableView registerClass:[LKPersonalSetCell class] forCellReuseIdentifier:@"cell"];
    _myTableView.bounces = NO;
    
//    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 70)];
//    myView.backgroundColor = [UIColor orangeColor];
//    _deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 15, ScreenW-30, 45)];
//    [myView addSubview:_deleteBtn];
//    _myTableView.tableFooterView = myView;
//    _deleteBtn.backgroundColor = [UIColor redColor];
    
    _deleteBtn = [[UIButton alloc] init];
    [self.view addSubview:_deleteBtn];
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.myTableView.mas_bottom).equalTo(10);
        make.left.equalTo(15);
        make.right.equalTo(-15);
        make.height.equalTo(45);
    }];
    _deleteBtn.backgroundColor = [UIColor redColor];
    [_deleteBtn setTitle:@"删除好友" forState:UIControlStateNormal];
    _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [_deleteBtn addTarget:self action:@selector(deleteBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    _iconImg = [[UIImageView alloc] init];
    [self.topView addSubview:_iconImg];
    [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kWidthScale(22));
        make.centerY.equalTo(0);
        make.size.equalTo(CGSizeMake(kWidthScale(65), kWidthScale(65)));
    }];
    _iconImg.backgroundColor = [UIColor brownColor];
    
    _nameLb = [[UILabel alloc] init];
    [_topView addSubview:_nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImg.mas_top).equalTo(7);
        make.left.equalTo(self.iconImg.mas_right).equalTo(14);
//        make.height.equalTo(kWidthScale(16));
        make.width.greaterThanOrEqualTo(10);
    }];
//    _nameLb.backgroundColor = [UIColor brownColor];
    _nameLb.text = @"我自横刀向天笑";
    _nameLb.font = [UIFont systemFontOfSize:kWidthScale(16)];
    _nameLb.textColor = RGB(0, 0, 0);
    
    _accountLb = [[UILabel alloc] init];
    [_topView addSubview:_accountLb];
    [_accountLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLb.mas_left);
        make.top.equalTo(self.nameLb.mas_bottom).equalTo(5);
        make.width.greaterThanOrEqualTo(10);
    }];
    _accountLb.font = [UIFont systemFontOfSize:kWidthScale(12)];
    _accountLb.textColor = RGB(113, 112, 113);
    _accountLb.text = @"Link号：1353900283";
}
- (void)initCreatData {
    self.titleArr = [NSMutableArray arrayWithCapacity:0];
//    NSArray *arrayOne = @[@"好友加密", @"设置聊天背景", @"自动翻译"];
    NSArray *arrayOne = @[@"设置聊天背景", @"自动翻译"];
    NSArray *arrayTwo = @[@"消息免打扰", @"消息置顶"];
    [_titleArr addObject:arrayOne];
    [_titleArr addObject:arrayTwo];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%lu", (unsigned long)[_titleArr[section]count]);
    return [_titleArr[section]count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LKPersonalSetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLb.text = _titleArr[indexPath.section][indexPath.row];
    
    cell.subTitleLb.hidden = YES;
    NSLog(@"%@", [UserDefault objectForKey:@"Countries"]);
    NSLog(@"%@", [UserDefault objectForKey:@"likeZH"]);
//    if (indexPath.section == 0) {
//        cell.switchBtn.hidden = YES;
//    }
//    if (indexPath.section == 0 && indexPath.row == 1) {
//        cell.subTitleLb.hidden = NO;
//        cell.subTitleLb.text = [UserDefault objectForKey:[NSString stringWithFormat:@"POfBackgrounds%@_%@", _useridStr, [UserInfo sharedInstance].getUserid]];
//    }
//    if (indexPath.section == 0 && indexPath.row == 2) {
////        cell.subTitleLb.hidden = YES;
//        cell.subTitleLb.hidden = NO;
//        cell.subTitleLb.text = [UserDefault objectForKey:@"Countries"];
//    }
//    if (indexPath.section == 0 && indexPath.row == 0) {
//        UILabel *label = [[UILabel alloc] init];
//        [cell.contentView addSubview:label];
//        [label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(-15);
//            make.width.greaterThanOrEqualTo(10);
//            make.centerY.equalTo(0);
//        }];
//        label.font = [UIFont systemFontOfSize:12];
//        label.textColor = RGB(113, 112, 113);
//        label.text = @"";
////        if ([UserDefault objectForKey:@"setedPassword"]) {
////            label.text = [UserDefault objectForKey:@"setedPassword"];
////        }
//        if ([CommentTool isBlankString:[UserDefault objectForKey:[NSString stringWithFormat:@"setedPassword_%@_%@", self.useridStr, [UserInfo sharedInstance].getUserid]]]) {
//            label.hidden = YES;
//        }else {
//            label.hidden = NO;
//            label.text = [UserDefault objectForKey:[NSString stringWithFormat:@"setedPassword_%@_%@", self.useridStr, [UserInfo sharedInstance].getUserid]];
//        }
//    }
    
    if (indexPath.section == 0) {
        cell.switchBtn.hidden = YES;
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        //        cell.subTitleLb.hidden = YES;
        cell.subTitleLb.hidden = NO;
        cell.subTitleLb.text = [UserDefault objectForKey:@"Countries"];
    }
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.subTitleLb.hidden = NO;
        cell.subTitleLb.text = [UserDefault objectForKey:[NSString stringWithFormat:@"POfBackgrounds%@_%@", _useridStr, [UserInfo sharedInstance].getUserid]];
    }

    if (indexPath.section == 1 && indexPath.row == 0) {
        if (![CommentTool isBlankString:[UserDefault objectForKey:[NSString stringWithFormat:@"NoMessage_%@_%@", self.useridStr, [UserInfo sharedInstance].getUserid]]]) {
            cell.switchBtn.selected = YES;
        }else {
            cell.switchBtn.selected = NO;
        }
        
        [cell.switchBtn addTarget:self action:@selector(topSwitchBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        
        if (![CommentTool isBlankString:[UserDefault objectForKey:[NSString stringWithFormat:@"cellIsTop_%@_%@", self.useridStr, [UserInfo sharedInstance].getUserid]]]) {
            cell.switchBtn.selected = YES;
        }else {
            cell.switchBtn.selected = NO;
        }
        [cell.switchBtn addTarget:self action:@selector(bottomSwitchClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    if (indexPath.section == 1) {
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}
- (void)topSwitchBtnClicked:(UIButton *)sender {
    NSLog(@"aaa");
    sender.selected = !sender.selected;
    if (sender.selected) {
        NSLog(@"111");
        [[RCIMClient sharedRCIMClient] setConversationNotificationStatus:ConversationType_PRIVATE targetId:_useridStr isBlocked:YES success:^(RCConversationNotificationStatus nStatus) {
            NSLog(@"%lu", (unsigned long)nStatus);
//            [UserDefault setBool:YES forKey:@"messageStop"];
            [UserDefault setObject:@"messageReceiveNO" forKey:[NSString stringWithFormat:@"NoMessage_%@_%@", self.useridStr, [UserInfo sharedInstance].getUserid]];

        } error:^(RCErrorCode status) {
            NSLog(@"%ld", (long)status);
        }];
        
    }else {
        NSLog(@"222");
        [[RCIMClient sharedRCIMClient] setConversationNotificationStatus:ConversationType_PRIVATE targetId:_useridStr isBlocked:NO success:^(RCConversationNotificationStatus nStatus) {
            NSLog(@"%lu", (unsigned long)nStatus);
            [UserDefault setObject:@"" forKey:[NSString stringWithFormat:@"NoMessage_%@_%@", self.useridStr, [UserInfo sharedInstance].getUserid]];
            
        } error:^(RCErrorCode status) {
            NSLog(@"%ld", (long)status);
        }];
    }
}
- (void)bottomSwitchClicked:(UIButton *)sender {
    NSLog(@"bbb");
    sender.selected = !sender.selected;
    if (sender.selected) {
        NSLog(@"111");
        [[RCIMClient sharedRCIMClient] setConversationToTop:ConversationType_PRIVATE targetId:_useridStr isTop:YES];
        [UserDefault setObject:@"messageTop" forKey:[NSString stringWithFormat:@"cellIsTop_%@_%@", self.useridStr, [UserInfo sharedInstance].getUserid]];
        
    }else {
        NSLog(@"222");
        [[RCIMClient sharedRCIMClient] setConversationToTop:ConversationType_PRIVATE targetId:_useridStr isTop:NO];
        [UserDefault setObject:@"" forKey:[NSString stringWithFormat:@"cellIsTop_%@_%@", self.useridStr, [UserInfo sharedInstance].getUserid]];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}
//section头部视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0)];
    view.backgroundColor = [UIColor clearColor];
    return view ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 13;
}
//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 13)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
//cell点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0 && indexPath.row == 0) {
//        SetSessionPrivacyController *vc = [[SetSessionPrivacyController alloc] init];
//        vc.useridStr = self.useridStr;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//    if (indexPath.section == 0 && indexPath.row == 1) {
//        [self headerBtnClicked:nil];
//    }
//    if (indexPath.section == 0 && indexPath.row == 2) {
//        CountriesListController *vc= [[CountriesListController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self headerBtnClicked:nil];
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        CountriesListController *vc= [[CountriesListController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {
       
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)headerBtnClicked:(UIButton *)sender {
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
//    [_headerBtn setImage:smallImage forState:UIControlStateNormal];
    [UserDefault setObject:@"已设置" forKey:[NSString stringWithFormat:@"POfBackgrounds%@_%@", _useridStr, [UserInfo sharedInstance].getUserid]];
    [UserDefault synchronize];
    
//    [UserDefault setObject:smallImage forKey:@"background"];
//    [UserDefault synchronize];
    
//    NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
//    [defult setObject:image forKey:@"background"];
//    [defult synchronize];
    
    //写入文件
    [UIImagePNGRepresentation(smallImage) writeToFile:path atomically:YES];
    //    [self postImageData:path];
    
    //读取文件
    //    UIImage *photoImg = [UIImage imageWithContentsOfFile:path];
    //    [_headerBtn setBackgroundImage:photoImg forState:(UIControlStateNormal)];
    [self.myTableView reloadData];
    
}
//在本地获取图片路径啊
-(NSString *)getheadPath
{
    NSString* str=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//    NSString* path=[str stringByAppendingPathComponent:@"headImage.png"];
    NSString *path = [str stringByAppendingPathComponent:[NSString stringWithFormat:@"PBG%@_%@.png", _useridStr, [UserInfo sharedInstance].getUserid]];
    
    

    return path;
}
- (void)requestData {
    NSString *jmString = [NSString stringWithFormat:@"%@%@%@", BD_key, BD_secret, [UserInfo sharedInstance].getjmToken];
    NSDictionary *paramet = @{@"userId" : [UserInfo sharedInstance].getUserid, @"selectId" : self.useridStr, @"sign" : jmString.md5String};
    [SCNetwork postWithURLString:BDUrl_s(@"user/getUser") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSDictionary *userDic = dic[@"user"];
            [self.iconImg sd_setImageWithURL:[NSURL URLWithString:BDUrl_(userDic[@"headUrl"])]];
            self.nameLb.text = userDic[@"nickName"];
            self.accountLb.text = [NSString stringWithFormat:@"Link号：%@", userDic[@"account"]];
            
        }
        
        
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}

- (void)deleteBtnClicked {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定删除次好友吗" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionSure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"friendId" : self.useridStr};
        [SCNetwork postWithURLString:BDUrl_s(@"userRelation/deleteFriend") parameters:paramet success:^(NSDictionary *dic) {
            if ([dic[@"code"] integerValue] > 0) {
                [self alertShowWithTitle:dic[@"result"]];
                [[RCIMClient sharedRCIMClient] removeConversation:ConversationType_PRIVATE targetId:self.useridStr];
                [[RCIMClient sharedRCIMClient] clearMessages:ConversationType_PRIVATE targetId:self.useridStr];
                [[RCIMClient sharedRCIMClient] deleteMessages:ConversationType_PRIVATE targetId:self.useridStr success:^{
                    
                    NSLog(@"删除成功");
                } error:^(RCErrorCode status) {
                    NSLog(@"删除失败");
                }];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
            }
            
        } failure:^(NSError *error) {
            [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
            [SVProgressHUD dismissWithDelay:0.7];
        }];
    }];
    UIAlertAction *actionCancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:actionCancle];
    [alertVC addAction:actionSure];
    [self presentViewController:alertVC animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
