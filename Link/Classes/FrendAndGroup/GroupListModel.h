//
//  GroupListModel.h
//  Link
//
//  Created by Surdot on 2018/5/20.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupListModel : NSObject <YYModel>
@property (nonatomic, strong) NSNumber *groupid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSString *imageUrl;
@end
