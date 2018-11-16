//
//  LKGroupMembersCell.m
//  Link
//
//  Created by Surdot on 2018/5/22.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "LKGroupMembersCell.h"

@implementation LKGroupMembersCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self iconImg];
        [self nameLb];
    }
    return self;
}

- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [UIImageView new];
        [self addSubview:_iconImg];
        [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(0);
            make.height.equalTo(58);
        }];
//        _iconImg.backgroundColor = [UIColor greenColor];
    }
    return _iconImg;
}

- (UILabel *)nameLb {
    if (!_nameLb) {
        _nameLb = [UILabel new];
        [self addSubview:_nameLb];
        [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconImg.mas_bottom).equalTo(14);
            make.left.bottom.right.equalTo(0);
        }];
        _nameLb.text = @"习近平";
        _nameLb.font = [UIFont systemFontOfSize:12];
        _nameLb.textAlignment = NSTextAlignmentCenter;
        _nameLb.textColor = RGB(113, 112, 113);
//        _nameLb.backgroundColor = [UIColor redColor];
    }
    return _nameLb;
}







@end
