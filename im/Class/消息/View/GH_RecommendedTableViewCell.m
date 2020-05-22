//
//  GH_RecommendedTableViewCell.m
//  im
//
//  Created by ZhiYuan on 2020/4/22.
//  Copyright © 2020 郭徽. All rights reserved.
//

#import "GH_RecommendedTableViewCell.h"

@interface GH_RecommendedTableViewCell ()
@property (nonatomic, strong)UILabel * titleLable;//标题
@property (nonatomic, strong)UILabel * stateLable;//价格
@property (nonatomic, strong)UILabel * contentsLable;//内容
@property (nonatomic, strong)UIView * bgView;//背景
@property (nonatomic, strong)UILabel * timeLable;
@end

@implementation GH_RecommendedTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.titleLable];
    [self.bgView addSubview:self.stateLable];
    [self.bgView addSubview:self.contentsLable];
    [self.bgView addSubview:self.timeLable];
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
    
   
    
    [self.stateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView.mas_right).mas_offset(-ZY_WidthScale(15));
        make.centerY.equalTo(self.titleLable);
    }];
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.stateLable);
        make.bottom.equalTo(self.bgView.mas_bottom).mas_offset(-ZY_HeightScale(10.5));
    }];
    [self.contentsLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).mas_offset(ZY_WidthScale(14));
        make.right.equalTo(self.bgView.mas_right).mas_offset(-ZY_WidthScale(14));
        make.top.equalTo(self.titleLable.mas_bottom).mas_offset(ZY_HeightScale(16));
        make.bottom.equalTo(self.timeLable.mas_top).mas_offset(-ZY_HeightScale(10));
    }];
   
}

- (void)setModel:(GHRecommendListModel *)model{
    _model = model;
    _titleLable.text = model.services.name;
    if (model.isBuy ==  0) {
        _stateLable.text = @"未购买";
    }else{
        _stateLable.text = @"已购买";
    }
    _contentsLable.text = model.services.intro;
    _timeLable .text = [GH_Tools transToTimeStemp:model.services.createTime dateFormatter:@"yyyy-MM-dd HH:mm"];
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



- (UILabel *)stateLable{
    if (!_stateLable) {
        _stateLable = [UILabel new];
        _stateLable.text = @"已购买";
        _stateLable.textColor = Colors(@"#FD9401");
        _stateLable.font = Fonts(16);
    }
    return _stateLable;
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

- (UILabel *)timeLable{
    if (!_timeLable) {
        _timeLable = [UILabel new];
        _timeLable.text = @"2019-09-23  12:20 ";
        _timeLable.textColor = Colors(@"#888888");
        _timeLable.font = Fonts(13);
    }
    return _timeLable;
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
