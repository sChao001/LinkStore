//
//  TopShowIdViewCell.m
//  Link
//
//  Created by Surdot on 2018/5/30.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "TopShowIdViewCell.h"

@implementation TopShowIdViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configLayoutOfCell];
        self.contentView.backgroundColor = RGB(2, 133, 193);
    }
    return self;
}
- (void)configLayoutOfCell {
    _iconImg = [[UIImageView alloc] init];
    [self addSubview:_iconImg];
    [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(kWidthScale(28), kWidthScale(28)));
        make.left.equalTo(15);
        make.centerY.equalTo(0);
    }];
    _iconImg.backgroundColor = [UIColor orangeColor];
    
    _nameLb = [[UILabel alloc] init];
    [self addSubview:_nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg.mas_right).equalTo(8);
        make.centerY.equalTo(0);
        make.width.equalTo(80);
    }];
    _nameLb.font = [UIFont systemFontOfSize:kWidthScale(13)];
    _nameLb.textColor = [UIColor whiteColor];
    
    _lineView = [[UIView alloc] init];
    [self addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(13);
        make.right.equalTo(-13);
        make.height.equalTo(1);
        make.bottom.equalTo(0);
    }];
    _lineView.backgroundColor = RGB(94, 170, 208);
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
