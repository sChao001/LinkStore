//
//  HistoryPublishModel.h
//  Link
//
//  Created by Surdot on 2018/7/2.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryPublishModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSNumber *auditState;
@property (nonatomic, strong) NSString *auditStateValue;
@property (nonatomic, strong) NSNumber *createTime;
@end
