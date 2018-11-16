//
//  HomeInfoModel.h
//  Link
//
//  Created by Surdot on 2018/7/13.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeInfoModel : NSObject
@property (nonatomic, strong) NSNumber *iD;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *titleImageUrl;
@property (nonatomic, strong) NSNumber *contentImageNumber;
@property (nonatomic, strong) NSNumber *readNumber;
@property (nonatomic, strong) NSString *address;
@end

@interface HomeInfoUserModel : NSObject
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *headUrl;
@end





