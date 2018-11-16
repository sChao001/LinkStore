//
//  ReportInfoCell.m
//  Link
//
//  Created by Surdot on 2018/8/24.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "ReportInfoCell.h"

@implementation ReportInfoCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configCellLayout];
    }
    return self;
}
- (void)configCellLayout {
    _leftImg = [[UIButton alloc] init];
    [self addSubview:_leftImg];
    [_leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.centerY.equalTo(0);
        make.size.equalTo(CGSizeMake(kWidthScale(20), kWidthScale(20)));
    }];
    _leftImg.layer.borderWidth = 1;
    _leftImg.layer.borderColor = [UIColor orangeColor].CGColor;
    [_leftImg setImage:[UIImage imageNamed:@"y_hook"] forState:UIControlStateSelected];
    
    
    _titleLb = [[UILabel alloc] init];
    [self addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImg.mas_right).equalTo(30);
        make.centerY.equalTo(0);
        make.right.equalTo(-15);
        make.height.equalTo(20);
    }];
    _titleLb.textColor = RGB(28, 28, 28);
    _titleLb.font = [UIFont systemFontOfSize:kWidthScale(16)];
//    _titleLb.backgroundColor = [UIColor cyanColor];
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
