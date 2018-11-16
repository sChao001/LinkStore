//
//  MyChannelViewController.h
//  Link
//
//  Created by Surdot on 2018/6/22.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCBaseViewController.h"

@protocol MyChannelViewControllerDelegate <NSObject>
- (void)sendMessage:(NSString *)isYes;
@end

@interface MyChannelViewController : SCBaseViewController
@property (nonatomic, strong) NSArray *signArray;
@property (nonatomic, strong) NSArray *belowArray;
@property (nonatomic, weak) id<MyChannelViewControllerDelegate> delegate;
@end
