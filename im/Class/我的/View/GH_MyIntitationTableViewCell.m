//
//  GH_MyIntitationTableViewCell.m
//  im
//
//  Created by ZhiYuan on 2020/5/20.
//  Copyright © 2020 郭徽. All rights reserved.
//

#import "GH_MyIntitationTableViewCell.h"

@interface GH_MyIntitationTableViewCell ()

@property (nonatomic, strong)UIImageView * headerImage;
@property (nonatomic, strong)UILabel * nameLable;
@property (nonatomic, strong)UILabel * phoneLable;
@property (nonatomic, strong)UILabel * stauteLable;
@property (nonatomic, strong)UILabel * timeLable;
@property (nonatomic, strong)UIView * linewView;

@end

@implementation GH_MyIntitationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    [self.contentView addSubview:self.headerImage];
    [self.contentView addSubview:self.nameLable];
    [self.contentView addSubview:self.phoneLable];
    [self.contentView addSubview:self.stauteLable];
    [self.contentView addSubview:self.timeLable];
    [self.contentView addSubview:self.linewView];
    
    [self.headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).mas_offset(ZY_WidthScale(15));
        make.width.height.equalTo(@(ZY_HeightScale(55)));
    }];
    
    [self.stauteLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).mas_offset(-ZY_WidthScale(15));
        make.top.equalTo(self.headerImage.mas_top).mas_offset(ZY_HeightScale(6));
    }];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImage.mas_right).mas_offset(ZY_WidthScale(16));
        make.top.equalTo(self.headerImage.mas_top).mas_offset(ZY_HeightScale(6));
        make.right.equalTo(self.stauteLable.mas_left).mas_offset(-ZY_WidthScale(10));
    }];
    
    [self.phoneLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLable);
        make.top.equalTo(self.nameLable.mas_bottom).mas_offset(ZY_HeightScale(16));
    }];
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.stauteLable);
        make.top.equalTo(self.stauteLable.mas_bottom).mas_offset(ZY_HeightScale(16));
    }];
    [self.linewView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImage);
        make.right.equalTo(self.timeLable.mas_right);
        make.bottom.equalTo(self.contentView);
        make.height.equalTo(@1);
    }];
}

- (void)setModel:(GHMyInvitationListModel *)model{
    _model = model;
    if (model.head.length == 0) {
        self.headerImage.image = Images(@"AppIcon");
    }else{
        [self.headerImage sd_setImageWithURL:[NSURL URLWithString:model.head]];
    }
    self.nameLable.text = model.nickName;
    self.phoneLable.text = model.phone;
    self.stauteLable.text = model.userStatus;
    self.timeLable.text = [GH_Tools transToTimeStemp:model.createTime dateFormatter:@"yyyy-MM-dd HH:mm:ss"];
}

- (UIImageView *)headerImage{
    if (!_headerImage) {
        _headerImage = [UIImageView new];
        _headerImage.backgroundColor = [UIColor redColor];
        _headerImage.layer.cornerRadius = ZY_HeightScale(27.5);
        _headerImage.clipsToBounds = YES;
    }
    return _headerImage;
}
-(UILabel *)nameLable{
    if (!_nameLable) {
        _nameLable = [UILabel new];
        _nameLable.text = @"王律师";
        _nameLable.textColor = Colors(@"#333333");
        _nameLable.font = Fonts(16);
    }
    return _nameLable;
}
- (UILabel *)phoneLable{
    if (!_phoneLable) {
        _phoneLable = [UILabel new];
        _phoneLable.text = @"123456789";
        _phoneLable.textColor = Colors(@"#4C4C4C");
        _phoneLable.font = Fonts(15);
    }
    return _phoneLable;
}

- (UILabel *)stauteLable{
    if (!_stauteLable) {
        _stauteLable = [UILabel new];
        _stauteLable.text = @"已注册";
        _stauteLable.textColor = Colors(@"#333333");
        _stauteLable.font = Fonts(13);
        _stauteLable.textAlignment = NSTextAlignmentRight;
    }
    return _stauteLable;
}

- (UILabel *)timeLable{
    if (!_timeLable) {
        _timeLable = [UILabel new];
        _timeLable.text = @"20/01/01 13:14:52";
        _timeLable.textColor = Colors(@"#888888");
        _timeLable.font  = Fonts(13);
    }
    return _timeLable;
}

- (UIView *)linewView{
    if (!_linewView) {
        _linewView = [UIView new];
        _linewView.backgroundColor =Colors(@"#DEDDDD");
    }
    return _linewView;
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
