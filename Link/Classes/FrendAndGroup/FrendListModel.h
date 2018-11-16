//
//  FrendListModel.h
//  Link
//
//  Created by Surdot on 2018/5/18.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FrendListModel : NSObject<YYModel>
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *headUrl;
@property (nonatomic, strong) NSNumber *iD;
@end
