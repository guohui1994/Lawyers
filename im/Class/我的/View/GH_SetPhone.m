//
//  GH_SetPhone.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/12.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_SetPhone.h"

@interface GH_SetPhone ()<UITextFieldDelegate>
@property (nonatomic, strong)UILabel * phoneLable;//手机号

@property (nonatomic, strong)UILabel * codeLable;//t验证码


@property (nonatomic, strong)UIView * lineView;//分割线
@end

@implementation GH_SetPhone

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    [self addSubview:self.phoneLable];
    [self addSubview:self.phoneTextField];
    [self addSubview:self.codeLable];
    [self addSubview:self.codeTextField];
    [self addSubview:self.getCodeButton];
    [self addSubview:self.lineView];
    [self layout];
}

- (void)layout{
    [self.phoneLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(ZY_WidthScale(35));
        make.top.equalTo(self).mas_equalTo(ZY_HeightScale(22));
        make.width.equalTo(@(ZY_WidthScale(60)));
    }];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneLable.mas_right).mas_offset(ZY_WidthScale(15));
        make.centerY.equalTo(self.phoneLable);
        make.height.equalTo(@(60));
        make.right.equalTo(self);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(ZY_WidthScale(35));
        make.bottom.equalTo(self.phoneTextField);
        make.right.equalTo(self);
    }];
    
    [self.codeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerX.equalTo(self.phoneLable);
        make.top.equalTo(self.phoneLable.mas_bottom).mas_offset(ZY_HeightScale(45));
    }];
    
    [self.getCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).mas_equalTo(-ZY_WidthScale(21));
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(@(ZY_HeightScale(60)));
        make.width.equalTo(@(ZY_WidthScale(100)));
    }];
    
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.equalTo(self.phoneTextField);
        make.right.equalTo(self.getCodeButton.mas_left).mas_offset(-ZY_WidthScale(10));
        make.centerY.equalTo(self.codeLable);
    }];
    
}

- (UILabel *)phoneLable{
    if (!_phoneLable) {
        _phoneLable = [UILabel new];
        _phoneLable.text = @"手机号";
        _phoneLable.font = Fonts(16);
        _phoneLable.textColor = Colors(@"#333333");
    }
    return _phoneLable;
}
- (UILabel *)codeLable{
    if (!_codeLable) {
        _codeLable = [UILabel new];
        _codeLable = [UILabel new];
        _codeLable.text = @"验证码";
        _codeLable.font = Fonts(16);
        _codeLable.textColor = Colors(@"#333333");
    }
    return _codeLable;
}

- (UITextField *)phoneTextField{
    if (!_phoneTextField) {
        _phoneTextField = [UITextField new];
        _phoneTextField.delegate = self;
        _phoneTextField.placeholder = @"请输入手机号";
    }
    return _phoneTextField;
}

- (UITextField *)codeTextField{
    if (!_codeTextField) {
        _codeTextField = [UITextField new];
        _codeTextField.delegate = self;
        _codeTextField.placeholder = @"请输入验证码";
    }
    return _codeTextField;
}

- (UIButton *)getCodeButton{
    if (!_getCodeButton) {
        _getCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCodeButton setTitleColor:Colors(@"#616CF2") forState:UIControlStateNormal];
       
        _getCodeButton.titleLabel.font = Fonts(16);
    }
    return _getCodeButton;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = Colors(@"#DEDDDD");
    }
    return _lineView;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.phoneTextField) {
        if (self.block) {
            self.block(textField.text);
        }
    }else{
        if (self.block1) {
            self.block1(textField.text);
        }
    }
}



@end
