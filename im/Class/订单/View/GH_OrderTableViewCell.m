//
//  GH_OrderTableViewCell.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/17.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_OrderTableViewCell.h"

@interface GH_OrderTableViewCell ()
@property (nonatomic, strong)UIImageView * bgImageView;//背景图
@property (nonatomic, strong)UILabel * titleLable;//标题
@property (nonatomic, strong)UILabel * timeLable;//时间
@property (nonatomic, strong)UILabel * payWay;//付款方式以及金额
@property (nonatomic, strong)UILabel * stateLable;//状态
@property (nonatomic, strong)UIView * lineView;//分割线

@property (nonatomic, strong)CAShapeLayer * layers ;
@end

@implementation GH_OrderTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    [self.contentView addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.titleLable];
    [self.bgImageView addSubview:self.timeLable];
    [self.bgImageView addSubview:self.payWay];
    [self.bgImageView addSubview:self.stateLable];
    [self.bgImageView addSubview:self.lineView];
    [self.bgImageView addSubview:self.clickButton];
    [self layout];
}
- (void)layout{
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_offset(ZY_WidthScale(18));
        make.right.equalTo(self.contentView.mas_right).mas_offset(-ZY_WidthScale(18));
        make.top.equalTo(self.contentView);
        make.height.equalTo(@(ZY_HeightScale(133)));
    }];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgImageView).mas_offset(ZY_WidthScale(22));
        make.top.equalTo(self.bgImageView).mas_offset(ZY_HeightScale(21));
    }];
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLable);
        make.right.equalTo(self.bgImageView.mas_right).mas_offset(-ZY_WidthScale(20));
    }];
//
    [self.payWay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLable);
        make.top.equalTo(self.titleLable.mas_bottom).mas_offset(ZY_HeightScale(15));
    }];

    [self.stateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.payWay);
        make.right.equalTo(self.bgImageView.mas_right).mas_offset(-ZY_WidthScale(30));
    }];

    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgImageView.mas_right).mas_offset(-ZY_WidthScale(21));
        make.left.equalTo(self.bgImageView).mas_offset(ZY_WidthScale(21));
        make.top.equalTo(self.payWay.mas_bottom).mas_offset(ZY_HeightScale(9));
        make.height.equalTo(@(0.5));
    }];
//
    [self.clickButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgImageView.mas_right).mas_offset(-ZY_WidthScale(20));
        make.top.equalTo(self.lineView.mas_bottom).mas_offset(ZY_HeightScale(9));
        make.width.equalTo(@(ZY_WidthScale(73)));
        make.height.equalTo(@(ZY_HeightScale(23)));
    }];
//
}

- (void)setType:(int)type{
    _type = type;
    if (type == 0) {
        self.bgImageView.image = Images(@"Order_Progress");
        self.timeLable.textColor = Colors(@"#D7CDFF");
        [self.layers setStrokeColor:Colors(@"#C0B3FD").CGColor];
//        self.lineView.backgroundColor = Colors(@"#C0B3FD");
        [self.clickButton setTitleColor:Colors(@"#DED7FF") forState:UIControlStateNormal];
        [self.clickButton setTitle:@"进行中" forState:UIControlStateNormal];
        self.clickButton.layer.borderColor = Colors(@"#DED7FF").CGColor;
    }else if (type == 1){
        self.bgImageView.image = Images(@"Order_Completed");
        self.timeLable.textColor = Colors(@"#BFC4FD");
        [self.layers setStrokeColor:Colors(@"#C0B3FD").CGColor];
//        self.lineView.backgroundColor = Colors(@"#C0B3FD");
        [self.clickButton setTitleColor:Colors(@"#DED7FF") forState:UIControlStateNormal];
        [self.clickButton setTitle:@"已完成" forState:UIControlStateNormal];
        self.clickButton.layer.borderColor = Colors(@"#DED7FF").CGColor;
    }else{
        self.bgImageView.image = Images(@"Order_Appraise");
        self.timeLable.textColor = Colors(@"#B8E4F9");
        [self.layers setStrokeColor:Colors(@"#9CD2F6").CGColor];
//        self.lineView.backgroundColor = Colors(@"#9CD2F6");
        [self.clickButton setTitleColor:Colors(@"#DED7FF") forState:UIControlStateNormal];
        [self.clickButton setTitle:@"已评价" forState:UIControlStateNormal];
        self.clickButton.layer.borderColor = Colors(@"#DED7FF").CGColor;
    }
}

- (void)setModel:(GHOrderListListModel *)model{
    _model = model;
    _titleLable.text = model.serviceName;
    _timeLable.text = [GH_Tools transToTimeStemp:model.createTime dateFormatter:@"yyyy-MM-dd HH:mm"];
    if (self.model.state == 1) {
        _stateLable.text = @"进行中";
        [_clickButton setTitle:@"进行中" forState:UIControlStateNormal];
    }else if (self.model.state == 2){
        _stateLable.text = @"进行中";
        [_clickButton setTitle:@"已完成" forState:UIControlStateNormal];
    }else if (model.state == 3){
        _stateLable.text = @"已完成";
        [_clickButton setTitle:@"评价订单" forState:UIControlStateNormal];
    }else{
        _stateLable.text = @"已评价";
        [_clickButton setTitle:@"已评价" forState:UIControlStateNormal];
    }
    _payWay.text = [NSString stringWithFormat:@"¥ %.2f", model.totalMoney];
}


- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [UIImageView new];
        _bgImageView.image = Images(@"Order_Progress");
        _bgImageView.layer.cornerRadius = ZY_WidthScale(12);
        _bgImageView.clipsToBounds = YES;
        _bgImageView.userInteractionEnabled = YES;
    }
    return _bgImageView;
}

- (UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [UILabel new];
        _titleLable.text = @"婚姻家庭";
        _titleLable.font = Fonts(16);
        _titleLable.textColor = [UIColor whiteColor];
    }
    return _titleLable;
}

- (UILabel *)timeLable{
    if (!_timeLable) {
        _timeLable = [UILabel new];
        _timeLable.text = @"2019-09-23  12:20";
        _timeLable.font = Fonts(12);
        _timeLable.textColor = [UIColor whiteColor];
    }
    return _timeLable;
}

- (UILabel *)payWay{
    if (!_payWay) {
        _payWay = [UILabel new];
        _payWay.text = @"支付宝￥1000.00";
        _payWay.font = Fonts(15);
        _payWay.textColor = [UIColor whiteColor];
    }
    return _payWay;
}

- (UILabel *)stateLable{
    if (!_stateLable) {
        _stateLable = [UILabel new];
        _stateLable.textColor = [UIColor whiteColor];
        _stateLable.text = @"进行中";
        _stateLable.font = Fonts(15);
    }
    return _stateLable;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView new];
//        _lineView.backgroundColor = [UIColor whiteColor];
        
        //使用贝塞尔曲线画输入框的虚线
        UIBezierPath * path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake((screenWidth - ZY_WidthScale(76)), 0)];
        self. layers = [CAShapeLayer layer];
        [self.layers setFillColor:[UIColor clearColor].CGColor];
        [self.layers setStrokeColor:Colors(@"#9CD2F6").CGColor];
        self.layers.path = path.CGPath;
        self.layers.lineWidth = 0.5;
        self.layers.lineDashPattern = @[@(3.0),@(3.0)];
        [_lineView.layer addSublayer:self.layers];
    }
    return _lineView;
}

- (UIButton *)clickButton{
    if (!_clickButton) {
        _clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clickButton setTitle:@"已完成" forState:UIControlStateNormal];
        [_clickButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _clickButton.titleLabel.font = Fonts(12);
        _clickButton.layer.cornerRadius = ZY_WidthScale(12);
        _clickButton.clipsToBounds = YES;
        _clickButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _clickButton.layer.borderWidth = 1;
    }
    return _clickButton;
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
