//
//  LabelsCollectionCell.m
//  Link
//
//  Created by Surdot on 2018/7/5.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "LabelsCollectionCell.h"

@implementation LabelsCollectionCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self titleLb];
    }
    return self;
}
- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        [self addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
//        _titleLb.backgroundColor = [UIColor purpleColor];
        _titleLb.textAlignment = NSTextAlignmentCenter;
        _titleLb.textColor = RGB(150, 150, 150);
        _titleLb.layer.borderWidth = 1;
        _titleLb.layer.borderColor = RGB(202, 202, 202).CGColor;
        _titleLb.layer.cornerRadius = 15;
        _titleLb.layer.masksToBounds = YES;
        _titleLb.font = [UIFont systemFontOfSize:14];
    }
    return _titleLb;
}

@end
