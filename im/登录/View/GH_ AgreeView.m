//
//  GH_ AgreeView.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/16.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_ AgreeView.h"

@implementation GH__AgreeView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    UILabel * agreeLable = [UILabel new];
    agreeLable.text = @"注册即表示阅读同意";
    agreeLable.textColor = Colors(@"#999999");
    agreeLable.font = Fonts(15);
    [self addSubview:agreeLable];
    [agreeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
    }];
    UIButton * agreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [agreeButton setTitle:@"《用户注册协议》" forState:UIControlStateNormal];
    [agreeButton setTitleColor:Colors(@"#FFA425") forState:UIControlStateNormal];
    agreeButton.titleLabel.font = Fonts(15);
    [agreeButton addTarget:self action:@selector(agree) forControlEvents:UIControlEventTouchDown];
    [self addSubview:agreeButton];
    [agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(agreeLable.mas_right);
        make.centerY.equalTo(agreeLable);
    }];
}

- (void)agree{
    if (self.block) {
        self.block();
    }
}

@end
