//
//  MineListCell.m
//  Link
//
//  Created by Surdot on 2018/7/18.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "MineListCell.h"

@implementation MineListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeCelllayout];
    }
    return self;
}
- (void)makeCelllayout {
    _inconImg = [[UIImageView alloc] init];
    [self addSubview:_inconImg];
    [_inconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(23);
        make.centerY.equalTo(0);
        make.size.equalTo(CGSizeMake(kWidthScale(30), kWidthScale(30)));
    }];
//    _inconImg.backgroundColor = [UIColor brownColor];
    
    _titleLb = [[UILabel alloc] init];
    [self addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inconImg.mas_right).equalTo(29);
        make.width.greaterThanOrEqualTo(10);
        make.centerY.equalTo(0);
    }];
    _titleLb.font = [UIFont systemFontOfSize:kWidthScale(17)];
    _titleLb.textColor = ColorHex(@"282828");
    _titleLb.text = @"";
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
