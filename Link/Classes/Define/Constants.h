//
//  Constants.h
//  Link
//
//  Created by Surdot on 2018/4/18.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define RGB(r, g, b) [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:1.0f]
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:a]
#define ColorHex(str) [UIColor colorWithHexString:str]
//获取系统版本
#define IOS_SystemVersion ([[[UIDevice currentDevice] systemVersion] floatValue])

//获取屏幕 宽度、高度
#define ScreenW ([UIScreen mainScreen].bounds.size.width)
#define ScreenH ([UIScreen mainScreen].bounds.size.height)
//当前设备的屏幕高度
#define kWidthScale(value) (((value)/375.0) * ScreenW)
#define kHeightScale(value) (((value)/667.0) * ScreenH)

#define UserDefault [NSUserDefaults standardUserDefaults]

/*iPhone X 宏定义 */
#define LK_iPhoneX (ScreenW == 375.f && ScreenH == 812.f ? YES : NO)
/** 适配iPhone X “刘海”高度24 */
#define LK_iPhoneXBang (LK_iPhoneX ? 24.f : 0.f)
/**适配iPhone X 状态栏高度44 */
#define LK_iPhoneXStatusBarHeight (LK_iPhoneX ? 44.f : 20.f)
/**适配iPhone X 导航栏高度88 */
#define LK_iPhoneXNavHeight (LK_iPhoneX ? 88.f : 64.f)
/** 适配iPhone X Tabbar距离底部的距离 34 -- 0*/
#define LK_TabbarSafeBottomMargin (LK_iPhoneX ? 34.f : 0.f)

#define LK_iPhoneXscrollHeight  (LK_iPhoneX ? 34.f : 0.f)
#define LK_iPhoneOffBangHeight  (LK_iPhoneX ? 60.f : 0.f)


#define iPhone4 (ScreenW == 320.f && ScreenH == 480.f ? YES : NO)

#define KweakSelf __block typeof(self) weakSelf = self;

#define MAIN_URL @"http://10.87.1.187:8888/"     //surdot.com
#define RCIMToken_environment  [[RCIM sharedRCIM] initWithAppKey:@"pwe86ga5pv916"] // pwe86ga5pv916 开发        4z3hlwrv4o5ct 生产

#define KURL_(url) [NSString stringWithFormat:@"%@%@",MAIN_URL,url]
#define BDUrl_(url) [NSString stringWithFormat:@"%@%@", MAIN_URL, url]  //10.87.1.187:8888     /**47.93.244.115*/
#define BDUrl_c(url) [NSString stringWithFormat:@"%@c/%@", MAIN_URL, url]
#define BDUrl_s(url) [NSString stringWithFormat:@"%@s/%@", MAIN_URL, url]
#define BD_SIGN  @"5f58c35a9ea3d8e11339005d45dc4dee"
#define BD_key   @"nishishui20180608"
#define BD_secret @"woshishui20180608p2dz"
#define BD_MD5Sign [NSString stringWithFormat:@"%@%@%@", BD_key, BD_secret, [UserInfo sharedInstance].getjmToken]
#define Un_LogInSign [NSString stringWithFormat:@"%@%@%@", BD_key, BD_secret, @"a7da48eew8e64fs5dwe78rf5s4df"] //游客进入

/**友盟*/
#define UM_appKey @"5b63b3fff43e48083a000119" 

#define USER_UM_token @"tokens"

#define BaseFooter  UIView * footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 30+15)];\
UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, ScreenW, 15)];\
label.textAlignment = NSTextAlignmentCenter;\
label.textColor = RGB_Y(159);\
label.font = [UIFont systemFontOfSize:15];\
label.text = @"~ 没有数据了 ~";\
[footerView addSubview: label];\
self.tableView.tableFooterView = footerView;



#define HexColorInt32_t(rgbValue) \
[UIColor colorWithRed:((float)((0x##rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((0x##rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(0x##rgbValue & 0x0000FF))/255.0  alpha:1]


///  获取屏幕宽度
static inline CGFloat _getScreenWidth () {
    static CGFloat _screenWidth = 0;
    if (_screenWidth > 0) return _screenWidth;
    _screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    return _screenWidth;
}

///  获取屏幕高度
static inline CGFloat _getScreenHeight () {
    static CGFloat _screenHeight = 0;
    if (_screenHeight > 0) return _screenHeight;
    _screenHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
    return _screenHeight;
}


#define kScreenHeight     _getScreenHeight()
#define kScreenWidth      _getScreenWidth()

#define BLOCK_SAFE_RUN(block, ...) block ? block(__VA_ARGS__) : nil;
#endif /* Constants_h */
