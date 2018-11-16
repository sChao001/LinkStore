//
//  HistoryInfoCell.m
//  Link
//
//  Created by Surdot on 2018/6/29.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "HistoryInfoCell.h"

@implementation HistoryInfoCell
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
        make.left.top.equalTo(15);
        make.right.equalTo(-75);
        make.height.equalTo(kWidthScale(43));
    }];
//    _titleLb.backgroundColor = [UIColor brownColor];
    _titleLb.text = @"关山难越，谁悲失路之人";
    _titleLb.font = [UIFont systemFontOfSize:kWidthScale(17)];
    _titleLb.textColor = RGB(28, 28, 28);
    _titleLb.numberOfLines = 0;
    
    _timeLb = [[UILabel alloc] init];
    [self addSubview:_timeLb];
    [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.top.equalTo(self.titleLb.mas_bottom).equalTo(5);
        make.right.equalTo(-15);
        make.height.equalTo(kWidthScale(13));
    }];
//    _timeLb.backgroundColor = [UIColor cyanColor];
    _timeLb.text = @"2018.6.29";
    _timeLb.font = [UIFont systemFontOfSize:kWidthScale(13)];
    _timeLb.textColor = RGB(159, 159, 159);
    
    _publishStateLb = [[UILabel alloc] init];
    [self addSubview:_publishStateLb];
    [_publishStateLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-15);
        make.width.equalTo(60);
        make.centerY.equalTo(0);
    }];
    _publishStateLb.font = [UIFont systemFontOfSize:kWidthScale(15)];
    _publishStateLb.text = @"审核中";
    _publishStateLb.textColor = RGB(120, 120, 120);
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
