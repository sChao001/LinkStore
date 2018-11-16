//
//  PlatformAccountListCell.m
//  Link
//
//  Created by Surdot on 2018/9/6.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "PlatformAccountListCell.h"

@implementation PlatformAccountListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configLayoutOfCell];
    }
    return self;
}
- (void)configLayoutOfCell {
    _iconImage = [[UIImageView alloc] init];
    [self addSubview:_iconImage];
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(kWidthScale(45), kWidthScale(45)));
        make.centerY.equalTo(0);
        make.left.equalTo(12);
    }];
//    _iconImage.backgroundColor = [UIColor cyanColor];
    
    _titleLb = [[UILabel alloc] init];
    [self addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImage.mas_top);
        make.width.lessThanOrEqualTo(150);
        make.left.equalTo(self.iconImage.mas_right).equalTo(13);
    }];
    _titleLb.text = @"名字";
    _titleLb.textColor = ColorHex(@"282828");
    _titleLb.font = [UIFont systemFontOfSize:kWidthScale(14)];
    
    _timeLb = [[UILabel alloc] init];
    [self addSubview:_timeLb];
    [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLb.mas_left);
        make.width.lessThanOrEqualTo(150);
        make.bottom.equalTo(self.iconImage.mas_bottom);
    }];
    _timeLb.text = @"2018-09-06";
    _timeLb.textColor = ColorHex(@"989898");
    _timeLb.font = [UIFont systemFontOfSize:kWidthScale(12)];
    
    _maoneyLb = [[UILabel alloc] init];
    [self addSubview:_maoneyLb];
    [_maoneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-12);
        make.centerY.equalTo(0);
        make.width.greaterThanOrEqualTo(10);
    }];
    _maoneyLb.text = @"0.8元";
    _maoneyLb.textColor = ColorHex(@"282828");
    _maoneyLb.font = [UIFont systemFontOfSize:kWidthScale(15)];
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
