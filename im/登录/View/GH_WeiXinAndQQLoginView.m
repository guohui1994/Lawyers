//
//  GH_WeiXinAndQQLoginView.m
//  AudioChang
//
//  Created by ZhiYuan on 2019/9/6.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_WeiXinAndQQLoginView.h"

@interface GH_WeiXinAndQQLoginView ()
@property (nonatomic, strong)UIView * lineView1;
@property (nonatomic, strong)UIView * lineView2;
@property (nonatomic, strong)UILabel * titleLable;//一键登录lable
@property (nonatomic, strong)UIButton * weiXinButton;//微信登录
@property (nonatomic, strong)UIButton * QQButton;//QQ登录
@property (nonatomic, strong)UIButton * phoneButton;//手机登录
@end

@implementation GH_WeiXinAndQQLoginView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    [self addSubview:self.lineView1];
    [self addSubview:self.lineView2];
    [self addSubview:self.titleLable];
    [self addSubview:self.weiXinButton];
    [self addSubview:self.QQButton];
    [self addSubview:self.phoneButton];
    [self layout];
}

- (void)layout{
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.top.equalTo(self);
      
    }];
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLable);
        make.right.equalTo(self.titleLable.mas_left).mas_offset(-ZY_WidthScale(12));
        make.width.equalTo(@(ZY_WidthScale(83)));
        make.height.equalTo(@(1));
    }];
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLable);
        make.left.equalTo(self.titleLable.mas_right).mas_offset(ZY_WidthScale(12));
        make.width.equalTo(@(ZY_WidthScale(83)));
        make.height.equalTo(@(1));
    }];
    
    
    [self.QQButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.titleLable.mas_bottom).mas_offset(ZY_HeightScale(46));
        make.width.height.equalTo(@(ZY_WidthScale(55)));
    }];
    
    [self.weiXinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.QQButton);
        make.right.equalTo(self.QQButton.mas_left).mas_offset(-ZY_WidthScale(32));
        make.width.height.equalTo(@(ZY_WidthScale(55)));
    }];
    [self.phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.QQButton);
        make.left.equalTo(self.QQButton.mas_right).mas_offset(ZY_WidthScale(32));
        make.width.height.equalTo(@(ZY_WidthScale(55)));
    }];
    
}

- (UIView *)lineView1{
    if (!_lineView1) {
        _lineView1 = [UIView new];
        _lineView1.backgroundColor = Colors(@"#BAB9B9");
    }
    return _lineView1;
}
- (UIView *)lineView2{
    if (!_lineView2) {
        _lineView2 = [UIView new];
        _lineView2.backgroundColor = Colors(@"#BAB9B9");
    }
    return _lineView2;
}
- (UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [UILabel new];
        _titleLable.text = @"一键极速登陆";
        _titleLable.font = Fonts(15);
        _titleLable.textColor = Colors(@"#666666");
        _titleLable.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLable;
}

- (UIButton *)weiXinButton{
    if (!_weiXinButton) {
        _weiXinButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _weiXinButton.layer.cornerRadius = ZY_WidthScale(27.5);
        [_weiXinButton addTarget:self action:@selector(weiXinLogin) forControlEvents:UIControlEventTouchDown];
        _weiXinButton.clipsToBounds = YES;
        [_weiXinButton setImage:Images(@"Login_WeiXin") forState:UIControlStateNormal];
    }
    return _weiXinButton;
}

- (UIButton *)QQButton{
    if (!_QQButton) {
        _QQButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _QQButton.layer.cornerRadius = ZY_WidthScale(27.5);
        [_QQButton addTarget:self action:@selector(QQLogin) forControlEvents:UIControlEventTouchDown];
        _QQButton.clipsToBounds = YES;
        [_QQButton setImage:Images(@"Login_QQ") forState:UIControlStateNormal];
    }
    return _QQButton;
}

- (UIButton *)phoneButton{
    if (!_phoneButton) {
        _phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _phoneButton.layer.cornerRadius = ZY_WidthScale(27.5);
        [_phoneButton addTarget:self action:@selector(PhoneLogin) forControlEvents:UIControlEventTouchDown];
        _phoneButton.clipsToBounds = YES;
        [_phoneButton setImage:Images(@"Login_Phone") forState:UIControlStateNormal];
    }
    return _phoneButton;
}

- (void)weiXinLogin{
    if (self.block) {
        self.block(0);
    }
}
- (void)QQLogin{
    if (self.block) {
        self.block(1);
    }
}

- (void)PhoneLogin{
    if (self.block) {
        self.block(2);
    }
}

@end
