//
//  GH_QuestionTableViewCell.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/20.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_QuestionTableViewCell.h"

@interface GH_QuestionTableViewCell ()
@property (nonatomic, strong)UILabel * contensLable;
@property (nonatomic, strong)UIView * lineView;
@end

@implementation GH_QuestionTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    [self.contentView addSubview:self.contensLable];
    [self.contentView addSubview:self.lineView];
    [self layout];
}
- (void)layout{
    [self.contensLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).mas_offset(ZY_WidthScale(25));
        make.right.equalTo(self.contentView.mas_right).mas_offset(-ZY_WidthScale(25));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contensLable);
        make.right.equalTo(self.contentView.mas_right).mas_offset(-ZY_WidthScale(25));
        make.top.equalTo(self.contensLable.mas_bottom).mas_offset(ZY_HeightScale(14));
        make.height.equalTo(@(0.5));
    }];
}


- (void)setModel:(GHQuestionListModelModel *)model{
    _model = model;
    _contensLable.text = model.question;
}

- (UILabel *)contensLable{
    if (!_contensLable) {
        _contensLable = [UILabel new];
        _contensLable.text = @"婚姻家庭相关法律法规；";
        _contensLable.textColor = Colors(@"#333333");
        _contensLable.font = Fonts(16);
    }
    return _contensLable;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = Colors(@"#DEDDDD");
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
