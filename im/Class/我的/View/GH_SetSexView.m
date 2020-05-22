//
//  GH_SetSexView.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/12.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_SetSexView.h"


@interface GH_SetSexView ()
@property (nonatomic, strong)UIImageView * manImageView;//男性image
@property (nonatomic, strong)UIImageView * womanImageVIew;//选择女性的image
@end

@implementation GH_SetSexView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
//创建视图
- (void)creatUI{
    NSArray * sexArray = @[@"男", @"女"];
    for (int i = 0; i < 2; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:button];
        button.frame = CGRectMake(0, ZY_HeightScale(60) * i, screenWidth, ZY_HeightScale(60));
        button.tag = 10000 + i;
        [button addTarget:self action:@selector(selectSex:) forControlEvents:UIControlEventTouchDown];
        UILabel * sexLable = [UILabel new];
        sexLable.text = sexArray[i];
        [button addSubview:sexLable];
        [sexLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(button);
            make.left.equalTo(button).mas_offset(ZY_WidthScale(35));
        }];
        
        if (i == 0) {
            self.manImageView = [UIImageView new];
            self.manImageView.image = Images(@"My_SelectSex");
            self.manImageView.hidden = YES;
            [button addSubview:self.manImageView];
            [self.manImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(button.mas_right).mas_offset(-ZY_WidthScale(20));
                make.centerY.equalTo(button);
                make.width.equalTo(@(ZY_WidthScale(17)));
                make.height.equalTo(@(ZY_HeightScale(12)));
            }];
            
            
            
        }else{
            self.womanImageVIew = [UIImageView new];
            self.womanImageVIew.image = Images(@"My_SelectSex");
            self.womanImageVIew.hidden = YES;
            [button addSubview:self.womanImageVIew];
            [self.womanImageVIew mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(button.mas_right).mas_offset(-ZY_WidthScale(20));
                make.centerY.equalTo(button);
                make.width.equalTo(@(ZY_WidthScale(17)));
                make.height.equalTo(@(ZY_HeightScale(12)));
            }];
        }
    }
    
    UIView * lineView = [UIView new];
    lineView.backgroundColor = Colors(@"#DEDDDD");
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(ZY_WidthScale(35));
        make.centerY.right.equalTo(self);
        make.height.equalTo(@(1));
    }];
}

- (void)setSexString:(NSString *)sexString{
    _sexString = sexString;
    if ([sexString isEqualToString:@"男"]) {
        self.manImageView.hidden = NO;
        self.womanImageVIew.hidden = YES;
    }else{
        self.manImageView.hidden = YES;
        self.womanImageVIew.hidden = NO;
    }
}


- (void)selectSex:(UIButton *)sender{
    if (sender.tag -10000 == 0) {
        self.womanImageVIew.hidden = YES;
        self.manImageView.hidden = NO;
    }else{
        self.womanImageVIew.hidden = NO;
        self.manImageView.hidden = YES;
    }
    
    if (self.block) {
        self.block(sender.tag - 10000);
    }
}

@end
