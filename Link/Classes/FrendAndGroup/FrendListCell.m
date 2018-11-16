//
//  FrendListCell.m
//  Link
//
//  Created by Surdot on 2018/5/18.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "FrendListCell.h"

@implementation FrendListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"frendList"];
    if (self) {
//        self.contentView.backgroundColor = [UIColor cyanColor];
        [self configLayoutOfCell];
    }
    return self;
}

- (void)configLayoutOfCell {
    _headerImg = [[UIImageView alloc] init];
    [self addSubview:_headerImg];
    [_headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthScale(12));
        make.top.mas_equalTo(kWidthScale(7));
        make.size.mas_equalTo(CGSizeMake(kWidthScale(50), kWidthScale(50)));
    }];
    _headerImg.image = [UIImage imageNamed:@"headerImg"];
    _headerImg.backgroundColor = [UIColor brownColor];
    
    _nameLb = [UILabel new];
    [self addSubview:_nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImg.mas_right).mas_equalTo(12);
        make.centerY.mas_equalTo(0);
        make.width.mas_lessThanOrEqualTo(200);
        make.height.mas_equalTo(kWidthScale(17));
    
    }];
    _nameLb.font = [UIFont systemFontOfSize:kWidthScale(17)];
    _nameLb.textColor = RGB(70, 70, 70);
    
    
    
}

//- (void)setFrame:(CGRect)frame {
//    frame.origin.x += 10;
//    frame.origin.y += 10;
//    frame.size.height -= 10;
//    frame.size.width -= 20;
//    [super setFrame:frame];
//}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
