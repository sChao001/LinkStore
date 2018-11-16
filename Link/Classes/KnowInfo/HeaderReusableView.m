//
//  HeaderReusableView.m
//  Link
//
//  Created by Surdot on 2018/6/21.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "HeaderReusableView.h"

@implementation HeaderReusableView
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
            make.left.equalTo(15);
            make.center.equalTo(0);
            make.width.equalTo(80);
        }];
        _titleLb.text = @"我的标签";
        _titleLb.textColor = RGB(27, 27, 27);
    }
    return _titleLb;
}



@end
