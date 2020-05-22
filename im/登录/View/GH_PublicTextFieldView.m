//
//  GH_PublicTextFieldView.m
//  AudioChang
//
//  Created by ZhiYuan on 2019/9/6.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_PublicTextFieldView.h"

@interface GH_PublicTextFieldView ()<UITextFieldDelegate>
@property (nonatomic, strong)UIImageView * headerImageView;
@property (nonatomic, strong)UITextField * textField;
@end

@implementation GH_PublicTextFieldView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame headerImage:(NSString *)headerImage placeholder:(nonnull NSString *)placeholder {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
        self.backgroundColor = Colors(@"#F4F4F4");
        self.layer.cornerRadius = ZY_WidthScale(28);
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        self.headerImageView.image = [UIImage imageNamed:headerImage];
        self.textField.attributedPlaceholder = [GH_Tools attributedStringWithString:placeholder color:@"#AFAEAE" font:17 length:placeholder.length];
    }
    return self;
}



- (void)creatUI{
    [self addSubview:self.headerImageView];
    [self addSubview:self.textField];
    [self layout];
}

- (void)layout{
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).mas_offset(ZY_WidthScale(31));
//        make.width.equalTo(@(ZY_WidthScale(18)));
//        make.height.equalTo(@(ZY_HeightScale(21)));
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.headerImageView.mas_right).mas_offset(ZY_WidthScale(30));
        make.height.equalTo(@(ZY_HeightScale(40)));
        make.width.equalTo(@(ZY_WidthScale(170)));
    }];
}


- (void)setRegisterFirstRespoder:(BOOL)registerFirstRespoder{
    _registerFirstRespoder = registerFirstRespoder;
    if (_registerFirstRespoder == YES) {
        [_textField resignFirstResponder];
    }
}
- (void)setText:(NSString *)text{
    _text = text;
    _textField.text = text;
}

- (void)setWidth:(CGFloat)width{
    _width = width;
    [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(ZY_WidthScale(width)));
    }];
}

- (void)setIsScreat:(BOOL)isScreat{
    _isScreat = isScreat;
    self.textField.secureTextEntry = isScreat;
}

#pragma maek _--懒加载
- (UIImageView *)headerImageView{
    if (!_headerImageView) {
        _headerImageView = [UIImageView new];
        
    }
    return  _headerImageView;
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [UITextField new];
        _textField.placeholder = @"请输入手机号";
        _textField.delegate = self;
//        [_textField setValue:Colors(@"#AFAEAE") forKeyPath:@"_placeholderLabel.textColor"];
//        [_textField setValue:[UIFont systemFontOfSize:ZY_WidthScale(17)] forKeyPath:@"_placeholderLabel.font"];
    }
    return _textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.block) {
        self.block(textField);
    }
}

@end
