//
//  GH_FinancingCardView.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/12.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_FinancingCardView.h"

@interface GH_FinancingCardView ()

//@property (nonatomic, strong)UIButton * forwardButton;//正面照
//@property (nonatomic, strong)UIButton * backButton;//反面照
@property (nonatomic, strong)UILabel * cardLabel;
@end


@implementation GH_FinancingCardView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    [self addSubview:self.cardLabel];
    [self addSubview:self.forwardButton];
    [self addSubview:self.backButton];
    [self layout];
}

- (void)layout{
    [self.cardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(ZY_WidthScale(15));
        make.top.equalTo(self).mas_offset(ZY_HeightScale(23));
    }];
    
    [self.forwardButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.cardLabel.mas_bottom).mas_offset(ZY_HeightScale(23));
        make.width.equalTo(@(236));
        make.height.equalTo(@(150));
    }];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.forwardButton.mas_bottom).mas_offset(ZY_HeightScale(20));
        make.width.height.equalTo(self.forwardButton);
    }];
}

- (UILabel *)cardLabel{
    if (!_cardLabel) {
        _cardLabel = [UILabel new];
        _cardLabel.text = @"身份证照片";
        _cardLabel.textColor = Colors(@"#333333");
        _cardLabel.font = Fonts(16);
    }
    return _cardLabel;
}

- (UIButton *)backButton{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:Images(@"My_Card_Back") forState:UIControlStateNormal];
        _backButton.layer.cornerRadius = 10;
        _backButton.clipsToBounds = YES;
    }
    return _backButton;
}

- (UIButton *)forwardButton{
    if (!_forwardButton) {
        _forwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forwardButton setImage:Images(@"My_Card_Forward") forState:UIControlStateNormal];
        _forwardButton.layer.cornerRadius = 10;
        _forwardButton.clipsToBounds = YES;
    }
    return _forwardButton;
}

@end
