//
//  LKPersonalSetCell.m
//  Link
//
//  Created by Surdot on 2018/5/25.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "LKPersonalSetCell.h"

@implementation LKPersonalSetCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"setCell"]) {
        [self configLayoutCell];
    }
    return self;
}

- (void)configLayoutCell {
    _titleLb = [[UILabel alloc] init];
    [self addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kWidthScale(22));
        make.centerY.equalTo(0);
        make.width.greaterThanOrEqualTo(10);
    }];
    _titleLb.font = [UIFont systemFontOfSize:kWidthScale(15)];
    _titleLb.textColor = RGB(61, 58, 57);
    
    
    
    _switchBtn = [[UIButton alloc] init];
    [self addSubview:_switchBtn];
    [_switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(kWidthScale(-16));
        make.size.equalTo(CGSizeMake(45, 21));
        make.centerY.equalTo(0);
    }];
//    _switchBtn.backgroundColor = [UIColor brownColor];
    [_switchBtn setImage:[UIImage imageNamed:@"switchNor"] forState:UIControlStateNormal];
    [_switchBtn setImage:[UIImage imageNamed:@"missSwitch"] forState:UIControlStateSelected];
//    [_switchBtn addTarget:self action:@selector(switchBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    _subTitleLb = [[UILabel alloc] init];
    [self addSubview:_subTitleLb];
    [_subTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-15);
        make.centerY.equalTo(0);
        make.width.greaterThanOrEqualTo(10);
    }];
    _subTitleLb.font = [UIFont systemFontOfSize:12];
    _subTitleLb.textColor = RGB(113, 112, 113);
    _subTitleLb.text = @"";
    
}
- (void)switchBtnClicked:(UIButton *)sender {
    _switchBtn.selected = !_switchBtn.selected;
    if (_switchBtn.selected) {
        NSLog(@"111");
    }else {
        NSLog(@"222");
    }
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
