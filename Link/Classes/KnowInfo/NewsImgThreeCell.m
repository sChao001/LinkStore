//
//  NewsImgThreeCell.m
//  Link
//
//  Created by Surdot on 2018/6/19.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "NewsImgThreeCell.h"

@implementation NewsImgThreeCell
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
        make.right.equalTo(-15);
    }];
    _titleLb.numberOfLines = 0;
    
    _imageLeft = [[UIImageView alloc] init];
    [self addSubview:_imageLeft];
    [_imageLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
//        make.bottom.equalTo(-26);
        make.top.equalTo(self.titleLb.mas_bottom).equalTo(11);
        make.height.equalTo(78);
        make.width.equalTo((ScreenW-36)/3);
    }];
//    _imageLeft.backgroundColor = [UIColor brownColor];
    _imageLeft.image = [UIImage imageNamed:@"y_infoPlace"];
    _imageLeft.contentMode = UIViewContentModeScaleAspectFill;
    _imageLeft.clipsToBounds = YES;
    
    _imageCenter = [[UIImageView alloc] init];
    [self addSubview:_imageCenter];
    [_imageCenter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageLeft.mas_right).equalTo(2);
        make.top.equalTo(self.imageLeft.mas_top);
        make.height.equalTo(78);
        make.width.equalTo((ScreenW-36)/3);
    }];
//    _imageCenter.backgroundColor = [UIColor brownColor];
    _imageCenter.image = [UIImage imageNamed:@"y_infoPlace"];
    _imageCenter.contentMode = UIViewContentModeScaleAspectFill;
    _imageCenter.clipsToBounds = YES;
    
    _imageRight = [[UIImageView alloc] init];
    [self addSubview:_imageRight];
    [_imageRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-15);
        make.top.equalTo(self.imageCenter.mas_top);
        make.height.equalTo(78);
        make.width.equalTo((ScreenW-36)/3);
    }];
//    _imageRight.backgroundColor = [UIColor orangeColor];
    _imageRight.image = [UIImage imageNamed:@"y_infoPlace"];
    _imageRight.contentMode = UIViewContentModeScaleAspectFill;
    _imageRight.clipsToBounds = YES;
    
    _sourceLb = [[UILabel alloc] init];
    [self addSubview:_sourceLb];
    [_sourceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageLeft.mas_bottom).equalTo(9);
        make.left.equalTo(self.imageLeft.mas_left);
        make.height.equalTo(10);
        make.bottom.equalTo(-7);
    }];
    _sourceLb.text = @"悟空问答";
    _sourceLb.font = [UIFont systemFontOfSize:10];
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
