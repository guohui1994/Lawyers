//
//  GH_LeaveMessageResultTableViewCell.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/11.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_LeaveMessageResultTableViewCell.h"

@interface GH_LeaveMessageResultTableViewCell ()
@property (nonatomic, strong)UILabel * contentsLable;
@property (nonatomic, strong)UIView * bgView;
@end

@implementation GH_LeaveMessageResultTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.contentsLable];
    [self layout];
}

- (void)layout{
    self.bgView.sd_layout
    .leftSpaceToView(self.contentView, ZY_WidthScale(15))
    .widthIs(screenWidth - ZY_WidthScale(30))
    .topSpaceToView(self.contentView, ZY_HeightScale(20))
    .autoHeightRatio(0);
    self.contentsLable.sd_layout
    .leftSpaceToView(self.bgView, ZY_WidthScale(18))
    .rightSpaceToView(self.bgView, ZY_WidthScale(18))
    .topSpaceToView(self.bgView, ZY_HeightScale(17))
    .autoHeightRatio(0);
    [self.bgView setupAutoHeightWithBottomView:self.contentsLable bottomMargin:ZY_HeightScale(17)];
    [self setupAutoHeightWithBottomView:self.bgView bottomMargin:ZY_HeightScale(19)];
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = Colors(@"#FEFBEF");
    }
    return _bgView;
}
//留言结果的model
- (void)setModel:(GHLeaveMessageResultModel *)model{
    _model = model;
    _contentsLable.text = model.seek;
}

//已购买服务的model
- (void)setAlreadyModel:(GHAlreadyBuyServiceListListModel *)alreadyModel{
    _alreadyModel = alreadyModel;
    _contentsLable.text = alreadyModel.remark;
}


//订单model
- (void)setOrderModel:(GHOrderListListModel *)orderModel{
    _orderModel = orderModel;
    _contentsLable.text = orderModel.remark;
}

- (UILabel *)contentsLable{
    if (!_contentsLable) {
        _contentsLable = [UILabel new];
        _contentsLable.text = @"";
        _contentsLable.font = Fonts(15);
        _contentsLable.numberOfLines = 0;
        _contentsLable.textColor = Colors(@"#333333");
    }
    return _contentsLable;
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
