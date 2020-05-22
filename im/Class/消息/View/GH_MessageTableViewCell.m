//
//  GH_MessageTableViewCell.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/16.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_MessageTableViewCell.h"

@interface GH_MessageTableViewCell ()
@property (nonatomic, strong)UIImageView * headerImageView;//头像
@property(nonatomic, strong)UILabel * nameLable;//名字
@property (nonatomic, strong)UILabel * contentsLable;//内容
@property (nonatomic, strong)UILabel * timeLable;//时间
@property (nonatomic, strong)UIView * lineView;//分割线
@end

@implementation GH_MessageTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    [self.contentView addSubview:self.headerImageView];
    [self.contentView addSubview:self.nameLable];
    [self.contentView addSubview:self.contentsLable];
    [self.contentView addSubview:self.timeLable];
//    [self.contentView addSubview:self.lineView];
    [self layout];
}

- (void)layout{
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_offset(ZY_WidthScale(15));
        make.centerY.equalTo(self.contentView);
        make.width.height.equalTo(@(ZY_WidthScale(55)));
    }];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImageView.mas_right).mas_offset(ZY_WidthScale(15));
        make.top.equalTo(self.contentView).mas_offset(ZY_HeightScale(17));
    }];
    
    [self.contentsLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLable);
        make.top.equalTo(self.nameLable.mas_bottom).mas_offset(15);
        make.right.equalTo(self.contentView.mas_right).mas_offset(-ZY_WidthScale(26));
        make.height.equalTo(@(ZY_HeightScale(15)));
    }];
    
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).mas_offset(ZY_HeightScale(25));
        make.right.equalTo(self.contentView.mas_right).mas_offset(-ZY_WidthScale(15));
    }];
    
//    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView).mas_offset(ZY_WidthScale(15));
//        make.right.equalTo(self.contentView.mas_right).mas_offset(-ZY_WidthScale(15));
//        make.top.equalTo(self.headerImageView.mas_bottom).mas_offset(ZY_HeightScale(11));
//        make.height.equalTo(@(1));
//    }];
}

-(UIImageView *)headerImageView{
    if (!_headerImageView) {
        _headerImageView = [UIImageView new];
        _headerImageView.layer.cornerRadius = ZY_WidthScale(15);
        _headerImageView.clipsToBounds = YES;
        _headerImageView.backgroundColor = RedColor;
    }
    return _headerImageView;
}

- (UILabel *)nameLable{
    if (!_nameLable) {
        _nameLable = [UILabel new];
        _nameLable.text = @"系统消息";
        _nameLable.textColor = Colors(@"#333333");
        _nameLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:ZY_WidthScale(16)];
    }
    return _nameLable;
}

- (UILabel *)contentsLable{
    if (!_contentsLable) {
        _contentsLable = [UILabel new];
        _contentsLable.text = @"您好，有什么可以帮助您的吗？";
        _contentsLable.font = Fonts(15);
        _contentsLable.textColor = Colors(@"#4C4C4C");
    }
    return _contentsLable;
}

- (UILabel *)timeLable{
    if (!_timeLable) {
        _timeLable = [UILabel new];
        _timeLable.text = @"2019-09-23  12:20";
        _timeLable.font = Fonts(13);
        _timeLable.textColor = Colors(@"#888888");
    }
    return _timeLable;
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
