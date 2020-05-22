//
//  GH_SystemMessageTableViewCell.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/17.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_SystemMessageTableViewCell.h"

@interface GH_SystemMessageTableViewCell ()
@property (nonatomic, strong)UILabel * timeLable;//时间
@property (nonatomic, strong)UIView * bgVIew;//黄色背景
@property (nonatomic, strong)UILabel * contentsLable;//内容
@property (nonatomic, strong)UILabel * titleLable;//标题
@end
@implementation GH_SystemMessageTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    [self.contentView addSubview:self.timeLable];
    [self.contentView addSubview:self.bgVIew];
    [self.bgVIew addSubview:self.titleLable];
    [self.bgVIew addSubview:self.contentsLable];
    [self layout];
}

-(void)layout{
   self.timeLable.sd_layout
    .centerXEqualToView(self.contentView)
    .topSpaceToView(self.contentView, ZY_HeightScale(8))
    .widthIs(ZY_WidthScale(153))
    .heightIs(ZY_HeightScale(25));
    
    self.bgVIew.sd_layout
    .leftSpaceToView(self.contentView, ZY_WidthScale(15))
    .rightSpaceToView(self.contentView, ZY_WidthScale(15))
    .topSpaceToView(self.timeLable, ZY_HeightScale(22))
    .autoHeightRatio(0);
    
    
    self.titleLable.sd_layout
    .centerXEqualToView(self.bgVIew)
    .topSpaceToView(self.bgVIew, ZY_HeightScale(15))
    .widthIs(screenWidth - ZY_WidthScale(30))
    .autoHeightRatio(0);
    
    self.contentsLable.sd_layout
    .leftSpaceToView(self.bgVIew, ZY_WidthScale(12))
    .rightSpaceToView(self.bgVIew, ZY_WidthScale(12))
    .topSpaceToView(self.titleLable, ZY_HeightScale(15))
    .autoHeightRatio(0);
    
    [self.bgVIew setupAutoHeightWithBottomView:self.contentsLable bottomMargin:ZY_HeightScale(18)];
    [self setupAutoHeightWithBottomView:self.bgVIew bottomMargin:ZY_HeightScale(10)];
}


- (void)setModel:(GHAllMessageListModel *)model{
    _model = model;
    _timeLable.text = [GH_Tools transToTimeStemp:model.createTime dateFormatter:@"yyyy-MM-dd HH:mm"];
    _contentsLable.text = [model.content emptyBeforeParagraph];
    _titleLable.text = model.title;
}

- (UILabel *)timeLable{
    if (!_timeLable) {
        _timeLable = [UILabel new];
        _timeLable.backgroundColor = Colors(@"#F7F7F7");
        _timeLable.sd_cornerRadius =  @(ZY_WidthScale(13));
        _timeLable.clipsToBounds = YES;
        _timeLable.text = @"2019/09/10  12:19";
        _timeLable.font =Fonts(13);
        _timeLable.textAlignment = NSTextAlignmentCenter;
        _timeLable.textColor = Colors(@"#888888");
    }
    return _timeLable;
}

- (UIView *)bgVIew{
    if (!_bgVIew) {
        _bgVIew = [UIView new];
        _bgVIew.backgroundColor = Colors(@"#FEFBEF");
    }
    return _bgVIew;
}

- (UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [UILabel new];
//        _titleLable.text = @"";
        _titleLable.font = Fonts(15);
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.textColor = Colors(@"#333333");
    }
    return _titleLable;
}


- (UILabel *)contentsLable{
    if (!_contentsLable) {
        _contentsLable = [UILabel new];
       
        _contentsLable.font = Fonts(15);
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
