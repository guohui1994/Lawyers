//
//  GH_PersionMessageTableViewCell.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/12.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_PersionMessageTableViewCell.h"

@interface GH_PersionMessageTableViewCell ()
@property (nonatomic, strong)UILabel * titleLable;
@property (nonatomic, strong)UIImageView * iconImage;//头像
@property (nonatomic, strong)UILabel * contentsLable;//x内容信息
@property (nonatomic, strong)UIImageView * rightBackimage;//右侧箭头
@property (nonatomic, strong)UIView * lineView;//分割线
@end

@implementation GH_PersionMessageTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.iconImage];
    [self.contentView addSubview:self.contentsLable];
    [self.contentView addSubview:self.rightBackimage];
    [self.contentView addSubview:self.lineView];
    [self layout];
}
- (void)layout{
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_offset(ZY_WidthScale(15));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).mas_offset(-ZY_WidthScale(40));
        make.width.height.equalTo(@(ZY_WidthScale(70)));
    }];
    
    [self.contentsLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).mas_offset(-ZY_WidthScale(40));
    }];
    
    [self.rightBackimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).mas_offset(-ZY_WidthScale(15));
        make.width.equalTo(@(ZY_WidthScale(7)));
        make.height.equalTo(@(ZY_HeightScale(13)));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_offset(ZY_WidthScale(15));
        make.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@(1));
    }];
}


- (void)setIsShowHearder:(BOOL)isShowHearder{
    _isShowHearder = isShowHearder;
    if (isShowHearder == YES) {
        self.contentsLable.hidden = YES;
        self.iconImage.hidden = NO;
    }
}

- (void)setContentString:(NSString *)contentString{
    _contentString = contentString;
    if (_isShowHearder == YES) {
//        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:contentString] placeholder:nil];
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:contentString] placeholderImage:nil];
    }else{
        self.contentsLable.text = contentString;
    }
}

- (void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    self.titleLable.text = titleString;
}

- (void)setIsShowLineView:(BOOL)isShowLineView{
    _isShowLineView = isShowLineView;
    if (isShowLineView) {
        _lineView.hidden = YES;
    }
}


- (void)setIsHidenRightBackImage:(BOOL)isHidenRightBackImage{
    _isHidenRightBackImage = isHidenRightBackImage;
    if (isHidenRightBackImage) {
        _rightBackimage.hidden = YES;
 
        [_contentsLable mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).mas_offset(-ZY_WidthScale(15));
        }];
    }
}

- (UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [UILabel new];
        _titleLable.text = @"更换头像";
        _titleLable.textColor = Colors(@"#333333");
        _titleLable.font = Fonts(16);
    }
    return _titleLable;
}

- (UILabel *)contentsLable{
    if (!_contentsLable) {
        _contentsLable = [UILabel new];
        _contentsLable.font = Fonts(15);
        _contentsLable.textColor = Colors(@"#666666");
        _contentsLable.text = @"18209920026";
    }
    return _contentsLable;
}

- (UIImageView *)iconImage{
    if (!_iconImage) {
        _iconImage = [UIImageView new];
//        _iconImage.backgroundColor = RedColor;
        _iconImage.layer.cornerRadius = ZY_WidthScale(35);
        _iconImage.clipsToBounds = YES;
        _iconImage.hidden = YES;
    }
    return _iconImage;
}

- (UIImageView *)rightBackimage{
    if (!_rightBackimage) {
        _rightBackimage = [UIImageView new];
        _rightBackimage.image = Images(@"right_Back");
    }
    return _rightBackimage;
}

-(UIView *)lineView{
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
