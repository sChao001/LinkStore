//
//  ChooseedSignCell.m
//  Link
//
//  Created by Surdot on 2018/6/20.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "ChooseedSignCell.h"

@implementation ChooseedSignCell
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
        _titleLb.backgroundColor = RGB(241, 241, 241);
        _titleLb.textAlignment = NSTextAlignmentCenter;
        _titleLb.textColor = RGB(68, 68, 68);
    }
    return _titleLb;
}
@end
