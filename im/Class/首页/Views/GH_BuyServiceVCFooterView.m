//
//  GH_BuyServiceVCFooterView.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/16.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_BuyServiceVCFooterView.h"

@interface GH_BuyServiceVCFooterView ()<UITextViewDelegate>
@property (nonatomic, strong)UITextView * textView;//输入框
@property (nonatomic, strong)UIImageView * weiXinSelectImage;//微信选中图片
@property (nonatomic, strong)UIImageView * zfbSelectImage;//支付宝选中图片
@property (nonatomic, copy)NSString * text;//备注信息
@property (nonatomic, assign)NSInteger payWay;//0是微信1是支付宝;
@property (nonatomic, strong) UIButton * payButton;//支付button;
@end

@implementation GH_BuyServiceVCFooterView

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
        make.top.equalTo(self).mas_offset(ZY_HeightScale(9));
        make.width.equalTo(@(ZY_WidthScale(8)));
        make.height.equalTo(@(ZY_HeightScale(9)));
    }];
    //备注
    UILabel * beiZhuLabel = [UILabel new];
    beiZhuLabel.text = @"备注";
    beiZhuLabel.textColor = Colors(@"#666666");
    beiZhuLabel.font = Fonts(15);
    [self addSubview:beiZhuLabel];
    [beiZhuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(orangeView.mas_right).mas_offset(ZY_WidthScale(6));
        make.top.equalTo(self).mas_offset(ZY_HeightScale(7));
    }];
    
    //输入框
    self.textView = [UITextView new];
    self.textView.text = @"请输入备注信息";
    self.textView.textColor = Colors(@"#999999");
    self.textView.font = Fonts(15);
    self.textView.backgroundColor = Colors(@"#FEFBEF");
    self.textView.delegate = self;
    [self addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(ZY_WidthScale(15));
        make.right.equalTo(self.mas_right).mas_offset(-ZY_WidthScale(15));
        make.top.equalTo(beiZhuLabel.mas_bottom).mas_offset(ZY_HeightScale(16));
        make.height.equalTo(@(ZY_HeightScale(81)));
    }];
    
    //黄色方框
    UIView * orangeView1 = [UIView new];
    orangeView1.backgroundColor = Colors(@"#FFA425");
    [self addSubview:orangeView1];
    [orangeView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(ZY_WidthScale(15));
        make.top.equalTo(self.textView.mas_bottom).mas_offset(ZY_HeightScale(17));
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
        make.top.equalTo(self.textView.mas_bottom).mas_offset(ZY_HeightScale(15));
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
    self.payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CAGradientLayer *  gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"#BC94FE"].CGColor,(__bridge id)[UIColor colorWithHexString:@"#856EF9"].CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0,  ZY_WidthScale(299),  ZY_HeightScale(50));
    [self.payButton.layer addSublayer:gradientLayer];
    self.payButton.layer.cornerRadius = ZY_WidthScale(25);
    self.payButton.clipsToBounds = YES;
    [self.payButton setTitle:@"支付" forState:UIControlStateNormal];
    [self.payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.payButton.titleLabel.font = Fonts(18);
    [self.payButton addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchDown];
    [self addSubview:self.payButton];
    [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(zfbButton.mas_bottom).mas_offset(ZY_HeightScale(29));
        make.height.equalTo(@(ZY_HeightScale(50)));
        make.width.equalTo(@(ZY_WidthScale(299)));
    }];
}

- (void)setModel:(GHBuyServiceLisetListModel *)model{
    _model = model;
    if (model.depositRequired == 0) {
        [self.payButton setTitle:[NSString stringWithFormat:@"支付¥%.2f", model.totalAmount] forState:UIControlStateNormal];
    }else
    {
         [self.payButton setTitle:[NSString stringWithFormat:@"支付预付款¥%.2f", model.orderAmount] forState:UIControlStateNormal];
    }
}

- (void)setRecommendModel:(GHRecommendListServicesModel *)recommendModel{
    _recommendModel = recommendModel;
    if (recommendModel.depositRequired == 0) {
        [self.payButton setTitle:[NSString stringWithFormat:@"支付¥%.2f", recommendModel.totalAmount] forState:UIControlStateNormal];
    }else
    {
        [self.payButton setTitle:[NSString stringWithFormat:@"支付预付款¥%.2f", recommendModel.orderAmount] forState:UIControlStateNormal];
    }
}


- (void)setOrderAmount:(double)orderAmount{
    _orderAmount = orderAmount;
    [self.payButton setTitle:[NSString stringWithFormat:@"支付预付款¥%.2f", orderAmount] forState:UIControlStateNormal];
}

- (void)setDespositReuired:(int)despositReuired{
    _despositReuired = despositReuired;
    if (despositReuired == 0) {
        
    }
}

#pragma mark --UITextView代理方法
- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.textView.text = @"";
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        self.textView.text = @"请输入备注信息";
        self.text = @"";
    }else{
        self.text = textView.text;
    }
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
