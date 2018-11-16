//
//  SubIdentifyCell.m
//  Link
//
//  Created by Surdot on 2018/5/30.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "SubIdentifyCell.h"

@implementation SubIdentifyCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setLayoutOfCell];
    }
    return self;
}
- (void)setLayoutOfCell {
    _iconImg = [UIImageView new];
    [self addSubview:_iconImg];
    [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(12);
        make.centerY.equalTo(0);
        make.size.equalTo(CGSizeMake(kWidthScale(44), kWidthScale(44)));
    }];
    _iconImg.image = [UIImage imageNamed:@"headerImg"];
    
    _titleLb = [UILabel new];
    [self addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg.mas_right).equalTo(18);
        make.centerY.equalTo(0);
        make.width.greaterThanOrEqualTo(10);
    }];
    _titleLb.text = @"faadw哈";
    _titleLb.textColor = RGB(61, 58, 57);
    _titleLb.font = [UIFont systemFontOfSize:kWidthScale(15)];
    
    _enterImg = [[UIImageView alloc] init];
    [self addSubview:_enterImg];
    [_enterImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-21);
        make.centerY.equalTo(0);
        make.size.equalTo(CGSizeMake(6, 8));
    }];
    _enterImg.image = [UIImage imageNamed:@"enterSign"];
    
    _editImg = [[UIImageView alloc] init];
    [self addSubview:_editImg];
    [_editImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.enterImg.mas_left).equalTo(-10);
        make.centerY.equalTo(0);
        make.size.equalTo(CGSizeMake(kWidthScale(14), kWidthScale(13)));
    }];
    _editImg.image = [UIImage imageNamed:@"editBtn"];
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
