//
//  AddGroupmemberCell.m
//  Link
//
//  Created by Surdot on 2018/5/20.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "AddGroupmemberCell.h"

@implementation AddGroupmemberCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GroupList"];
    if (self) {
        //        self.contentView.backgroundColor = [UIColor cyanColor];
        [self configLayoutOfCell];
    }
    return self;
}

- (void)configLayoutOfCell {
    _sureImg = [[UIButton alloc] init];
    [self addSubview:_sureImg];
    [_sureImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(22);
        make.centerY.equalTo(0);
        make.size.equalTo(CGSizeMake(kWidthScale(15), kWidthScale(15)));
    }];
//    [_sureImg setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
//    [_sureImg setBackgroundImage:[UIImage imageWithColor:[UIColor yellowColor]] forState:UIControlStateSelected];
    _sureImg.layer.borderColor = RGB(200, 200, 200).CGColor;
    _sureImg.layer.borderWidth = 1;
    [_sureImg setBackgroundImage:[UIImage imageNamed:@"y_hook"] forState:UIControlStateSelected];
    _sureImg.userInteractionEnabled = NO;
    
    _headerImg = [[UIImageView alloc] init];
    [self addSubview:_headerImg];
    [_headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.sureImg.mas_right).equalTo(11);
        make.top.mas_equalTo(kWidthScale(7));
        make.size.mas_equalTo(CGSizeMake(kWidthScale(40), kWidthScale(40)));
    }];
    _headerImg.image = [UIImage imageNamed:@"headerImg"];
    _headerImg.backgroundColor = [UIColor brownColor];
    
    _nameLb = [UILabel new];
    [self addSubview:_nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImg.mas_right).mas_equalTo(kWidthScale(9));
        make.centerY.mas_equalTo(0);
        make.width.mas_lessThanOrEqualTo(200);
        make.height.mas_equalTo(kWidthScale(16));
        
    }];
    _nameLb.font = [UIFont systemFontOfSize:kWidthScale(16)];
    _nameLb.textColor = RGB(71, 70, 70);
    
    
    
    
    
    
    
    
    
    
}

@end
