//
//  GH_OrderDetailFooterView.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/17.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_OrderDetailFooterView.h"

@interface GH_OrderDetailFooterView ()<UITextFieldDelegate>
@property (nonatomic, strong)UITextField * textView;//输入框
@property (nonatomic, strong)UIImageView * weiXinSelectImage;//微信选中图片
@property (nonatomic, strong)UIImageView * zfbSelectImage;//支付宝选中图片
@property (nonatomic, copy)NSString * text;//备注信息
@property (nonatomic, assign)NSInteger payWay;//0是微信1是支付宝;

@property (nonatomic, strong)UIView * bg_TextFieldView;
@end

@implementation GH_OrderDetailFooterView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //默认是微信支付
        self.payWay = 0;
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    //黄色方框
    UIView * orangeView = [UIView new];
    orangeView.backgroundColor = Colors(@"#FFA425");
    [self addSubview:orangeView];
    [orangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(ZY_WidthScale(15));
        make.top.equalTo(self).mas_offset(ZY_HeightScale(21));
        make.width.equalTo(@(ZY_WidthScale(8)));
        make.height.equalTo(@(ZY_HeightScale(9)));
    }];
    //备注
    UILabel * beiZhuLabel = [UILabel new];
    beiZhuLabel.text = @"尾款";
    beiZhuLabel.textColor = Colors(@"#666666");
    beiZhuLabel.font = Fonts(15);
    [self addSubview:beiZhuLabel];
    [beiZhuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(orangeView.mas_right).mas_offset(ZY_WidthScale(6));
        make.top.equalTo(self).mas_offset(ZY_HeightScale(18));
    }];
    
    self.bg_TextFieldView = [UIView new];
    self.bg_TextFieldView.backgroundColor = Colors(@"#FEFBEF");
    self.bg_TextFieldView.layer.cornerRadius = ZY_WidthScale(20);
    self.bg_TextFieldView.clipsToBounds = YES;
    [self addSubview:self.bg_TextFieldView];
    [self.bg_TextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).mas_offset(ZY_WidthScale(15));
        make.width.equalTo(@(screenWidth - ZY_WidthScale(30)));
        make.top.equalTo(beiZhuLabel.mas_bottom).mas_offset(ZY_HeightScale(16));
        make.height.equalTo(@(ZY_HeightScale(40)));
    }];
    //输入框
    self.textView = [UITextField new];
    self.textView.placeholder = @"请输入需要支付的尾款";
    self.textView.textColor = Colors(@"#333333");
    self.textView.font = Fonts(15);
    self.textView.backgroundColor = Colors(@"#FEFBEF");
    self.textView.keyboardType = UIKeyboardTypeDecimalPad;
    [self.textView setValue:Colors(@"#333333") forKeyPath:@"_placeholderLabel.textColor"];
//    [self.textView setValue:[UIFont fontWithName:@"Helvetica-Bold" size:ZY_WidthScale(15)] forKeyPath:@"_placeholderLabel.font"];
    self.textView.delegate = self;
    
    [self.bg_TextFieldView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.bg_TextFieldView.mas_top);
        make.bottom.equalTo(self.bg_TextFieldView.mas_bottom);
        make.left.equalTo(self.bg_TextFieldView).mas_offset(ZY_WidthScale(14));
    }];
    
    //黄色方框
    UIView * orangeView1 = [UIView new];
    orangeView1.backgroundColor = Colors(@"#FFA425");
    [self addSubview:orangeView1];
    [orangeView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(ZY_WidthScale(15));
        make.top.equalTo(self.bg_TextFieldView.mas_bottom).mas_offset(ZY_HeightScale(19));
        make.width.equalTo(@(ZY_WidthScale(8)));
        make.height.equalTo(@(ZY_HeightScale(9)));
    }];
    
    //备注
    UILabel * payWayLabel = [UILabel new];
    payWayLabel.text = @"支付方式";
    payWayLabel.textColor = Colors(@"#666666");
    payWayLabel.font = Fonts(15);
    [self addSubview:payWayLabel];
    [payWayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(orangeView.mas_right).mas_offset(ZY_WidthScale(6));
        make.top.equalTo(self.bg_TextFieldView.mas_bottom).mas_offset(ZY_HeightScale(15));
    }];
    
    //微信支付按钮
    UIButton * weiXinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [weiXinButton addTarget:self action:@selector(weixinPay) forControlEvents:UIControlEventTouchDown];
    [self addSubview:weiXinButton];
    [weiXinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(payWayLabel.mas_bottom).mas_offset(ZY_HeightScale(8));
        make.height.equalTo(@(ZY_HeightScale(62)));
    }];
    
    UIImageView * weixinImage = [UIImageView new];
    weixinImage.image = Images(@"Pay_WeiXin");
    [weiXinButton addSubview:weixinImage];
    weixinImage.layer.cornerRadius = ZY_WidthScale(15);
    weixinImage.clipsToBounds = YES;
    [weixinImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weiXinButton);
        make.left.equalTo(weiXinButton).mas_offset(ZY_WidthScale(29));
        make.width.height.equalTo(@(ZY_WidthScale(30)));
    }];
    
    UILabel * weixinLable = [UILabel new];
    weixinLable.text = @"微信支付";
    weixinLable.textColor = Colors(@"#4C4C4C");
    weixinLable.font = Fonts(16);
    [weiXinButton addSubview:weixinLable];
    [weixinLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weiXinButton);
        make.left.equalTo(weixinImage.mas_right).mas_offset(ZY_WidthScale(18));
    }];
    
    self.weiXinSelectImage = [UIImageView new];
    self.weiXinSelectImage.image = Images(@"My_SelectSex");
    [weiXinButton addSubview:self.weiXinSelectImage];
    [self.weiXinSelectImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weiXinButton);
        make.right.equalTo(weiXinButton.mas_right).mas_offset(-ZY_WidthScale(30));
        make.width.equalTo(@(ZY_WidthScale(17)));
        make.height.equalTo(@(ZY_HeightScale(12)));
    }];
    
    //支付宝支付
    UIButton * zfbButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [zfbButton addTarget:self action:@selector(zfbPay) forControlEvents:UIControlEventTouchDown];
    [self addSubview:zfbButton];
    [zfbButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(weiXinButton.mas_bottom);
        make.height.equalTo(@(ZY_HeightScale(62)));
    }];
    UIImageView * zfbImage = [UIImageView new];
    zfbImage.image = Images(@"Pay_ZFB");
    [zfbButton addSubview:zfbImage];
    zfbImage.layer.cornerRadius = ZY_WidthScale(15);
    zfbImage.clipsToBounds = YES;
    [zfbImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(zfbButton);
        make.left.equalTo(zfbButton).mas_offset(ZY_WidthScale(29));
        make.width.height.equalTo(@(ZY_WidthScale(30)));
    }];
    
    UILabel * zfbLable = [UILabel new];
    zfbLable.text = @"支付宝支付";
    zfbLable.textColor = Colors(@"#4C4C4C");
    zfbLable.font = Fonts(16);
    [zfbButton addSubview:zfbLable];
    [zfbLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(zfbButton);
        make.left.equalTo(zfbImage.mas_right).mas_offset(ZY_WidthScale(18));
    }];
    
    self.zfbSelectImage = [UIImageView new];
    self.zfbSelectImage.image = Images(@"Pay_NoSelect");
    [zfbButton addSubview:self.zfbSelectImage];
    [self.zfbSelectImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(zfbButton);
        make.right.equalTo(zfbButton.mas_right).mas_offset(-ZY_WidthScale(30));
        make.width.height.equalTo(@(ZY_WidthScale(21)));
    }];
    
    //支付f按钮
    UIButton * payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CAGradientLayer *  gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"#BC94FE"].CGColor,(__bridge id)[UIColor colorWithHexString:@"#856EF9"].CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0,  ZY_WidthScale(299),  ZY_HeightScale(50));
    [payButton.layer addSublayer:gradientLayer];
    payButton.layer.cornerRadius = ZY_WidthScale(25);
    payButton.clipsToBounds = YES;
    [payButton setTitle:@"支付" forState:UIControlStateNormal];
    [payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    payButton.titleLabel.font = Fonts(18);
    [payButton addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchDown];
    [self addSubview:payButton];
    [payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(zfbButton.mas_bottom).mas_offset(ZY_HeightScale(29));
        make.height.equalTo(@(ZY_HeightScale(50)));
        make.width.equalTo(@(ZY_WidthScale(299)));
    }];
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.text = textField.text;
}

//微信支付
- (void)weixinPay{
    self.weiXinSelectImage.image = Images(@"My_SelectSex");
    self.zfbSelectImage.image = Images(@"Pay_NoSelect");
    [self.weiXinSelectImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(ZY_WidthScale(17)));
        make.height.equalTo(@(ZY_HeightScale(12)));
    }];
    [self.zfbSelectImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(ZY_WidthScale(21)));
    }];
    self.payWay = 0;
}
//支付宝
- (void)zfbPay{
    self.zfbSelectImage.image = Images(@"My_SelectSex");
    self.weiXinSelectImage.image = Images(@"Pay_NoSelect");
    self.payWay = 1;
    [self.zfbSelectImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(ZY_WidthScale(17)));
        make.height.equalTo(@(ZY_HeightScale(12)));
    }];
    [self.weiXinSelectImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(ZY_WidthScale(21)));
    }];
}



//支付
- (void)pay{
    [self.textView resignFirstResponder];
    if (self.block) {
        self.block(self.text, self.payWay);
    }
}


@end
