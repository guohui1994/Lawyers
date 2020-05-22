//
//  ZYMessageTopView.m
//  Lawyers_Use
//
//  Created by 郭军 on 2019/9/19.
//  Copyright © 2019 JG. All rights reserved.
//

#import "ZYMessageTopView.h"

@interface ZYMessageTopView ()

@property(nonatomic, strong) UIImageView *Icon;
@property(nonatomic, strong) UILabel *NameLbl;
@property(nonatomic, strong) UILabel *DetailLbl;
@property(nonatomic, strong) UILabel *TimeLbl;
///角标（UIView）
@property(nonatomic, strong) UILabel *BadgeView;


@end


@implementation ZYMessageTopView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    
    UIView *TopLine = [UIView new];
    TopLine.backgroundColor = Colors(@"#F2F2F2");
    
    _Icon = [UIImageView new];
    _Icon.clipsToBounds = YES;
    _Icon.layer.cornerRadius = 15.0f;
//    _Icon.backgroundColor = [UIColor redColor];
    _Icon.image = Images(@"iCon");
    
    _NameLbl = [UILabel new];
    _NameLbl.textColor = Colors(@"#333333");
    _NameLbl.text = @"系统消息";
    _NameLbl.font = Fonts(16);
    
    
    _DetailLbl = [UILabel new];
    _DetailLbl.textColor = Colors(@"#4C4C4C");
//    _DetailLbl.text = @"是超级女神承诺书";
    _DetailLbl.font = Fonts(15);
    
    _TimeLbl = [UILabel new];
    _TimeLbl.textColor = Colors(@"#888888");
//    _TimeLbl.text = @"2019/10/24";
    _TimeLbl.font = Fonts(13);
    
    
    //角标
    _BadgeView = [UILabel new];
    _BadgeView.textColor = [UIColor whiteColor];
    _BadgeView.font = Fonts(11);
    _BadgeView.clipsToBounds = YES;
    _BadgeView.layer.cornerRadius = 7.5f;
    _BadgeView.textAlignment = NSTextAlignmentCenter;
    _BadgeView.backgroundColor = [UIColor redColor];
    _BadgeView.hidden = YES;
//    _BadgeView.text = @"1";
    
    UIView *Line = [UIView new];
    Line.backgroundColor = Colors(@"#DEDDDD");
    
    [self addSubview:TopLine];
    [self addSubview:_Icon];
    [self addSubview:_NameLbl];
    [self addSubview:_DetailLbl];
    [self addSubview:_TimeLbl];
    [self addSubview:Line];
    [self addSubview:_BadgeView];
    
    
    [TopLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(@(10));
    }];
    
    [_Icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).mas_offset(-11);
        make.left.equalTo(self.mas_left).mas_offset(15);
        make.width.height.equalTo(@(55));
    }];
    
    [_NameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.Icon.mas_centerY).mas_offset(-5);
        make.left.equalTo(self.Icon.mas_right).mas_offset(14);
    }];
    
    [_DetailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.Icon.mas_centerY).mas_offset(5);
        make.left.equalTo(self.NameLbl.mas_left);
        make.right.equalTo(self.mas_right).mas_offset(-40);
    }];
    
    [_TimeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.NameLbl.mas_centerY);
        make.right.equalTo(self.mas_right).mas_offset(-15);
    }];
    
    [_BadgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).mas_offset(-15);
        make.right.equalTo(self.TimeLbl.mas_right);
        make.width.height.equalTo(@(15));
    }];
    
    [Line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self).with.insets(UIEdgeInsetsMake(0, 15, 0, 15));
        make.height.equalTo(@(1));
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
}

- (void)tapClick {
    
    if (self.backInfo) {
        self.backInfo();
    }
}

- (void)setSysMsgModel:(GHLastMessageModel *)SysMsgModel {
    _SysMsgModel = SysMsgModel;

    _DetailLbl.text = SysMsgModel.title;

    _TimeLbl.text = [GH_Tools transToTimeStemp:SysMsgModel.createTime dateFormatter:@"yyyy/MM/dd"];

    _BadgeView.hidden = SysMsgModel.count == 0;
    _BadgeView.text = @(SysMsgModel.count).stringValue;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
