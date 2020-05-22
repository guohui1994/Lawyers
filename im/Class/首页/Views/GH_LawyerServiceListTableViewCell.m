//
//  GH_BuyLawyerServiceTableViewCell.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/16.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_LawyerServiceListTableViewCell.h"

@interface GH_LawyerServiceListTableViewCell ()
@property (nonatomic, strong)UILabel * titleLable;//标题
@property (nonatomic, strong)UILabel * priceLable;//价格
@property (nonatomic, strong)UILabel * contentsLable;//内容
@property (nonatomic, strong)UIView * bgView;//背景
@property (nonatomic, strong)UILabel * serviceNumber;//服务号
@end

@implementation GH_LawyerServiceListTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.titleLable];
    [self.bgView addSubview:self.priceLable];
    [self.bgView addSubview:self.contentsLable];
    [self.bgView addSubview:self.serviceNumber];
    [self layout];
}

- (void)layout{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_offset(ZY_WidthScale(15));
        make.right.equalTo(self.contentView).mas_offset(-ZY_WidthScale(15));
        make.top.bottom.equalTo(self.contentView);
    }];
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).mas_offset(ZY_WidthScale(15));
        make.top.equalTo(self.bgView).mas_offset(ZY_HeightScale(15));
    }];
    
    [self.serviceNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLable.mas_right).mas_offset(ZY_WidthScale(10));
        make.centerY.equalTo(self.titleLable);
    }];
    
    [self.priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView.mas_right).mas_offset(-ZY_WidthScale(15));
        make.centerY.equalTo(self.titleLable);
    }];
    [self.contentsLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).mas_offset(ZY_WidthScale(14));
        make.right.equalTo(self.bgView.mas_right).mas_offset(-ZY_WidthScale(14));
        make.top.equalTo(self.titleLable.mas_bottom).mas_offset(ZY_HeightScale(16));
        make.bottom.equalTo(self.bgView.mas_bottom).mas_offset(-ZY_HeightScale(10));
    }];
}


- (void)setIsHiddenServiceNumber:(BOOL)isHiddenServiceNumber{
    _isHiddenServiceNumber = isHiddenServiceNumber;
    if (isHiddenServiceNumber) {
        self.serviceNumber.hidden = YES;
    }else{
        self.serviceNumber.hidden = NO;
    }
}

- (void)setIsHiddenMoney:(BOOL)isHiddenMoney{
    _isHiddenMoney = isHiddenMoney;
    self.priceLable.hidden = isHiddenMoney;
}

//购买服务数据
- (void)setModel:(GHBuyServiceLisetListModel *)model{
    _model = model;
    _titleLable.text = model.name;
    _contentsLable.text = model.intro;
    _priceLable.text = [NSString stringWithFormat:@"¥ %.2f起", model.totalAmount];
}

//已经购买过的服务列表
- (void)setAlreadyBuyServiceModel:(GHAlreadyBuyServiceListListModel *)alreadyBuyServiceModel{
    _alreadyBuyServiceModel  = alreadyBuyServiceModel;
    _titleLable.text = alreadyBuyServiceModel.serviceName;
    _contentsLable.text = alreadyBuyServiceModel.intro;
    _serviceNumber.text = alreadyBuyServiceModel.orderNum;
    _priceLable.text = [NSString stringWithFormat:@"¥ %.2f", alreadyBuyServiceModel.totalAmount];
}

- (void)setLeaveMessageModel:(GHLeaveMessageResultModel *)leaveMessageModel{
    _leaveMessageModel = leaveMessageModel;
//    _titleLable.text = leaveMessageModel.seekNum;
//    _contentsLable.text = [NSString stringWithFormat:@"%@"];
    _titleLable.text = leaveMessageModel.seekNum;
    _contentsLable.text = [NSString stringWithFormat:@"《%@》留言时间:  %@", leaveMessageModel.labelName, [GH_Tools transToTimeStemp:leaveMessageModel.createTime dateFormatter:@"yyyy-MM-dd HH:mm:ss"]];

}


- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = Colors(@"#F0EFFF");
        _bgView.layer.cornerRadius = ZY_WidthScale(10);
        _bgView.clipsToBounds = YES;
    }
    return _bgView;
}

- (UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [UILabel new];
        _titleLable.text = @"发律师函";
        _titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:ZY_WidthScale(16)];
        _titleLable.textColor = Colors(@"#333333");
    }
    return _titleLable;
}

- (UILabel *)serviceNumber{
    if (!_serviceNumber) {
        _serviceNumber = [UILabel new];
        _serviceNumber.text = @"(2019）服务10号";
        _serviceNumber.textColor = Colors(@"#4C4C4C");
        _serviceNumber.font = Fonts(13);
    }
    return _serviceNumber;
}

- (UILabel *)priceLable{
    if (!_priceLable) {
        _priceLable = [UILabel new];
        _priceLable.text = @"¥ 1000";
        _priceLable.textColor = Colors(@"#FD9401");
        _priceLable.font = Fonts(16);
    }
    return _priceLable;
}
- (UILabel *)contentsLable{
    if (!_contentsLable) {
        _contentsLable = [UILabel new];
        _contentsLable.text = @"简介：赔偿标准按照2019年最新交通事故类、劳动 工伤类、意外伤害类以及其他各类纠纷的赔偿标";
        _contentsLable.textColor = Colors(@"#4C4C4C");
        _contentsLable.numberOfLines = 0;
        _contentsLable.font = Fonts(14);
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
