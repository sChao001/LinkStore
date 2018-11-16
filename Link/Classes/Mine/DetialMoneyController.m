//
//  DetialMoneyController.m
//  Link
//
//  Created by Surdot on 2018/8/27.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "DetialMoneyController.h"

@interface DetialMoneyController ()
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *moneyLb;
@property (nonatomic, strong) UILabel *successLb;
@property (nonatomic, strong) UILabel *dindan;
@property (nonatomic, strong) UILabel *dindanMoney;
@property (nonatomic, strong) UIView *lineOne;
@property (nonatomic, strong) UIView *lineTwo;
@property (nonatomic, strong) UILabel *payTypeLb;
@property (nonatomic, strong) UILabel *payDetial;
@property (nonatomic, strong) UILabel *tradeLb;
@property (nonatomic, strong) UILabel *tradeDetial;
@property (nonatomic, strong) UIView *lineThree;
@property (nonatomic, strong) UILabel *tradeNo;
@property (nonatomic, strong) UILabel *tradeNoDetial;
@end

@implementation DetialMoneyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ColorHex(@"f5f5f2");
    self.title = @"收款详情";
    [self setCommonLeftBarButtonItem];
    [self configLayoutOfView];
    NSLog(@"%@  %@  %@ %@ %@", _nameTitle, _moneyStr, _myType, _myTradeTime, _myTradeNo);
}

- (void)configLayoutOfView {
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    [self.view addSubview:_contentView];
    _contentView.backgroundColor = [UIColor whiteColor];
    
    _titleLb = [[UILabel alloc] init];
    [self.contentView addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.width.lessThanOrEqualTo(100);
        make.height.equalTo(15);
        make.top.equalTo(28);
    }];
    _titleLb.text = _nameTitle;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = ColorHex(@"282828");
    
    _moneyLb = [[UILabel alloc] init];
    [self.contentView addSubview:_moneyLb];
    [_moneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(90);
        make.width.lessThanOrEqualTo(200);
        make.height.equalTo(28);
    }];
    _moneyLb.font = [UIFont systemFontOfSize:kWidthScale(28)];
    _moneyLb.textColor = ColorHex(@"282828");
    _moneyLb.text = [NSString stringWithFormat:@"+%@", _moneyStr];
    
    _successLb = [[UILabel alloc] init];
    [self.contentView addSubview:_successLb];
    [_successLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(self.moneyLb.mas_bottom).equalTo(20);
        make.width.greaterThanOrEqualTo(10);
        make.height.equalTo(12);
    }];
    _successLb.textColor = ColorHex(@"989898");
    _successLb.font = [UIFont systemFontOfSize:12];
    _successLb.text = @"交易成功";
    
    _lineOne = [[UIView alloc] init];
    [_contentView addSubview:_lineOne];
    [_lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.successLb.mas_bottom).equalTo(104);
        make.left.equalTo(17);
        make.height.equalTo(1);
        make.right.equalTo(-17);
    }];
    _lineOne.backgroundColor = ColorHex(@"e2e2e2");
    
    _dindan = [[UILabel alloc] init];
    [self.contentView addSubview:_dindan];
    [_dindan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lineOne.mas_left);
        make.bottom.equalTo(self.lineOne.mas_top).equalTo(-16);
        make.width.greaterThanOrEqualTo(10);
        make.height.equalTo(13);
    }];
    _dindan.text = @"订单金额";
    _dindan.textColor = ColorHex(@"282828");
    _dindan.font = [UIFont systemFontOfSize:13];
    
    _dindanMoney = [[UILabel alloc] init];
    [_contentView addSubview:_dindanMoney];
    [_dindanMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lineOne.mas_right);
        make.bottom.equalTo(self.lineOne.mas_top).equalTo(-16);
        make.height.equalTo(13);
        make.width.greaterThanOrEqualTo(10);
    }];
    _dindanMoney.textColor = ColorHex(@"989898");
    _dindanMoney.font = [UIFont systemFontOfSize:13];
    _dindanMoney.text = _moneyStr;
    
    _lineTwo = [[UIView alloc] init];
    [_contentView addSubview:_lineTwo];
    [_lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineOne.mas_bottom).equalTo(45);
        make.height.equalTo(1);
        make.left.equalTo(17);
        make.right.equalTo(-17);
    }];
    _lineTwo.backgroundColor = ColorHex(@"e2e2e2");
    
    _payTypeLb = [[UILabel alloc] init];
    [_contentView addSubview:_payTypeLb];
    [_payTypeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(17);
        make.top.equalTo(self.lineOne.mas_bottom).equalTo(16);
        make.width.greaterThanOrEqualTo(10);
        make.height.equalTo(13);
    }];
    _payTypeLb.text = @"付款方式";
    _payTypeLb.textColor = ColorHex(@"282828");
    _payTypeLb.font = [UIFont systemFontOfSize:13];
    
    _payDetial = [[UILabel alloc] init];
    [_contentView addSubview:_payDetial];
    [_payDetial mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-17);
        make.top.equalTo(self.lineOne.mas_bottom).equalTo(16);
        make.width.greaterThanOrEqualTo(10);
        make.height.equalTo(13);
    }];
    _payDetial.textColor = ColorHex(@"989898");
    _payDetial.text = _myType;
    _payDetial.font = [UIFont systemFontOfSize:13];
    
    _tradeLb = [[UILabel alloc] init];
    [_contentView addSubview:_tradeLb];
    [_tradeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(17);
        make.top.equalTo(self.lineTwo.mas_bottom).equalTo(16);
        make.width.greaterThanOrEqualTo(10);
        make.height.equalTo(13);
    }];
    _tradeLb.text = @"交易时间";
    _tradeLb.textColor = ColorHex(@"282828");
    _tradeLb.font = [UIFont systemFontOfSize:13];
    
    _tradeDetial = [[UILabel alloc] init];
    [self.contentView addSubview:_tradeDetial];
    [_tradeDetial mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-17);
        make.top.equalTo(self.lineTwo.mas_bottom).equalTo(16);
        make.width.greaterThanOrEqualTo(10);
        make.height.equalTo(13);
    }];
    _tradeDetial.text = _myTradeTime;
    _tradeDetial.textColor = ColorHex(@"989898");
    _tradeDetial.font = [UIFont systemFontOfSize:13];
    
    _lineThree = [[UIView alloc] init];
    [self.contentView addSubview:_lineThree];
    [_lineThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(17);
        make.top.equalTo(self.lineTwo.mas_bottom).equalTo(45);
        make.height.equalTo(1);
        make.right.equalTo(-17);
    }];
    _lineThree.backgroundColor = ColorHex(@"e2e2e2");
    
    _tradeNo = [[UILabel alloc] init];
    [self.contentView addSubview:_tradeNo];
    [_tradeNo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(17);
        make.top.equalTo(self.lineThree.mas_bottom).equalTo(16);
        make.width.greaterThanOrEqualTo(10);
        make.height.equalTo(13);
    }];
    _tradeNo.textColor = ColorHex(@"282828");
    _tradeNo.font = [UIFont systemFontOfSize:13];
    _tradeNo.text = @"交易号";
    
    _tradeNoDetial = [[UILabel alloc] init];
    [self.contentView addSubview:_tradeNoDetial];
    [_tradeNoDetial mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-17);
        make.top.equalTo(self.lineThree.mas_bottom).equalTo(16);
        make.width.greaterThanOrEqualTo(10);
        make.height.equalTo(13);
    }];
    _tradeNoDetial.textColor = ColorHex(@"989898");
    _tradeNoDetial.text = _myTradeNo;
    _tradeNoDetial.font = [UIFont systemFontOfSize:13];
    
    
}

//- (void)requestDetialData {
//    NSLog(@"%@", _payId);
//    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"payId" : _payId};
//    [SCNetwork postWithURLString:BDUrl_s(@"payhistory/getPayHistory") parameters:paramet success:^(NSDictionary *dic) {
//        if ([dic[@"code"] integerValue] > 0) {
//            NSLog(@"%@", dic);
//            _titleLb.text = dic[@""];
//        }
//
//
//    } failure:^(NSError *error) {
//        [SVProgressHUD showWithStatus:@"网络连接失败"];
//        [SVProgressHUD dismissWithDelay:0.7];
//    }];
//}

@end
