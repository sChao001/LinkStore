//
//  NewsImageOneCell.m
//  Link
//
//  Created by Surdot on 2018/6/15.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "NewsImageOneCell.h"

@implementation NewsImageOneCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configCellLayout];
    }
    return self;
}
- (void)configCellLayout {
    _showImg = [[UIImageView alloc] init];
    [self addSubview:_showImg];
    [_showImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-8);
//        make.top.equalTo(12);
//        make.right.bottom.equalTo(-8);
        make.size.equalTo(CGSizeMake(105, 66));
        make.centerY.equalTo(0);
    }];
//    _showImg.backgroundColor = [UIColor brownColor];
    _showImg.image = [UIImage imageNamed:@"y_infoPlace"];
    _showImg.contentMode = UIViewContentModeScaleAspectFill;
    _showImg.clipsToBounds = YES;
    
    _titleLb = [[UILabel alloc] init];
    [self addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
//        make.centerY.equalTo(0);
        make.top.equalTo(19);
        make.right.equalTo(self.showImg.mas_left).equalTo(-8);
    }];
//    _titleLb.backgroundColor = [UIColor cyanColor];
    _titleLb.numberOfLines = 0;
    _titleLb.font = [UIFont systemFontOfSize:17];
    
    _sourceLb = [[UILabel alloc] init];
    [self addSubview:_sourceLb];
    [_sourceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLb.mas_left);
//        make.bottom.equalTo(-9);
        make.width.lessThanOrEqualTo(60);
        make.top.equalTo(self.titleLb.mas_bottom).equalTo(12);
    }];
    _sourceLb.font = [UIFont systemFontOfSize:10];
//    _sourceLb.text = @"搜狐网";
    _sourceLb.textColor = ColorHex(@"989898");
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
