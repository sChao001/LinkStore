//
//  ReceiveMoneyCell.m
//  Link
//
//  Created by Surdot on 2018/8/27.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "ReceiveMoneyCell.h"

@implementation ReceiveMoneyCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configLayoutOfCell];
    }
    return self;
}
- (void)configLayoutOfCell {
    _nameLb = [[UILabel alloc] init];
    [self addSubview:_nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.top.equalTo(10);
        make.width.equalTo(150);
        make.height.equalTo(15);
    }];
    _nameLb.font = [UIFont systemFontOfSize:15];
    _nameLb.textColor = ColorHex(@"282828");
    
    _moneyLb = [[UILabel alloc] init];
    [self addSubview:_moneyLb];
    [_moneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-9);
        make.centerY.equalTo(0);
        make.width.lessThanOrEqualTo(100);
        make.height.equalTo(20);
    }];
    _moneyLb.font = [UIFont systemFontOfSize:kWidthScale(20)];
    _moneyLb.textColor = ColorHex(@"282828");
    
    _isToMoney = [[UILabel alloc] init];
    [self addSubview:_isToMoney];
    [_isToMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.moneyLb.mas_right);
        make.width.greaterThanOrEqualTo(10);
        make.bottom.equalTo(-5);
    }];
    _isToMoney.text = @"未提现";
    _isToMoney.textColor = ColorHex(@"fe2123");
    _isToMoney.font = [UIFont systemFontOfSize:10];
    
    _payLb = [[UILabel alloc] init];
    [self addSubview:_payLb];
    [_payLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLb.mas_bottom).equalTo(5);
        make.left.equalTo(self.nameLb.mas_left);
        make.height.equalTo(10);
        make.width.equalTo(50);
    }];
    _payLb.font = [UIFont systemFontOfSize:10];
    _payLb.textColor = ColorHex(@"989898");
    
    _timeLb = [[UILabel alloc] init];
    [self addSubview:_timeLb];
    [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLb.mas_left);
//        make.top.equalTo(self.payLb.mas_bottom).equalTo(10);
        make.height.equalTo(10);
        make.width.greaterThanOrEqualTo(10);
        make.bottom.equalTo(-6);
    }];
    _timeLb.font = [UIFont systemFontOfSize:10];
    _timeLb.textColor = ColorHex(@"989898");
    
    _signLb = [[UILabel alloc] init];
    [self addSubview:_signLb];
    [_signLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.moneyLb.mas_left);
        make.bottom.equalTo(self.moneyLb.mas_bottom).equalTo(-2);
        make.width.equalTo(10);
        make.height.equalTo(10);
    }];
    self.signLb.textAlignment = NSTextAlignmentRight;
    _signLb.font = [UIFont systemFontOfSize:10];
    _signLb.textColor = RGB(28, 28, 28);
    _signLb.text = @"￥";
    
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x += 8;
    frame.origin.y += 5;
    frame.size.height -= 5;
    frame.size.width -= 16;
    [super setFrame:frame];
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
