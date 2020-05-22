//
//  GH_FinancingTextFieldView.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/12.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_FinancingTextFieldView.h"

@interface GH_FinancingTextFieldView ()
@property (nonatomic, strong)UILabel * titleLable;


@end

@implementation GH_FinancingTextFieldView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    [self addSubview:self.titleLable];
    [self addSubview:self.textField];
    [self addSubview:self.lineView];
    [self layout];
}

- (void)layout{
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).mas_offset(ZY_WidthScale(15));
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(ZY_WidthScale(109));
        make.right.top.bottom.equalTo(self);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(ZY_WidthScale(15));
        make.bottom.right.equalTo(self);
        make.height.equalTo(@(1));
    }];
}


-(void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    _titleLable.text = titleString;
}

-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    _textField.placeholder = placeholder;
}


- (UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [UILabel new];
        _titleLable.text = @"姓名";
        _titleLable.textColor = Colors(@"#333333");
        _titleLable.font = Fonts(16);
    }
    return _titleLable;
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [UITextField new];
        _textField.placeholder = @"请输入姓名";
        [_textField setValue:Colors(@"#B6B6B6") forKeyPath:@"_placeholderLabel.textColor"];
        [_textField setValue:Fonts(16) forKeyPath:@"_placeholderLabel.font"];
    }
    return _textField;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = Colors(@"#DEDDDD");
    }
    return _lineView;
}

@end
