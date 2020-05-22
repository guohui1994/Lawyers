//
//  GH_OrderAppraiseTableViewCell.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/17.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_OrderAppraiseTableViewCell.h"

@interface GH_OrderAppraiseTableViewCell ()
@property (nonatomic, strong)UIImageView * bgImageView;//背景图
@property (nonatomic, strong)UILabel * titleLable;//标题
@property (nonatomic, strong)UILabel * timeLable;//时间
@property (nonatomic, strong)UILabel * stateLable;//状态
@property (nonatomic, strong)UIView * lineView;//分割线
@property (nonatomic, strong)UILabel * priceLable;
@end

@implementation GH_OrderAppraiseTableViewCell

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
    [self.bgImageView addSubview:self.priceLable];
    [self.bgImageView addSubview:self.stateLable];
    [self.bgImageView addSubview:self.lineView];
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
        make.top.equalTo(self.bgImageView).mas_offset(ZY_HeightScale(31));
    }];
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLable.mas_right).mas_offset(ZY_WidthScale(11));
        make.centerY.equalTo(self.titleLable);
    }];
    [self.stateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLable);
        make.right.equalTo(self.bgImageView.mas_right).mas_offset(-ZY_WidthScale(21));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgImageView.mas_right).mas_offset(-ZY_WidthScale(21));
        make.left.equalTo(self.bgImageView).mas_offset(ZY_WidthScale(21));
        make.top.equalTo(self.stateLable.mas_bottom).mas_offset(ZY_HeightScale(9));
        make.height.equalTo(@(0.5));
    }];
    [self.priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgImageView);
        make.top.equalTo(self.lineView).mas_offset(ZY_HeightScale(20));
    }];
}

- (void)setModel:(GHOrderListListModel *)model{
    _model = model;
    if (model.state == 3) {
        _bgImageView.image = Images(@"Order_Completed");
        _timeLable.text = [GH_Tools transToTimeStemp:model.finishTime dateFormatter:@"yyyy-MM-dd HH:mm"];
        _stateLable.text = @"已完成";
    }else{
        _bgImageView.image = Images(@"Order_Appraise");
        _timeLable.text = [GH_Tools transToTimeStemp:model.evaluateTime dateFormatter:@"yyyy-MM-dd HH:mm"];
        _stateLable.text = @"已评价";
    }
    _titleLable.text = model.serviceName;
    _priceLable.text = [NSString stringWithFormat:@"合计: ¥ %.2f(含%.2f预付款)", model.totalMoney, model.orderAmount];
}

- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [UIImageView new];
        _bgImageView.image = Images(@"Order_Completed");
        _bgImageView.layer.cornerRadius = ZY_WidthScale(12);
        _bgImageView.clipsToBounds = YES;
    }
    return _bgImageView;
}

- (UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [UILabel new];
        _titleLable.text = @"劳动纠纷";
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
        _timeLable.textColor = Colors(@"#D3D6FD");
    }
    return _timeLable;
}

- (UILabel *)stateLable{
    if (!_stateLable) {
        _stateLable = [UILabel new];
        _stateLable.text = @"已完成";
        _stateLable.textColor = [UIColor whiteColor];
        _stateLable.font = Fonts(15);
    }
    return _stateLable;
}

- (UILabel *)priceLable{
    if (!_priceLable) {
        _priceLable = [UILabel new];
        _priceLable.text = @"合计:￥3000.00（含500.00定金）";
        _priceLable.textColor = [UIColor whiteColor];
        _priceLable.font = Fonts(15);
        _priceLable.textAlignment = NSTextAlignmentCenter;
    }
    return _priceLable;
}
- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView new];
        //        _lineView.backgroundColor = [UIColor whiteColor];
        
        //使用贝塞尔曲线画输入框的虚线
        UIBezierPath * path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake((screenWidth - ZY_WidthScale(76)), 0)];
        CAShapeLayer * layers = [CAShapeLayer layer];
        [layers setFillColor:[UIColor clearColor].CGColor];
        [layers setStrokeColor:Colors(@"#C0B3FD").CGColor];
        layers.path = path.CGPath;
        layers.lineWidth = 0.5;
        layers.lineDashPattern = @[@(3.0),@(3.0)];
        [_lineView.layer addSublayer:layers];
    }
    return _lineView;
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
