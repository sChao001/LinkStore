//
//  YRHomeUserCell.m
//  Link
//
//  Created by Surdot on 2018/7/18.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "YRHomeUserCell.h"

@implementation YRHomeUserCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatCellLayout];
    }
    return self;
}
- (void)creatCellLayout {
    _headerView = [[UIImageView alloc] init];
    [self addSubview:_headerView];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.centerY.equalTo(0);
        make.size.equalTo(CGSizeMake(kWidthScale(48), kWidthScale(48)));
    }];
    
    _titleLb = [[UILabel alloc] init];
    [self addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerView.mas_right).equalTo(10);
        make.centerY.equalTo(0);
        make.width.greaterThanOrEqualTo(10);
    }];
    _titleLb.font = [UIFont systemFontOfSize:kWidthScale(16)];
    _titleLb.textColor = RGB(70, 70, 70);
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
