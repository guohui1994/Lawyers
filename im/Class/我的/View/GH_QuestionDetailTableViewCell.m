//
//  GH_QuestionDetailTableViewCell.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/21.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_QuestionDetailTableViewCell.h"

@interface GH_QuestionDetailTableViewCell ()
@property (nonatomic, strong)UILabel * titleLable;//标题
@property (nonatomic, strong)UILabel * contentsLable;//内容
@end

@implementation GH_QuestionDetailTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.contentsLable];
    [self layout];
}

- (void)layout{
    self.titleLable.sd_layout
   .leftSpaceToView(self.contentView, ZY_WidthScale(15))
    .topSpaceToView(self.contentView, ZY_HeightScale(37))
   .rightSpaceToView(self.contentView, ZY_WidthScale(15))
    .autoHeightRatio(0);
    
    self.contentsLable.sd_layout
    .leftSpaceToView(self.contentView, ZY_WidthScale(15))
    .rightSpaceToView(self.contentView, ZY_WidthScale(15))
    .topSpaceToView(self.titleLable, ZY_HeightScale(33))
    .autoHeightRatio(0);
    [self setupAutoHeightWithBottomView:self.contentsLable bottomMargin:ZY_HeightScale(10)];
}

- (void)setModel:(GHQuestionListModelModel *)model{
    _model = model;
    _titleLable.text = model.question;
    _contentsLable.text = [NSString stringWithFormat:@"  %@", model.answer];
}

- (UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [UILabel new];
        _titleLable.text = @"劳动纠纷相关法律法规";
        _titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:ZY_WidthScale(18)];
        _titleLable.textColor = Colors(@"#222222");
        _titleLable.numberOfLines = 0;
        _titleLable.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLable;
}

- (UILabel *)contentsLable{
    if (!_contentsLable) {
        _contentsLable = [UILabel new];
        _contentsLable.text = @"内容";
        _contentsLable.textColor = Colors(@"#555555");
        _contentsLable.font = Fonts(15);
        _contentsLable.numberOfLines = 0;
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
