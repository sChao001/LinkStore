//
//  YRHomeInfoTitleCell.m
//  Link
//
//  Created by Surdot on 2018/9/4.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "YRHomeInfoTitleCell.h"

@implementation YRHomeInfoTitleCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //        self.contentView.backgroundColor = [ColorHex(@"adadad") colorWithAlphaComponent:0.2];
        [self configlayoutCell];
    }
    return self;
}
- (void)configlayoutCell {
    _bottomView = [UIView new];
    [self addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(0);
        make.left.equalTo(5);
        make.right.equalTo(-5);
    }];
    _bottomView.backgroundColor = [UIColor whiteColor];
    _bottomView.layer.cornerRadius = kWidthScale(9);
    _bottomView.layer.masksToBounds =YES;
    
    
//    _InfoImageView = [UIImageView new];
//    [_bottomView addSubview:_InfoImageView];
//    [_InfoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(-15);
//        make.centerY.equalTo(0);
//        make.size.equalTo(CGSizeMake(kWidthScale(210/2), kWidthScale(132/2)));
//    }];
//    //    _InfoImageView.backgroundColor = [UIColor redColor];
//    _InfoImageView.contentMode = UIViewContentModeScaleAspectFill;
//    _InfoImageView.clipsToBounds = YES;
//    //    [_InfoImageView.image rescaleImageToSize:CGSizeMake(kWidthScale(210/2), kWidthScale(132/2))];
    
    
    _titleLb = [[UILabel alloc] init];
    [self addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(20);
        make.centerY.equalTo(0);
        make.right.equalTo(-15);
    }];
    _titleLb.numberOfLines = 0;
    _titleLb.font = [UIFont systemFontOfSize:kWidthScale(17)];
    
    _browseImg = [[UIImageView alloc] init];
    [self addSubview:_browseImg];
    [_browseImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(20);
        make.size.equalTo(CGSizeMake(kWidthScale(15), kWidthScale(16)));
        make.bottom.equalTo(-4);
    }];
    //    _addressImg.backgroundColor = [UIColor cyanColor];
    _browseImg.image = [UIImage imageNamed:@"y_pinglun"];
    
    _countLb = [[UILabel alloc] init];
    [self addSubview:_countLb];
    [_countLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.browseImg.mas_right).equalTo(5);
        make.width.lessThanOrEqualTo(60);
        make.bottom.equalTo(self.browseImg.mas_bottom);
    }];
    _countLb.font = [UIFont systemFontOfSize:10];
    _countLb.textColor= ColorHex(@"acacac");
    _countLb.text = @"1212";
    
    _addressImg = [[UIImageView alloc] init];
    [self addSubview:_addressImg];
    [_addressImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.countLb.mas_right).equalTo(41);
        make.size.equalTo(CGSizeMake(kWidthScale(15), kWidthScale(15)));//kw18
        make.bottom.equalTo(-4);
    }];
    _addressImg.image = [UIImage imageNamed:@"y_address"];
    
    _addressLb = [[UILabel alloc] init];
    [self addSubview:_addressLb];
    [_addressLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressImg.mas_right).equalTo(5);
        make.width.lessThanOrEqualTo(60);
        make.bottom.equalTo(self.addressImg.mas_bottom);
    }];
    _addressLb.font = [UIFont systemFontOfSize:10];
    _addressLb.textColor= ColorHex(@"acacac");
    _addressLb.text = @"天通中苑";
}
- (void)setFrame:(CGRect)frame {
    //    frame.origin.x += 10;
    frame.origin.y += 2;
    frame.size.height -= 2;
    //    frame.size.width -= 20;
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
