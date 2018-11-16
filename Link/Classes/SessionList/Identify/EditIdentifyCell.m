//
//  EditIdentifyCell.m
//  Link
//
//  Created by Surdot on 2018/5/30.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "EditIdentifyCell.h"

@implementation EditIdentifyCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configLayoutCell];
    }
    return self;
}
- (void)configLayoutCell {
    _titleLb = [UILabel new];
    [self addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(12);
        make.centerY.equalTo(0);
        make.width.greaterThanOrEqualTo(10);
    }];
    _titleLb.text = @"哈哈哈";
//    _titleLb.backgroundColor = [UIColor redColor];
    _titleLb.textColor = RGB(61, 58, 57);
    _titleLb.font = [UIFont systemFontOfSize:kWidthScale(16)];
    
    _detailLb = [UILabel new];
    [self addSubview:_detailLb];
    [_detailLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-11);
        make.centerY.equalTo(0);
        make.width.greaterThanOrEqualTo(10);
    }];
    _detailLb.text = @"";
//    _detailLb.backgroundColor = [UIColor yellowColor];
    _detailLb.textColor = RGB(153, 153, 153);
    _detailLb.font = [UIFont systemFontOfSize:kWidthScale(12)];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
