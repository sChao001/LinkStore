//
//  PublishContentLabelController.h
//  Link
//
//  Created by Surdot on 2018/7/18.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCBaseViewController.h"

@protocol PublishContentLabelControllerDelegate <NSObject>
- (void)labelTitle:(NSString *)string;
@end

@interface PublishContentLabelController : SCBaseViewController
@property (nonatomic, weak) id<PublishContentLabelControllerDelegate> delegate;
@property (nonatomic, strong) NSString *rootId;
@end
