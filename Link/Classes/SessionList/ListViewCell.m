//
//  ListViewCell.m
//  Link
//
//  Created by Surdot on 2018/5/17.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "ListViewCell.h"

@implementation ListViewCell

- (instancetype)initWithFrame:(CGRect)frame  {
    self = [super initWithFrame:frame];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x += 10;
    frame.origin.y += 10;
    frame.size.height -= 10;
    frame.size.width -= 20;
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
