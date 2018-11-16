//
//  LKGroupMakeViewController.m
//  Link
//
//  Created by Surdot on 2018/5/23.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "LKGroupMakeViewController.h"
#import "TopViewController.h"
#import "GroupInfoCell.h"
#import "TopCollectionController.h"
#import "GroupMembersModel.h"
#import "ChangeGroupNameController.h"
#import "CountriesListController.h"
#import "SetSessionPrivacyController.h"
#import "GroupQRCodeViewController.h"
#import "mmmmmViewController.h"
#import "PersonIntroViewController.h"
#import "GroupMemberAddController.h"

#define mainHeight     [[UIScreen mainScreen] bounds].size.height
#define mainWidth      [[UIScreen mainScreen] bounds].size.width

@interface LKGroupMakeViewController () <UITableViewDataSource,UITableViewDelegate,TopViewControllerDelagate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) TopViewController *topview;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSString *groupName;
@property (nonatomic, strong) UITableView *showTable;
@end

@implementation LKGroupMakeViewController

{
//    UITableView *_showTable;
//    TopViewController *_topview;
    UIButton *_sendBtn;
    NSMutableArray *_groupAll;
    NSMutableArray *_arrPer;
    BOOL isDel;
    TopCollectionController *_myCollectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initMyView];
    [self initCreateData];
    [self requestDataOfMembers];
    [self setCommonLeftBarButtonItem];
    [self creatMyAlertlabel];
    NSLog(@"%@", _groupIdStr);

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestDataOfMembers];
    [self requestGroupData];
}
///**
// * 设置左侧按钮
// */
//-(void)setCommonLeftBarButtonItem{
//    UIImage *tempImage = [UIImage imageNamed:@"back"];
//    UIImage *selectedImage = [tempImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//防止系统渲染
//    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:selectedImage style:UIBarButtonItemStylePlain target:self action:@selector(leftBarItemBack)];
//}
//
///**
// * 返回按钮点击事件，子类可重写
// */
//- (void)leftBarItemBack {
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
//    [self.navigationController popViewControllerAnimated:YES];
//}
-(void)initCreateData
{
    _groupAll=[NSMutableArray new];
    _arrPer=[NSMutableArray new];
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    
    NSArray *arr1=@[@"群聊名称",@"群二维码",@"设置聊天背景"];
    NSArray *arr2=@[@"自动翻译", @"密码设置"];
//    NSArray *arr4=@[@""];
    NSArray *arr3=@[@"置顶聊天", @"消息免打扰"];
    [_groupAll addObject:arr1];
    [_groupAll addObject:arr2];
//    [_groupAll addObject:arr4];
    [_groupAll addObject:arr3];

}
- (void)requestDataOfMembers {
    NSString *jmString = [NSString stringWithFormat:@"%@%@%@", BD_key, BD_secret, [UserInfo sharedInstance].getjmToken];
    NSDictionary *paramet = @{@"groupId" : _groupIdStr, @"userId" : [UserInfo sharedInstance].getUserid, @"sign" : jmString.md5String};
    [SCNetwork postWithURLString:BDUrl_s(@"groupUser/get") parameters:paramet success:^(NSDictionary *dic) {
        [self.dataArray removeAllObjects];
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"请求成功dic:%@", dic);
            NSArray *usesArr = dic[@"users"];
            NSLog(@"%@", usesArr);
            for (NSDictionary *listAic in usesArr) {
                GroupMembersModel *model = [[GroupMembersModel alloc] init];
                [model setValuesForKeysWithDictionary:listAic];
                [self.dataArray addObject:model];
                [self.topview addSomeOne:self.dataArray];
            }
            self.topview.signStr = @"1";
            NSLog(@"%lu", (unsigned long)self.dataArray.count);
            [self setTopViewFrame:self.dataArray];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
        [SVProgressHUD dismissWithDelay:0.8];
    }];
}
// 设置topview的高度变化
-(void)setTopViewFrame:(NSArray*)allP
{
    int lie=0;
    if([UIScreen mainScreen].bounds.size.width>320)
    {
        lie=5;
    }else
    {
        lie=4;
    }
    int Allcount = (int)allP.count + 1;
    int line=Allcount/lie;
    if(Allcount%lie>0){
        line++;
    }
    
    _topview.view.frame=CGRectMake(0, 0, mainWidth, line*kWidthScale(126));
    _showTable.tableHeaderView=_topview.view;
    
}


-(void)initMyView
{
    self.title=@"群资料";
    _showTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainWidth, mainHeight - LK_iPhoneXNavHeight)];
    _showTable.delegate=self;
    _showTable.dataSource=self;
    _showTable.backgroundColor =RGB(237, 237, 237);
    _showTable.bounces = NO;
    [self.view addSubview:_showTable];
    
    _topview=[[TopViewController alloc]initWithNibName:@"TopViewController" bundle:nil];
    _topview.delagate=self;
    _topview.view.frame=CGRectMake(0, 0, mainWidth, kWidthScale(126));
    _topview.isGroupM=YES;
    _showTable.tableHeaderView=_topview.view;
    _showTable.showsVerticalScrollIndicator = NO;
    
    UIView *txtfootview=[[UIView alloc]init];
    txtfootview.frame=CGRectMake(0, 0, mainWidth,100);
    txtfootview.backgroundColor=[UIColor clearColor];
    UIButton *btnRegis=[[UIButton alloc]initWithFrame:CGRectMake(10, 40,mainWidth-20, 44)];
    UIImage *buttonImageRegis=[UIImage imageNamed:@"deletebtn"];
    UIImage *stretchableRegister=[buttonImageRegis stretchableImageWithLeftCapWidth:10 topCapHeight:0];
    [btnRegis.layer setMasksToBounds:YES];
    [btnRegis.layer setCornerRadius:3];
    [btnRegis setBackgroundImage:stretchableRegister forState:UIControlStateNormal];
    btnRegis.titleLabel.font = [UIFont fontWithName:@"Courier-Bold" size:19.0];
    [btnRegis setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [btnRegis setTitle:@"删除并退出" forState:0];
    [btnRegis setTitleColor:[UIColor whiteColor] forState:0];
    _sendBtn=btnRegis;
    [txtfootview addSubview:_sendBtn];
    _showTable.tableFooterView=txtfootview;
    [_sendBtn addTarget:self action:@selector(deleteGroupClicked) forControlEvents:UIControlEventTouchUpInside];
}
//群成员退出群
- (void)deleteGroupClicked {
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出群聊吗" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionSure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [SVProgressHUD show];
        NSString *jmString = [NSString stringWithFormat:@"%@%@%@", BD_key, BD_secret, [UserInfo sharedInstance].getjmToken];
        NSDictionary *paramet = @{@"userId" : [UserInfo sharedInstance].getUserid, @"groupId" : self.groupIdStr, @"nickName" : [UserInfo sharedInstance].getNickName, @"sign" : jmString.md5String};
        [SCNetwork postWithURLString:BDUrl_s(@"groupUser/quit") parameters:paramet success:^(NSDictionary *dic) {
            if ([dic[@"code"] integerValue] > 0) {
                NSLog(@"dic:%@", dic);
                [[RCIMClient sharedRCIMClient] removeConversation:ConversationType_GROUP targetId:self.groupIdStr];
                [[RCIMClient sharedRCIMClient] clearMessages:ConversationType_GROUP targetId:self.groupIdStr];
                [[RCIMClient sharedRCIMClient] deleteMessages:ConversationType_GROUP targetId:self.groupIdStr success:^{
                    
                    NSLog(@"删除成功");
                } error:^(RCErrorCode status) {
                    NSLog(@"删除失败");
                }];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                
                [SVProgressHUD dismiss];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
            [SVProgressHUD dismissWithDelay:0.7];
        }];
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertVc addAction:actionSure];
    [alertVc addAction:cancleAction];
    [self presentViewController:alertVc animated:YES completion:nil];
    
    
}

#pragma  mark topview delagate 邀请加群;
- (void)cellOfItemClicked:(GroupMembersModel *)model {
    
//    vc.status = _status;
    [self requestPersonInfoData:[NSString stringWithFormat:@"%@", model.ID] contentList:^(NSDictionary *listDic, NSNumber *num) {
        PersonIntroViewController *vc = [[PersonIntroViewController alloc] init];
        vc.headerStr = model.headUrl;
        vc.naameStr = model.nickName;
        vc.friendId = [NSString stringWithFormat:@"%@", model.ID];
        vc.accountStr = model.account;
        vc.status = num;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
}
-(void)addBtnClick
{
    GroupMemberAddController *vc = [[GroupMemberAddController alloc] init];
    vc.targetId = _groupIdStr;
    vc.targetName = _groupName;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma  mark delagate 点击进入编辑模式
-(void)subBtnClick
{
    if(isDel==NO)
    {
        [_topview isInputDelMoudle:YES];
        isDel=YES;
    }else
    {
        [_topview isInputDelMoudle:NO];
        isDel=NO;
    }
}


#pragma  mark  delagate  踢出群
-(void)delDataWithStr:(PersonModel*)person
{
    
    NSLog(@"删除的用户--%@",person.friendId);
    [_topview delOneTximg:person];
    [_arrPer removeObject:person];
    [self setTopViewFrame:_arrPer];
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _groupAll.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_groupAll[section]count] ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 13;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 5)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *idfCell=@"grouptopcell";
    GroupInfoCell *topcell=(GroupInfoCell*)[tableView dequeueReusableCellWithIdentifier:idfCell];
    if(topcell==nil)
    {
        topcell=[[[NSBundle mainBundle]loadNibNamed:@"GroupInfoCell" owner:self options:nil] lastObject];
    }
    topcell.titleShow.text=_groupAll[indexPath.section][indexPath.row];
    topcell.choseBtn.hidden = YES;
    topcell.switchClickimg.hidden=YES;

    topcell.nameShow.hidden=YES;

    if(indexPath.section==0&&indexPath.row==0)//名字标签的显示
    {
        topcell.nameShow.hidden=NO;
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        UIImageView *image = [[UIImageView alloc] init];
        [topcell addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-15);
            make.size.equalTo(CGSizeMake(20, 20));
            make.centerY.equalTo(0);
        }];
        image.image = [UIImage imageNamed:@"w_qr"];
    }
    
//    if(indexPath.section==0||indexPath.section==2)//此行要显示点击
//    {
//        topcell.clickimg.hidden=NO;
//    }else
//    {
//        topcell.clickimg.hidden=YES;
//    }
    topcell.clickimg.hidden=YES;
//    if(indexPath.section==2)//要显示开关按钮
//    {
//        topcell.choseBtn.hidden=NO;
//
//    }
//    else{
//        topcell.switchClickimg.hidden=YES;
//    }
    
    //以上控制显示和不显示的控件
    if(indexPath.section==0&&indexPath.row==0)
    {
        topcell.nameShow.text= self.groupName;
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        topcell.nameShow.hidden = NO;
        topcell.nameShow.text = [UserDefault objectForKey:[NSString stringWithFormat:@"GOfBackgrounds%@_%@", _groupIdStr, [UserInfo sharedInstance].getUserid]];
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        topcell.nameShow.hidden=NO;
        topcell.nameShow.text = [UserDefault objectForKey:@"Countries"];
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        topcell.nameShow.text = @"";
        topcell.nameShow.hidden = NO;
        topcell.nameShow.text = [UserDefault objectForKey:[NSString stringWithFormat:@"Mgroup:%@_%@", self.groupIdStr, [UserInfo sharedInstance].getUserid]];
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        topcell.choseBtn.hidden=NO;
        if (![CommentTool isBlankString:[UserDefault objectForKey:[NSString stringWithFormat:@"cellIsTopOfGroup_%@_%@", self.groupIdStr, [UserInfo sharedInstance].getUserid]]]) {
            topcell.choseBtn.selected = YES;
        }else {
            topcell.choseBtn.selected = NO;
        }
        [topcell.choseBtn addTarget:self action:@selector(topChooseBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (indexPath.section == 2 && indexPath.row == 1) {
        topcell.choseBtn.hidden=NO;
        if (![CommentTool isBlankString:[UserDefault objectForKey:[NSString stringWithFormat:@"NoMessageOfGroup_%@_%@", self.groupIdStr, [UserInfo sharedInstance].getUserid]]]) {
            topcell.choseBtn.selected = YES;
        }else {
            topcell.choseBtn.selected = NO;
        }
        [topcell.choseBtn addTarget:self action:@selector(bottomChooseBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return topcell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0) {
        ChangeGroupNameController *vc = [[ChangeGroupNameController alloc] init];
        vc.groupIdStr = _groupIdStr;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        CountriesListController *vc = [[CountriesListController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        SetSessionPrivacyController *vc = [[SetSessionPrivacyController alloc] init];
        vc.groupSign = [NSString stringWithFormat:@"group:%@", _groupIdStr];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        GroupQRCodeViewController *vc = [[GroupQRCodeViewController alloc] init];
        vc.groupId = _groupIdStr;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        NSLog(@"");
        [self headerBtnClicked:nil];
    }
}
- (void)requestGroupData {
    NSString *jmString = [NSString stringWithFormat:@"%@%@%@", BD_key, BD_secret, [UserInfo sharedInstance].getjmToken];
    NSDictionary *paramet = @{@"groupId" : _groupIdStr, @"userId" : [UserInfo sharedInstance].getUserid, @"sign" : jmString.md5String};
    [SCNetwork postWithURLString:BDUrl_s(@"group/getGroup") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"dic:%@", dic);
            NSDictionary *groupDic = dic[@"group"];
            self.groupName = groupDic[@"name"];
            RCGroup *group = [RCGroup new];
            group.groupName = self.groupName;
            group.portraitUri = BDUrl_(groupDic[@"imageUrl"]);
            [[RCIM sharedRCIM] refreshGroupInfoCache:group withGroupId:self.groupIdStr];

            [self.showTable reloadData];
        }else {
            [SVProgressHUD showWithStatus:dic[@"result"]];
            [SVProgressHUD dismissWithDelay:0.7];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败"];
        [SVProgressHUD dismissWithDelay:0.6];
    }];
}

- (void)topChooseBtnClicked:(UIButton *)sender {
    NSLog(@"gggg");
    sender.selected = !sender.selected;
    if (sender.selected) {
        NSLog(@"111");
        [[RCIMClient sharedRCIMClient] setConversationToTop:ConversationType_GROUP targetId:_groupIdStr isTop:YES];
        [UserDefault setObject:@"messageTop" forKey:[NSString stringWithFormat:@"cellIsTopOfGroup_%@_%@", self.groupIdStr, [UserInfo sharedInstance].getUserid]];
        
    }else {
        NSLog(@"222");
        [[RCIMClient sharedRCIMClient] setConversationToTop:ConversationType_GROUP targetId:_groupIdStr isTop:NO];
        [UserDefault setObject:@"" forKey:[NSString stringWithFormat:@"cellIsTopOfGroup_%@_%@", self.groupIdStr, [UserInfo sharedInstance].getUserid]];
    }
    
}
- (void)bottomChooseBtnClicked:(UIButton *)sender {
    NSLog(@"7777");
    sender.selected = !sender.selected;
    if (sender.selected) {
        NSLog(@"111");
        [[RCIMClient sharedRCIMClient] setConversationNotificationStatus:ConversationType_GROUP targetId:_groupIdStr isBlocked:YES success:^(RCConversationNotificationStatus nStatus) {
            NSLog(@"%lu", (unsigned long)nStatus);
            //            [UserDefault setBool:YES forKey:@"messageStop"];
            [UserDefault setObject:@"messageReceiveNO" forKey:[NSString stringWithFormat:@"NoMessageOfGroup_%@_%@", self.groupIdStr, [UserInfo sharedInstance].getUserid]];
            
        } error:^(RCErrorCode status) {
            NSLog(@"%ld", (long)status);
        }];
        
    }else {
        NSLog(@"222");
        [[RCIMClient sharedRCIMClient] setConversationNotificationStatus:ConversationType_GROUP targetId:_groupIdStr isBlocked:NO success:^(RCConversationNotificationStatus nStatus) {
            NSLog(@"%lu", (unsigned long)nStatus);
            [UserDefault setObject:@"" forKey:[NSString stringWithFormat:@"NoMessageOfGroup_%@_%@", self.groupIdStr, [UserInfo sharedInstance].getUserid]];
            
        } error:^(RCErrorCode status) {
            NSLog(@"%ld", (long)status);
        }];
    }
}

#pragma mark 设置聊天背景
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
    [UserDefault setObject:@"已设置" forKey:[NSString stringWithFormat:@"GOfBackgrounds%@_%@", _groupIdStr, [UserInfo sharedInstance].getUserid]];
    [UserDefault synchronize];
    //写入文件
    [UIImagePNGRepresentation(smallImage) writeToFile:path atomically:YES];
    //    [self postImageData:path];
    
    //读取文件
    //    UIImage *photoImg = [UIImage imageWithContentsOfFile:path];
    //    [_headerBtn setBackgroundImage:photoImg forState:(UIControlStateNormal)];
    [self.showTable reloadData];
    
}
//在本地获取图片路径啊
-(NSString *)getheadPath
{
    NSString* str=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    //    NSString* path=[str stringByAppendingPathComponent:@"headImage.png"];
    NSString *path = [str stringByAppendingPathComponent:[NSString stringWithFormat:@"GBG%@_%@.png", _groupIdStr, [UserInfo sharedInstance].getUserid]];
    
    
    
    return path;
}
- (void)requestPersonInfoData:(NSString *)targetId contentList:(void(^)(NSDictionary *listDic, NSNumber *num))contents{
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"selectId" : targetId};
    [SCNetwork postWithURLString:BDUrl_s(@"user/getUser") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
//            NSLog(@"%@", dic);
            contents(dic[@"user"], dic[@"status"]);
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
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
