//
//  GH_BuyLawyerServiceTableViewCell.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/16.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_BuyLawyerServiceTableViewCell.h"

@interface GH_BuyLawyerServiceTableViewCell ()
@property (nonatomic, strong)UIView * orangeView;//黄色方框
@property (nonatomic, strong)UILabel * titleLable;//标题
@property (nonatomic, strong)UILabel * contensLable;
@property (nonatomic, strong)UIView * BG_priceView;//价格背景
@property (nonatomic, strong)UILabel * priceLable;//价格
@property (nonatomic, strong)UILabel * stateLable;//状态
@property (nonatomic, strong)UILabel * weiKuanLable;//尾款
@property (nonatomic, strong)UILabel * dingJingLable;//定金
@end


@implementation GH_BuyLawyerServiceTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}
//添加视图
- (void)creatUI{
    [self.contentView addSubview:self.orangeView];
    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.stateLable];
    [self.contentView addSubview:self.contensLable];
    [self.contentView addSubview:self.BG_priceView];
    [self.BG_priceView addSubview:self.priceLable];
    [self.BG_priceView addSubview:self.weiKuanLable];
    [self.BG_priceView addSubview:self.dingJingLable];
    [self layout];
}
//布局
- (void)layout{
//    [self.orangeView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView).mas_offset(ZY_WidthScale(15));
//        make.top.equalTo(self.contentView).mas_offset(ZY_HeightScale(26));
//        make.width.equalTo(@(ZY_WidthScale(8)));
//        make.height.equalTo(@(ZY_HeightScale(9)));
//    }];
    
    self.orangeView.sd_layout
    .leftSpaceToView(self.contentView, ZY_WidthScale(15))
    .topSpaceToView(self.contentView, ZY_HeightScale(26))
    .widthIs(ZY_WidthScale(8))
    .heightIs(ZY_HeightScale(9));
    
    
//    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.orangeView.mas_right).mas_offset(ZY_WidthScale(6));
//        make.top.equalTo(self.contentView).mas_offset(ZY_HeightScale(23));
//    }];
    
    self.titleLable.sd_layout
    .leftSpaceToView(self.orangeView, ZY_WidthScale(6))
    .topSpaceToView(self.contentView, ZY_HeightScale(23))
    .widthIs(ZY_WidthScale(200))
    .heightIs(ZY_HeightScale(14));
    
//    [self.stateLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.titleLable);
//        make.right.equalTo(self.contentView.mas_right).mas_offset(-ZY_WidthScale(15));
//    }];
    
    self.stateLable.sd_layout
    .centerYEqualToView(self.titleLable)
    .rightSpaceToView(self.contentView, ZY_WidthScale(15))
    .widthIs(ZY_WidthScale(100))
    .heightIs(ZY_HeightScale(15));
    
//    [self.contensLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView).mas_offset(ZY_WidthScale(22));
//        make.top.equalTo(self.titleLable.mas_bottom).mas_offset(ZY_HeightScale(21));
//        make.right.equalTo(self.contentView.mas_right).mas_offset(-ZY_WidthScale(22));
//    }];
    
    self.contensLable.sd_layout
    .leftSpaceToView(self.contentView, ZY_WidthScale(22))
    .rightSpaceToView(self.contentView, ZY_WidthScale(22))
    .topSpaceToView(self.titleLable, ZY_HeightScale(21))
    .autoHeightRatio(0);
    
    
//    [self.BG_priceView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView).mas_offset(ZY_WidthScale(15));
//        make.right.equalTo(self.contentView.mas_right).mas_offset(-ZY_WidthScale(15));
//        make.top.equalTo(self.contensLable.mas_bottom).mas_offset(ZY_HeightScale(18));
//        make.height.equalTo(@(ZY_HeightScale(40)));
//    }];
    
    self.BG_priceView.sd_layout
    .leftSpaceToView(self.contentView, ZY_WidthScale(15))
    .rightSpaceToView(self.contentView, ZY_WidthScale(15))
    .topSpaceToView(self.contensLable, ZY_HeightScale(18))
    .autoHeightRatio(0);
    
//    [self.priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.BG_priceView).mas_offset(ZY_WidthScale(14));
//        make.centerY.equalTo(self.BG_priceView);
//    }];
    
    self.priceLable.sd_layout
    .leftSpaceToView(self.BG_priceView, ZY_WidthScale(14))
    .topSpaceToView(self.BG_priceView, ZY_HeightScale(13))
    .heightIs(ZY_HeightScale(16))
    .autoWidthRatio(0);
    [self.priceLable setSingleLineAutoResizeWithMaxWidth: ZY_WidthScale(300)];
    
    self.dingJingLable.sd_layout
    .leftEqualToView(self.priceLable)
    .topSpaceToView(self.priceLable, ZY_HeightScale(13))
    .heightIs(ZY_HeightScale(16))
    .autoWidthRatio(0);
    [self.dingJingLable setSingleLineAutoResizeWithMaxWidth:ZY_WidthScale(300)];
    
//    [self.weiKuanLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.BG_priceView.mas_right).mas_offset(-ZY_WidthScale(14));
//        make.centerY.equalTo(self.BG_priceView);
//    }];
    
    self.weiKuanLable.sd_layout
    .leftEqualToView(self.priceLable)
    .topSpaceToView(self.dingJingLable, ZY_HeightScale(13))
    .heightIs(ZY_HeightScale(16))
    .autoWidthRatio(0);
    [self.weiKuanLable setSingleLineAutoResizeWithMaxWidth:ZY_WidthScale(300)];
    
    
    [self.BG_priceView setupAutoHeightWithBottomView:self.dingJingLable bottomMargin:ZY_HeightScale(13)];
    
    [self setupAutoHeightWithBottomView:self.BG_priceView bottomMargin:ZY_HeightScale(10)];
}

- (void)setModel:(GHBuyServiceLisetListModel *)model{
    _model = model;
    _titleLable.text = model.name;
    _contensLable.text = model.intro;
     _priceLable.text = [NSString stringWithFormat:@"价格: ¥ %.2f起", model.totalAmount];
    if (model.depositRequired == 0) {
        _dingJingLable.hidden = YES;
        [self.BG_priceView setupAutoHeightWithBottomView:self.priceLable bottomMargin:10];
    }else{
        _dingJingLable.text = [NSString stringWithFormat:@"预付款: ¥ %.2f", model.orderAmount];
    }
    
}

- (void)setRecommendModel:(GHRecommendListServicesModel *)recommendModel{
    _recommendModel = recommendModel;
    _titleLable.text = recommendModel.name;
    _contensLable.text = recommendModel.intro;
    _priceLable.text = [NSString stringWithFormat:@"价格: ¥ %.2f起", recommendModel.totalAmount];
    if (recommendModel.depositRequired == 0) {
        _dingJingLable.hidden = YES;
        [self.BG_priceView setupAutoHeightWithBottomView:self.priceLable bottomMargin:10];
    }else{
        _dingJingLable.text = [NSString stringWithFormat:@"预付款: ¥ %.2f", recommendModel.orderAmount];
    }
}

//已经购买服务的model
- (void)setAlreadyServiceModel:(GHAlreadyBuyServiceListListModel *)alreadyServiceModel{
    _alreadyServiceModel = alreadyServiceModel;
    _titleLable.text = alreadyServiceModel.serviceName;
    _contensLable.text = alreadyServiceModel.intro;
    _priceLable.text = [NSString stringWithFormat:@"价格: ¥ %.2f", alreadyServiceModel.totalAmount];
    _dingJingLable.hidden = YES;
    [self.BG_priceView setupAutoHeightWithBottomView:self.priceLable bottomMargin:ZY_HeightScale(13)];
    [self updateLayout];
}




//订单model
- (void)setOrderModel:(GHOrderListListModel *)orderModel{
    _orderModel = orderModel;
    _titleLable.text = orderModel.serviceName;
    _contensLable.text = orderModel.intro;
    _priceLable.text = [NSString stringWithFormat:@"价格: ¥ %.2f起", orderModel.totalAmount];
    _dingJingLable.text = [NSString stringWithFormat:@"预付款: ¥ %.2f", orderModel.orderAmount];
    _weiKuanLable.text = [NSString stringWithFormat:@"尾款: ¥ %.2f", orderModel.tailMoney];
    if (orderModel.orderAmount == 0) {
        _dingJingLable.hidden = YES;
        _weiKuanLable.hidden = YES;
        [self.BG_priceView setupAutoHeightWithBottomView:self.priceLable bottomMargin:10];
    }
    
    
    if (orderModel.state == 1 || orderModel.state == 2) {
        _stateLable.text = @"进行中";
       
    }else if (orderModel.state == 3){
        _stateLable.text = @"订单已完成";
        
    }else{
        _stateLable.text = @"评价已完成";
//        _priceLable.text = [NSString stringWithFormat:@"下单时间: %@", [GH_Tools transToTimeStemp:orderModel.createTime dateFormatter:@"yyyy-MM-dd HH:mm"]];
//        _dingJingLable.text = [NSString stringWithFormat:@"完成时间: %@", [GH_Tools transToTimeStemp:orderModel.finishTime dateFormatter:@"yyyy-MM-dd HH:mm"]];
//        _weiKuanLable.text = [NSString stringWithFormat:@"评价时间: %@", [GH_Tools transToTimeStemp:orderModel.createTime dateFormatter:@"yyyy-MM-dd HH:mm"]];
    }
}

-(void)setIsShowStateLable:(BOOL)isShowStateLable{
    _isShowStateLable = isShowStateLable;
    if (isShowStateLable == YES) {
        _stateLable.hidden = NO;
    }
}

- (void)setStateString:(NSString *)stateString{
    _stateString = stateString;
    _stateLable.text = stateString;
}

- (void)setIsShowWeiKuanLable:(BOOL)isShowWeiKuanLable{
    _isShowWeiKuanLable = isShowWeiKuanLable;
    if (_isShowWeiKuanLable == YES) {
        _weiKuanLable.hidden = NO;
        [self.BG_priceView setupAutoHeightWithBottomView:self.weiKuanLable bottomMargin:ZY_HeightScale(13)];
        [self updateLayout];
    }
}

- (UIView *)orangeView{
    if (!_orangeView) {
        _orangeView = [UIView new];
        _orangeView.backgroundColor = Colors(@"#FFA425");
    }
    return _orangeView;
}

- (UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [UILabel new];
        _titleLable.text = @"发律师函";
        _titleLable.font = Fonts(15);
        _titleLable.textColor = Colors(@"#666666");
    }
    return _titleLable;
}

- (UILabel *)contensLable{
    if (!_contensLable) {
        _contensLable = [UILabel new];
        _contensLable.text = @"简介：赔偿标准栏目旨在帮您提供2018年最新交通事故类、劳动工伤类、人身伤害类以及其他各类纠纷的赔偿标准、项目和具体的计算方式简介：赔偿标准栏目旨在帮您提供2018年最新交通事故类、劳动工伤类、人身伤害类以及其他各类纠纷的赔偿标准、项目和具体的计算方式";
        _contensLable.textColor = Colors(@"#333333");
        _contensLable.font = Fonts(15);
        _contensLable.numberOfLines = 0;
    }
    return _contensLable;
}

-(UILabel *)stateLable{
    if (!_stateLable) {
        _stateLable = [UILabel new];
        _stateLable.text = @"进行中";
        _stateLable.textColor = Colors(@"#333333");
        _stateLable.font =  [UIFont fontWithName:@"Helvetica-Bold" size:ZY_WidthScale(15)];
        _stateLable.hidden = YES;
    }
    return _stateLable;
}


- (UIView *)BG_priceView{
    if (!_BG_priceView) {
        _BG_priceView = [UIView new];
        _BG_priceView.backgroundColor = Colors(@"#FFFDF6");
    }
    return _BG_priceView;
}

- (UILabel *)priceLable{
    if (!_priceLable) {
        _priceLable = [UILabel new];
        _priceLable.text = @"价格: ¥1000起";
        _priceLable.textColor = Colors(@"#FFA425");
        _priceLable.font = Fonts(16);
    }
    return _priceLable;
}

- (UILabel *)weiKuanLable{
    if (!_weiKuanLable) {
        _weiKuanLable = [UILabel new];
        _weiKuanLable.text = @"尾款: ¥1000起";
        _weiKuanLable.textColor = Colors(@"#FFA425");
        _weiKuanLable.font = Fonts(16);
        _weiKuanLable.hidden = YES;
    }
    return _weiKuanLable;
}

- (UILabel *)dingJingLable{
    if (!_dingJingLable) {
        _dingJingLable = [UILabel new];
        _dingJingLable.text = @"预付款: ¥1000起";
        _dingJingLable.textColor = Colors(@"#FFA425");
        _dingJingLable.font = Fonts(16);
        _dingJingLable.hidden = NO;
    }
    return _dingJingLable;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
