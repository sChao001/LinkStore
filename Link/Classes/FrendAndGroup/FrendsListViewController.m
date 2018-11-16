//
//  FrendsListViewController.m
//  Link
//
//  Created by Surdot on 2018/5/17.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "FrendsListViewController.h"
#import "PersonFrendListViewController.h"
#import "PhoneListViewController.h"
#import "GroupListViewController.h"
#import "AddgroupMemberController.h"
#import "SearchAndAddFriendController.h"
#import "ScanQRCodeViewController.h"
#import "SCQRCodeScanningController.h"


#define widthBtn (ScreenW/3)
@interface FrendsListViewController ()<SGPageTitleViewDelegate, SGPageContentViewDelegate>
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) RImagButton *groupChatBtn;
@property (nonatomic, strong) RImagButton *addFrendBtn;
@property (nonatomic, strong) RImagButton *scanBtn;
@property (nonatomic, strong) RImagButton *shouFuBtn;
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;

@end

@implementation FrendsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(239, 239, 239);
    [self setCommonLeftBarButtonItem];
    self.title = @"通讯录";

    [self configLayoutOfView];
    [self setAllPartView];
    
    // 状态栏(statusbar)
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    NSLog(@"status width - %f", rectStatus.size.width); // 宽度
    NSLog(@"status height - %f", rectStatus.size.height);  // 高度
    
    // 导航栏（navigationbar）
    CGRect rectNav = self.navigationController.navigationBar.frame;
    NSLog(@"nav width - %f", rectNav.size.width); // 宽度
    NSLog(@"nav height - %f", rectNav.size.height);  // 高度
    
}

- (void)configLayoutOfView {
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, kWidthScale(78))];
    [self.view addSubview:_contentView];
    _contentView.backgroundColor = RGB(249, 249, 249);
    
    _groupChatBtn = [[RImagButton alloc] init];
    [self.contentView addSubview:_groupChatBtn];
    [_groupChatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenW/3);
        make.top.left.bottom.mas_equalTo(0);
    }];
//    _groupChatBtn.backgroundColor = [UIColor yellowColor];
    [_groupChatBtn setImage:[UIImage imageNamed:@"groupChat"] forState:UIControlStateNormal];
    [_groupChatBtn setTitle:@"发起群聊" forState:UIControlStateNormal];
    [_groupChatBtn setTitleColor:RGB(71, 70, 70) forState:UIControlStateNormal];
    _groupChatBtn.titleLabel.font = [UIFont systemFontOfSize:kWidthScale(14)];
    _groupChatBtn.imageRect = CGRectMake((widthBtn-kWidthScale(24))/2, kWidthScale(16), kWidthScale(24), kWidthScale(21));
    _groupChatBtn.titleRect = CGRectMake((widthBtn - kWidthScale(60))/2, kWidthScale(48), kWidthScale(60), kWidthScale(14));
    [_groupChatBtn addTarget:self action:@selector(createGroupChat) forControlEvents:UIControlEventTouchUpInside];
//    _groupChatBtn.backgroundColor = [UIColor cyanColor];
    
    _addFrendBtn = [[RImagButton alloc] init];
    [self.contentView addSubview:_addFrendBtn];
    [_addFrendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(self.groupChatBtn.mas_right).mas_equalTo(0);
        make.width.mas_equalTo(ScreenW/3);
    }];
    [_addFrendBtn setImage:[UIImage imageNamed:@"addfrend"] forState:UIControlStateNormal];
    [_addFrendBtn setTitle:@"添加好友" forState:UIControlStateNormal];
    [_addFrendBtn setTitleColor:RGB(71, 70, 70) forState:UIControlStateNormal];
    _addFrendBtn.titleLabel.font = [UIFont systemFontOfSize:kWidthScale(14)];
    _addFrendBtn.imageRect = CGRectMake((widthBtn-kWidthScale(27))/2, kWidthScale(16), kWidthScale(27), kWidthScale(21));
    _addFrendBtn.titleRect = CGRectMake((widthBtn - kWidthScale(60))/2, kWidthScale(48), kWidthScale(60), kWidthScale(14));
    [_addFrendBtn addTarget:self action:@selector(addFrendBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    _addFrendBtn.backgroundColor = [UIColor redColor];

    
    _scanBtn = [[RImagButton alloc] init];
    [self.contentView addSubview:_scanBtn];
    [_scanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(self.addFrendBtn.mas_right);
        make.width.mas_equalTo(ScreenW/3);
    }];
    [_scanBtn setImage:[UIImage imageNamed:@"scanOfpay"] forState:UIControlStateNormal];
    [_scanBtn setTitle:@"扫一扫" forState:UIControlStateNormal];
    [_scanBtn setTitleColor:RGB(71, 70, 70) forState:UIControlStateNormal];
    _scanBtn.titleLabel.font = [UIFont systemFontOfSize:kWidthScale(14)];
    _scanBtn.imageRect = CGRectMake((widthBtn-kWidthScale(21))/2, kWidthScale(16), kWidthScale(21), kWidthScale(21));
    _scanBtn.titleRect = CGRectMake((widthBtn - kWidthScale(46))/2, kWidthScale(48), kWidthScale(46), kWidthScale(14));
    [_scanBtn addTarget:self action:@selector(scanBtnClicked) forControlEvents:UIControlEventTouchUpInside];
//    _scanBtn.backgroundColor = [UIColor yellowColor];
    
//    _shouFuBtn = [[RImagButton alloc] init];
//    [self.contentView addSubview:_shouFuBtn];
//    [_shouFuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.right.mas_equalTo(0);
//        make.left.mas_equalTo(self.scanBtn.mas_right);
//    }];
//    [_shouFuBtn setImage:[UIImage imageNamed:@"money"] forState:UIControlStateNormal];
//    [_shouFuBtn setTitle:@"收付款" forState:UIControlStateNormal];
//    [_shouFuBtn setTitleColor:RGB(71, 70, 70) forState:UIControlStateNormal];
//    _shouFuBtn.titleLabel.font = [UIFont systemFontOfSize:kWidthScale(14)];
//    _shouFuBtn.imageRect = CGRectMake((widthBtn-kWidthScale(21))/2, kWidthScale(16), kWidthScale(21), kWidthScale(21));
//    _shouFuBtn.titleRect = CGRectMake((widthBtn - kWidthScale(46))/2, kWidthScale(48), kWidthScale(46), kWidthScale(14));
}

- (void)setAllPartView {
    PersonFrendListViewController *personVC = [[PersonFrendListViewController alloc] init];
//    PhoneListViewController *phoneVC = [[PhoneListViewController alloc] init];
    GroupListViewController *groupVC = [[GroupListViewController alloc] init];
    NSArray *arrVC = @[personVC, groupVC];
    
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, kWidthScale(181), ScreenW, ScreenH) parentVC:self childVCs:arrVC];
    self.pageContentView.delegatePageContentView = self;
    [self.view addSubview:_pageContentView];
    
    NSArray *arrTitle = @[@"LINK", @"群聊"];
    //标题
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(kWidthScale(27), kWidthScale(131), ScreenW - kWidthScale(54), kWidthScale(40)) delegate:self titleNames:arrTitle];
    [self.view addSubview:self.pageTitleView];
    self.pageTitleView.titleColorStateNormal = ColorHex(@"f8b643");
    self.pageTitleView.titleColorStateSelected = RGB(255, 255, 255);
    self.pageTitleView.layer.borderColor = ColorHex(@"fde560").CGColor;
    self.pageTitleView.layer.borderWidth = 1;
    self.pageTitleView.layer.cornerRadius = kWidthScale(5);
    self.pageTitleView.layer.masksToBounds = YES;
    
//    UIView *leftView = [[UIView alloc] init];
//    [self.pageTitleView addSubview:leftView];
//    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.pageTitleView.frame.size.width / 2);
//        make.top.bottom.mas_equalTo(0);
//        make.width.mas_equalTo(1);
//    }];
//    leftView.backgroundColor = RGB(209, 226, 233);
//
//    UIView *centerView = [[UIView alloc] init];
//    [self.pageTitleView addSubview:centerView];
//    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-self.pageTitleView.frame.size.width / 2);
//        make.top.bottom.mas_equalTo(0);
//        make.width.mas_equalTo(1);
//    }];
//    centerView.backgroundColor = RGB(209, 226, 233);
    
    self.pageTitleView.backgroundColor = RGB(239, 239, 239);
    _pageTitleView.indicatorColor = ColorHex(@"f8b643");
    _pageTitleView.isShowBottomSeparator = NO; // 一条分割线
    _pageTitleView.selectedBtnColor = ColorHex(@"f8b643");
}
#pragma mark - SGPageView代理
//每次点击pageView的标题的时候
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    
    [self.pageContentView setPageCententViewCurrentIndex:selectedIndex];
    
}
- (void)pageContentView:(SGPageContentView *)pageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}
//发起群聊
- (void)createGroupChat {
//    self.tabBarController.tabBar.hidden = YES;
    AddgroupMemberController *addGroupVc = [[AddgroupMemberController alloc] init];
    [self.navigationController pushViewController:addGroupVc animated:YES];
    
}
//添加好友
- (void)addFrendBtnClicked:(UIButton *)sender {
    SearchAndAddFriendController *addVc = [[SearchAndAddFriendController alloc] init];
    [self.navigationController pushViewController:addVc animated:YES];
//    self.tabBarController.tabBar.hidden = YES;
}
//扫一扫
- (void)scanBtnClicked {
//    ScanQRCodeViewController *vc = [[ScanQRCodeViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    
    SCQRCodeScanningController *vc = [[SCQRCodeScanningController alloc] init];
    [self QRCodeScanVC:vc];

}
#pragma mark - 开始扫一扫时打开相机
- (void)QRCodeScanVC:(UIViewController *)scanVC {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (status) {
            case AVAuthorizationStatusNotDetermined: {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if (granted) {
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [self.navigationController pushViewController:scanVC animated:YES];
                        });
                        NSLog(@"用户第一次同意了访问相机权限 - - %@", [NSThread currentThread]);
                    } else {
                        NSLog(@"用户第一次拒绝了访问相机权限 - - %@", [NSThread currentThread]);
                    }
                }];
                break;
            }
            case AVAuthorizationStatusAuthorized: {
                [self.navigationController pushViewController:scanVC animated:YES];
                break;
            }
            case AVAuthorizationStatusDenied: {
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请去-> [设置 - 隐私 - 相机 - SGQRCodeExample] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alertC addAction:alertA];
                [self presentViewController:alertC animated:YES completion:nil];
                break;
            }
            case AVAuthorizationStatusRestricted: {
                NSLog(@"因为系统原因, 无法访问相册");
                break;
            }
                
            default:
                break;
        }
        return;
    }
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertC addAction:alertA];
    [self presentViewController:alertC animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
