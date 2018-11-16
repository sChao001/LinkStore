//
//  NewsTitleCell.m
//  Link
//
//  Created by Surdot on 2018/6/19.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "NewsTitleCell.h"

@implementation NewsTitleCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configLayoutOfCell];
    }
    return self;
}
- (void)configLayoutOfCell {
    _titleLb = [[UILabel alloc] init];
    [self addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.right.equalTo(-15);
//        make.centerY.equalTo(0);
        make.top.equalTo(16);
    }];
    _titleLb.numberOfLines = 0;
    _titleLb.font = [UIFont systemFontOfSize:17];
    _titleLb.textColor = ColorHex(@"282828");
//    _titleLb.backgroundColor = [UIColor cyanColor];
    
    _sourceLb = [[UILabel alloc] init];
    [self addSubview:_sourceLb];
    [_sourceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLb.mas_left);
        make.bottom.equalTo(-9);
        make.width.lessThanOrEqualTo(60);
//        make.top.equalTo(self.titleLb.mas_bottom).equalTo(8);
    }];
    _sourceLb.font = [UIFont systemFontOfSize:10];
//    _sourceLb.text = @"新华网";
    _sourceLb.textColor = ColorHex(@"989898");
    
    _timeLb = [[UILabel alloc] init];
    [self addSubview:_timeLb];
    [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-15);
        make.width.greaterThanOrEqualTo(50);
        make.bottom.equalTo(-9);
    }];
//    _timeLb.text = @"2018:7:8";
    _timeLb.font = [UIFont systemFontOfSize:10];
    _timeLb.textColor = ColorHex(@"989898");
    
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
