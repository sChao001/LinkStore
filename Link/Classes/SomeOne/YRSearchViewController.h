//
//  YRSearchViewController.h
//  Link
//
//  Created by Surdot on 2018/7/9.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCBaseViewController.h"

@protocol YRSearchViewControllerDelegate <NSObject>
- (void)searchText:(NSString *)string;
@end

@interface YRSearchViewController : SCBaseViewController
@property (nonatomic, weak) id<YRSearchViewControllerDelegate> delegate;
@end
