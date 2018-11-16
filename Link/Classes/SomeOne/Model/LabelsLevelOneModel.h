//
//  LabelsLevelOneModel.h
//  Link
//
//  Created by Surdot on 2018/7/11.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import <Foundation/Foundation.h>


@class LabelsLevelOneDataModel;
@interface LabelsLevelOneModel : NSObject

@property (nonatomic, strong) NSNumber *Id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *source;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, strong) NSNumber *url;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSNumber *parentId;
@property (nonatomic, strong) NSArray<LabelsLevelOneDataModel *> *children;

@end

@interface LabelsLevelOneDataModel : NSObject

@property (nonatomic, strong) NSNumber *Id;
@property (nonatomic, strong) NSString *labelName;
@property (nonatomic, strong) NSNumber *status;

@end


