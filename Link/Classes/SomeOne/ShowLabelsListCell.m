//
//  ShowLabelsListCell.m
//  Link
//
//  Created by Surdot on 2018/7/10.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "ShowLabelsListCell.h"

@implementation ShowLabelsListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configLayoutCell];
    }
    return self;
}
- (void)configLayoutCell {
    _titleLb = [UILabel new];
    [self addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(10);
        make.left.equalTo(15);
        make.width.greaterThanOrEqualTo(10);
        make.height.equalTo(17);
    }];
    _titleLb.textColor = RGB(134, 134, 134);
    _titleLb.text = @"我的背景";
    
//    _MycontentView = [[SCTagView alloc] init];
//    [self addSubview:_MycontentView];
//    [_MycontentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.bottom.right.equalTo(0);
//        make.top.equalTo(self.titleLb.mas_bottom);
//    }];
//    _MycontentView.backgroundColor = [UIColor cyanColor];
    
    _MycontentView = [[SCTagView alloc] initWithFrame:CGRectMake(0, kWidthScale(17) +12, ScreenW, 58-kWidthScale(17))];
    [self addSubview:_MycontentView];
//    _MycontentView.backgroundColor = [UIColor cyanColor];
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
