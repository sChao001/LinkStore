//
//  LKMessageListCell.m
//  Link
//
//  Created by Surdot on 2018/4/20.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "LKMessageListCell.h"

@implementation LKMessageListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"chatList"];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self configCustomCellLayout];
    }
    return self;
}

- (void)configCustomCellLayout {
    _iconImgView = [[UIImageView alloc] init];
    [self addSubview:_iconImgView];
    [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.centerY.equalTo(0);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    _iconImgView.image = [UIImage imageNamed:@""];
//    _iconImgView.backgroundColor = [UIColor brownColor];

    _titleLb = [[UILabel alloc] init];
    [self addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(self.iconImgView.mas_right).mas_equalTo(10);
//        make.height.equalTo(15);
        make.width.mas_lessThanOrEqualTo(150);
    }];
    _titleLb.font = [UIFont systemFontOfSize:16];
//    _titleLb.backgroundColor = [UIColor orangeColor];
    
    _messageLb = [[UILabel alloc] init];
    [self addSubview:_messageLb];
    [_messageLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLb.mas_left);
        make.top.mas_equalTo(self.titleLb.mas_bottom).mas_equalTo(8);
        make.width.mas_lessThanOrEqualTo(150);
//        make.height.equalTo(8);
    }];
    _messageLb.font = [UIFont systemFontOfSize:13];
    _messageLb.textColor = RGB(174, 174, 174);
//    _messageLb.backgroundColor = [UIColor redColor];
    
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    frame.origin.x += 10;
    frame.origin.y += 10;
    frame.size.height -= 10;
    frame.size.width -= 20;
    
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
