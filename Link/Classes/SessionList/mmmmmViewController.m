//
//  mmmmmViewController.m
//  Link
//
//  Created by Surdot on 2018/6/1.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "mmmmmViewController.h"
#import "LKSessionViewController.h"
#import "SpeechViewController.h"
#import "ViewController.h"
#import "LKTabBarController.h"
#import "LkSearchViewController.h"
#import "SearchUserViewController.h"
#import "LKMessageListCell.h"
#import "LKUserInfo.h"
#import "ListViewCell.h"
#import "AddSubIdentifyController.h"
#import <Accelerate/Accelerate.h>
#import "TopShowOfIdedtifyController.h"
#import "FrendsListViewController.h"
#import "FriendRequestSureController.h"
#import "LCNetworking.h"



@interface mmmmmViewController ()
@property (nonatomic, strong) RCUserInfo *currentUserInfo;
@property (nonatomic, strong) SpeechViewController *speechVC;
@property (nonatomic, strong) ViewController *vc;
@property (nonatomic, strong) LKTabBarController *tabBarVC;
@property (nonatomic, strong) ViewController *vC;
@property(nonatomic, assign) BOOL isClick;
@property (nonatomic, strong) UIImageView *showImageView;
@property (nonatomic, strong) UITableView *identityTableView;
@property (nonatomic, strong) RImagButton *setBtn;
@property (nonatomic, strong) UIView *lineViewOne;
@property (nonatomic, strong) RImagButton *homeBtn;
@property (nonatomic, strong) TopShowOfIdedtifyController *showVC;
@property (nonatomic, strong) NSString *frendHeadUrl;


@end



@implementation mmmmmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    _showVC = [[TopShowOfIdedtifyController alloc] init];
    [self.view addSubview:_showVC.view];
    [self addChildViewController:_showVC];
    _showVC.view.hidden = YES;
    
    [self setNavigationBarItem];
    [UserDefault setInteger:0 forKey:@"unReadCount"];
    [UserDefault synchronize];
    
    self.conversationListTableView.bounces = NO;
    self.conversationListTableView.backgroundColor = RGB(215, 215, 215);
    self.conversationListTableView.showsVerticalScrollIndicator = NO;
    self.conversationListTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //保证token连接成功后刷新消息列表
        [self refreshConversationTableViewIfNeeded];
        
        //设置当前用户自己的名字和头像
        self.currentUserInfo = [RCUserInfo new];
        //    self.currentUserInfo.name = userId;
        self.currentUserInfo.portraitUri = @"https://api.joint-think.com/uploads/face/20180312/15208274169226.png";
        [[RCIM sharedRCIM] refreshUserInfoCache:self.currentUserInfo withUserId:[UserInfo sharedInstance].getRCtoken];
    });
//        [[RCIM sharedRCIM] setReceiveMessageDelegate:self];
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _isClick = YES;
    
    self.tabBarController.tabBar.hidden = NO;
    [RCIM sharedRCIM].globalMessagePortraitSize = CGSizeMake(kWidthScale(36), kWidthScale(36));
    [RCIM sharedRCIM].globalConversationPortraitSize = CGSizeMake(50, 50);
    NSLog(@"%d", [[RCIMClient sharedRCIMClient] getTotalUnreadCount]);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveRedBadgeValue" object:nil];//消除红点通知

}
- (void)setNavigationBarItem {
    NSString *stringX = @"y_naviBarX";
    NSString *string = @"y_naviBar";
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", LK_iPhoneX ? stringX : string]] forBarMetrics:UIBarMetricsDefault];
    //去掉黑线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:RGB(28, 28, 28),NSFontAttributeName:[UIFont boldSystemFontOfSize:17]};
    self.navigationController.navigationBar.translucent = NO;
    
//    UIImage *imageLeft = [UIImage imageNamed:@"accountSign"];
//    UIImage *selectImage0 = [imageLeft imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:selectImage0 style:UIBarButtonItemStylePlain target:self action:@selector(switchSubAccount)];
//    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    UIImage *image = [UIImage imageNamed:@"y_funcS"];
    UIImage *selectImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightBarItemOne = [[UIBarButtonItem alloc] initWithImage:selectImage style:UIBarButtonItemStylePlain target:self action:@selector(showMenu:)];
    self.navigationItem.rightBarButtonItem = rightBarItemOne;
}
- (void)setIdentityLayoutView {
    _identityTableView = [[UITableView alloc] init];
    //    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self.view addSubview:_identityTableView];
    [_identityTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(12);
        make.top.equalTo(LK_iPhoneXNavHeight+10);
        make.size.equalTo(CGSizeMake(kWidthScale(151), kWidthScale(220)));
    }];
    _identityTableView.backgroundColor = [UIColor clearColor];
    _identityTableView.hidden = YES;
    
    
    UIView *footView = [[UIView alloc] init];
    _identityTableView.tableFooterView = footView;
    //    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.top.right.equalTo(0);
    //        make.height.equalTo(kWidthScale(81));
    //    }];
    
    footView.frame = CGRectMake(0, 0, kWidthScale(151), 81);
    footView.backgroundColor = [RGB(2, 133, 193) colorWithAlphaComponent:0.9];
    footView.backgroundColor = [UIColor colorWithPatternImage:[self blurryImage:[UIImage imageWithColor:[RGB(2, 133, 193) colorWithAlphaComponent:0.9]] withBlurLevel:0.1]];
    //    _setBtn =[[RImagButton alloc]initWithFrame:CGRectMake((kWidthScale(151)-13)/2, 12 + 41, 13, 13)];
    _setBtn = [[RImagButton alloc] initWithFrame:CGRectMake(0, 42, kWidthScale(151), 39)];
    _setBtn.imageRect = CGRectMake((kWidthScale(151) - 13) / 2, 12, 13, 13);
    [_setBtn setImage:[UIImage imageNamed:@"setBtn"] forState:UIControlStateNormal];
    [footView addSubview:_setBtn];
    [_setBtn addTarget:self action:@selector(toSetSubIdentify) forControlEvents:UIControlEventTouchUpInside];
    
    _lineViewOne = [[UIView alloc] initWithFrame:CGRectMake(13, 41, kWidthScale(151) - 26, 1)];
    _lineViewOne.backgroundColor = RGB(94, 170, 208);
    [footView addSubview:_lineViewOne];
    _identityTableView.bounces = NO;
    
    _homeBtn = [[RImagButton alloc]initWithFrame:CGRectMake(0, 0, kWidthScale(151), 41)];
    [footView addSubview:_homeBtn];
    _homeBtn.imageRect = CGRectMake(kWidthScale(17), 10, 20, 20);
    [_homeBtn setImage:[UIImage imageNamed:@"homeLink"] forState:UIControlStateNormal];
    _homeBtn.titleRect = CGRectMake(30 + kWidthScale(17), 10, 35, 20);
    [_homeBtn setTitle:@"Link" forState:UIControlStateNormal];
    _homeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_homeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}


- (void)toSetSubIdentify {
    AddSubIdentifyController *vc = [[AddSubIdentifyController alloc] init];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)customShowIdentifyView {
    
}

- (void)switchSubAccount {
    if (_showVC.view.hidden) {
        _showVC.view.hidden = NO;
    }else {
        _showVC.view.hidden = YES;
    }
}

- (void)add {
    NSLog(@"被点击了");
}

- (void)clicked {
    NSLog(@"点击搜索");
    //搜索用户添加好友
    NSDictionary *paramet = @{@"account" : @"15201152903", @"userId" : @"3"};
    [SCNetwork postWithURLString:@"http://192.168.3.9:8080/user/get" parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"请求成功%@, result:%@", dic[@"code"], dic[@"result"]);
        }else {
            NSLog(@"请求失败%@, result:%@", dic[@"code"], dic[@"result"]);
        }
    } failure:^(NSError *error) {
        NSLog(@"网络连接失败");
    }];
    
}


- (void)showMenu:(UIButton *)sender {
    FrendsListViewController *vc = [[FrendsListViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (id)init {
    self = [super init];
    if (self) {
        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                            @(ConversationType_DISCUSSION),
                                            @(ConversationType_CHATROOM),
                                            @(ConversationType_GROUP),
                                            @(ConversationType_APPSERVICE),
                                            @(ConversationType_SYSTEM)]];
        //设置需要将哪些类型的会话在会话列表中聚合显示
        //        [self setCollectionConversationType:@[@(ConversationType_DISCUSSION),
        //                                              @(ConversationType_GROUP)]];
        [self setCollectionConversationType:@[@(ConversationType_SYSTEM)]];
    }
    return self;
}

//即将显示的cell回调
- (void)willDisplayConversationTableCell:(RCConversationBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    
}
//点击cell头像回调
- (void)didTapCellPortrait:(RCConversationModel *)model {
    //    LKLittleSessionViewController *vc = [[LKLittleSessionViewController alloc] init];
    //    [self.navigationController pushViewController:vc animated:YES];
    //    self.tabBarController.tabBar.hidden = YES;
    
    //    self.vC.view.hidden = NO;
    
}

//点击消息列表中的cell
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath {
    if (_isClick) {
        _isClick = NO;
        if (model.conversationModelType == RC_CONVERSATION_MODEL_TYPE_PUBLIC_SERVICE) {//service 公共服务的会话显示
            LKSessionViewController *_conversationVC = [[LKSessionViewController alloc] init];
            _conversationVC.conversationType = model.conversationType;
            _conversationVC.targetId = model.targetId;
            
            //            _conversationVC.userName = model.conversationTitle;
            _conversationVC.title = model.conversationTitle;
            _conversationVC.conversation = model;
            [self.navigationController pushViewController:_conversationVC animated:YES];
        }
        
        if (conversationModelType == RC_CONVERSATION_MODEL_TYPE_NORMAL) {// normal 默认显示
            LKSessionViewController *_conversationVC = [[LKSessionViewController alloc] init];
            _conversationVC.conversationType = model.conversationType;
            _conversationVC.targetId = model.targetId;
            NSLog(@"%@", model.targetId);
            //获取当前用户id
            //            _conversationVC.userName = model.conversationTitle;
            _conversationVC.title = model.conversationTitle;
            _conversationVC.conversation = model;
            _conversationVC.unReadMessage = model.unreadMessageCount;
            _conversationVC.enableNewComingMessageIcon = YES; //开启消息提醒
            _conversationVC.enableUnreadMessageIcon = YES;
            if (model.conversationType == ConversationType_SYSTEM) {//系统会话
                //                _conversationVC.userName = @"系统消息";
                _conversationVC.title = @"系统消息";
                NSLog(@"收到了系统消息");
            }
            if ([model.objectName isEqualToString:@"RC:ContactNtf"]) {
                
                ViewController *vc = [[ViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            //如果是单聊，不显示发送方昵称
            if (model.conversationType == ConversationType_PRIVATE) {
                
                _conversationVC.displayUserNameInCell = NO;
            }
            self.tabBarController.tabBar.hidden = YES;
            
            [self.navigationController pushViewController:_conversationVC animated:YES];
        }
        
        //聚合会话类型，此处自定设置。
        if (conversationModelType == RC_CONVERSATION_MODEL_TYPE_COLLECTION) {
            mmmmmViewController *temp = [[mmmmmViewController alloc] init];
            NSArray *array = [NSArray arrayWithObject:[NSNumber numberWithInt:model.conversationType]];
            [temp setDisplayConversationTypes:array];

            [temp setCollectionConversationType:nil];
            temp.isEnteredToCollectionViewController = YES;
            temp.hidesBottomBarWhenPushed = YES;

            NSLog(@"%@000%@", [NSThread currentThread], self.navigationController);
            [self.navigationController pushViewController:temp animated:YES];
            
        }else {
            [super onSelectedTableRow:conversationModelType conversationModel:model atIndexPath:indexPath];
        }
        
        //自定义会话类型
        if (conversationModelType == RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION) {
            RCConversationModel *model = self.conversationListDataSource[indexPath.row];
            
            if ([model.objectName isEqualToString:@"RC:ContactNtf"]) {
                FriendRequestSureController *vc = [[FriendRequestSureController alloc] init];
                vc.targetId = model.targetId;
                
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }
}
//插入自定义会话model
- (NSMutableArray *)willReloadTableData:(NSMutableArray *)dataSource {
    for (int i = 0; i < dataSource.count; i++) {
        RCConversationModel *model = dataSource[i];
        //RCContactNotificationMessage 好友请求消息类
        if (model.conversationType == ConversationType_SYSTEM &&
            [model.lastestMessage isMemberOfClass:[RCContactNotificationMessage class]]) {
            model.conversationModelType = RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION;
        }
    
        //群组
        if ([model.lastestMessage isKindOfClass:[RCGroupNotificationMessage class]]) {
            RCGroupNotificationMessage *groupNotification = (RCGroupNotificationMessage *)model.lastestMessage;
            if ([groupNotification.operation isEqualToString:@"Quit"]) {
                NSData *jsonData = [groupNotification.data dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *dictionary =
                [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                NSDictionary *data =
                [dictionary[@"data"] isKindOfClass:[NSDictionary class]] ? dictionary[@"data"] : nil;
                NSString *nickName =
                [data[@"operatorNickname"] isKindOfClass:[NSString class]] ? data[@"operatorNickname"] : nil;
                if ([nickName isEqualToString:[RCIM sharedRCIM].currentUserInfo.name]) {
                    [[RCIMClient sharedRCIMClient] removeConversation:model.conversationType targetId:model.targetId];
                    [self refreshConversationTableViewIfNeeded];
                }
            }
        }
    }
    return dataSource;
}
//左滑删除
- (void)rcConversationListTableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //可以从数据库删除数据
    RCConversationModel *model = self.conversationListDataSource[indexPath.row];
    [[RCIMClient sharedRCIMClient] removeConversation:ConversationType_SYSTEM targetId:model.targetId];
    [self.conversationListDataSource removeObjectAtIndex:indexPath.row];
    [self.conversationListTableView reloadData];
}

//删除会话cell
- (void)didDeleteConversationCell:(RCConversationModel *)model {
    [[RCIMClient sharedRCIMClient] removeConversation:ConversationType_PRIVATE targetId:model.targetId];
    [[RCIMClient sharedRCIMClient] clearMessages:ConversationType_PRIVATE targetId:model.targetId];
    [[RCIMClient sharedRCIMClient] deleteMessages:ConversationType_PRIVATE targetId:model.targetId success:^{
        NSLog(@"删除成功");
    } error:^(RCErrorCode status) {
        
        NSLog(@"删除失败");
    }];
    [self.conversationListTableView reloadData];
    
    [[RCIMClient sharedRCIMClient] removeConversation:ConversationType_GROUP targetId:model.targetId];
    [[RCIMClient sharedRCIMClient] clearMessages:ConversationType_GROUP targetId:model.targetId];
    [[RCIMClient sharedRCIMClient] deleteMessages:ConversationType_GROUP targetId:model.targetId success:^{
        NSLog(@"删除成功");
    } error:^(RCErrorCode status) {
        
        NSLog(@"删除失败");
    }];
    [self.conversationListTableView reloadData];
    
}
//////高度
- (CGFloat)rcConversationListTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 67.0f;
}
//自定义会话cell的显示回调
- (RCConversationBaseCell *)rcConversationListTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RCConversationModel *model = self.conversationListDataSource[indexPath.row];
    NSLog(@"自定义扩展数据%@===%@", model.extend, model.targetId);
    __block NSString *userName = nil;
    __block NSString *portraitUri = nil;
    RCContactNotificationMessage *_contactNotificationMsg = nil;
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"selectId" : model.targetId};
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t  sema = dispatch_semaphore_create(0);
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        [LCNetworking PostWithURL:BDUrl_s(@"user/getUser") Params:paramet success:^(id responseObject) {
            dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                dispatch_semaphore_signal(sema);
            });
            if ([responseObject[@"code"] integerValue] > 0) {
                NSDictionary *listUser = responseObject[@"user"];
                portraitUri = BDUrl_(listUser[@"headUrl"]);
                NSLog(@"%@", portraitUri);
            }
        } failure:^(NSString *error) {
            [SVProgressHUD showWithStatus:@"网络连接失败"];
            [SVProgressHUD dismissWithDelay:0.7];
        }];
    });
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
    //此处需要添加根据userid来获取用户信息的逻辑，extend字段不存在于DB中，当数据来自db时没有extend字段内容，只有userid
    if (model.conversationType == ConversationType_SYSTEM &&
        [model.lastestMessage isMemberOfClass:[RCContactNotificationMessage class]]) {
        _contactNotificationMsg = (RCContactNotificationMessage *)model.lastestMessage;
        NSLog(@"++%@--%@", _contactNotificationMsg.message, _contactNotificationMsg.targetUserId);
        if (_contactNotificationMsg.sourceUserId == nil) {
            LKMessageListCell *cell =
            [[LKMessageListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
            cell.messageLb.text = _contactNotificationMsg.message;
            NSLog(@"==%@", _contactNotificationMsg.message);
            cell.titleLb.text = @"好友请求";
            [cell.iconImgView sd_setImageWithURL:[NSURL URLWithString:portraitUri]
                                placeholderImage:[UIImage imageNamed:@"xitong"]];
            return cell;
        }
    }
    
    /** 暂时没用*/
    LKMessageListCell *cell = [[LKMessageListCell alloc] init];
    //    RCMessageContent *content = [[RCMessageContent alloc] init];

    NSString *operation = _contactNotificationMsg.operation;
    NSString *operationContent;
    if ([operation isEqualToString:@"Request"]) {
        operationContent = [NSString stringWithFormat:@"来自%@的好友请求", userName];
        NSLog(@"Request: %@", operationContent);
    } else if ([operation isEqualToString:@"AcceptResponse"]) {
        operationContent = [NSString stringWithFormat:@"%@通过了你的好友请求", userName];
        NSLog(@"AcceptResponse: %@", operationContent);
    }
//    cell.messageLb.text = _contactNotificationMsg.message;
    NSLog(@"%@", _contactNotificationMsg.message);
    cell.titleLb.text = @"好友请求消息";
    NSLog(@"%@", operationContent);
//    [cell.iconImgView sd_setImageWithURL:[NSURL URLWithString:portraitUri]
//                        placeholderImage:[UIImage imageNamed:@"xitong"]];
//    cell.labelTime.text = [RCKitUtility ConvertMessageTime:model.sentTime / 1000];

    cell.model = model;
    return cell;
    
}
//未读消息
- (void)notifyUpdateUnreadMessageCount {
    
}
#pragma mark - 收到消息监听
//收到个人消息、群消息会、系统消息走这个方法
- (void)didReceiveMessageNotification:(NSNotification *)notification {
    [super didReceiveMessageNotification:notification];
    RCMessage *message = notification.object;
    NSLog(@"消息消息 %@", message.content.senderUserInfo);
    NSLog(@"%d", [[RCIMClient sharedRCIMClient] getTotalUnreadCount]);
    NSDictionary *userInfo = notification.userInfo;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveRedBadgeValue" object:nil userInfo:userInfo];
}
//设置消息提示音
- (BOOL)onRCIMCustomAlertSound:(RCMessage *)message {
    NSLog(@"%@", message.senderUserId);
    [RCIM sharedRCIM].disableMessageAlertSound = NO;
    return NO;
}

// 添加通用模糊效果 // image是图片，blur是模糊度
- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    if (image==nil) {
        NSLog(@"error:为图片添加模糊效果时，未能获取原始图片"); return nil;
    }
    //模糊度,
    if (blur < 0.025f) {
        blur = 0.025f;
        
    } else if (blur > 1.0f) {
        blur = 1.0f;
        
    }
    //boxSize必须大于0
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    NSLog(@"boxSize:%i",boxSize);
    //图像处理
    CGImageRef img = image.CGImage;
    //需要引入#import <Accelerate/Accelerate.h>
    //图像缓存,输入缓存，输出缓存
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    //像素缓存
    void *pixelBuffer;
    //数据源提供者，Defines an opaque type that supplies Quartz with data.
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    // provider’s data.
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    //宽，高，字节/行，data
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    //像数缓存，字节行*图片高
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    // 第三个中间的缓存区,抗锯齿的效果
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    //Convolves a region of interest within an ARGB8888 source image by an implicit M x N kernel that has the effect of a box filter.
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) { NSLog(@"error from convolution %ld", error);
        
    }
    // NSLog(@"字节组成部分：%zu",CGImageGetBitsPerComponent(img));
    //颜色空间DeviceRGB
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //用图片创建上下文,CGImageGetBitsPerComponent(img),7,8
    CGContextRef ctx = CGBitmapContextCreate( outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));
    //根据上下文，处理过的图片，重新组件
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    //CGColorSpaceRelease(colorSpace); //多余的释放
    CGImageRelease(imageRef);
    return returnImage;
}





@end
