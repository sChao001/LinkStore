//
//  WXApiManager.h
//  Link
//
//  Created by Surdot on 2018/7/26.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol WXApiManagerDelegate <NSObject>
- (void)tanSuccessDinDanView;
@end

@interface WXApiManager : NSObject<WXApiDelegate>

+ (instancetype)sharedManager;
@property (nonatomic, weak) id<WXApiManagerDelegate> delegate;
@end
