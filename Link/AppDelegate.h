//
//  AppDelegate.h
//  Link
//
//  Created by Surdot on 2018/4/17.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AppDelegateOfDelegate <NSObject>
- (void)successDinDanView:(NSDictionary *)result;
@end
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, weak) id<AppDelegateOfDelegate> appDelegate;

@end

