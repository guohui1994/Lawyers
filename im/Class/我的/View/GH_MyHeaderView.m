//
//  GH_MyHeaderView.m
//  AudioChang
//
//  Created by ZhiYuan on 2019/9/2.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_MyHeaderView.h"

@interface GH_MyHeaderView ()
//图片
@property (nonatomic, strong)UIImageView * headerImage;
//白色View
@property (nonatomic, strong)UIView * whiteView;
//icon
@property (nonatomic, strong)UIImageView * iconImageView;
//nickLable
@property (nonatomic, strong)UILabel * nickLable;
//ID
@property(nonatomic, strong)UILabel * IDLable;
//消息
@property (nonatomic, strong)UIButton * messageButton;
//设置
@property (nonatomic, strong)UIButton * setButton;
//手机号
@property (nonatomic, strong)UILabel * phoneLable;
//性别
@property (nonatomic, strong)UIImageView * sexImageView;
@end


@implementation GH_MyHeaderView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    
    [self addSubview:self.headerImage];
    [self addSubview:self.whiteView];
    
    self.whiteView.layer.cornerRadius = ZY_WidthScale(15);
    [self.whiteView addSubview:self.iconImageView];
    [self.whiteView addSubview:self.nickLable];
    [self.whiteView addSubview:self.IDLable];
    [self.whiteView addSubview:self.phoneLable];
    [self.whiteView addSubview:self.sexImageView];
//    [self.whiteView addSubview:self.messageButton];
//    [self.whiteView addSubview:self.setButton];
    [self layout];
}

- (void)layout{
    self.headerImage.sd_layout
    .leftEqualToView(self)
    .topEqualToView(self)
    .rightEqualToView(self)
    .heightIs(ZY_HeightScale(180));
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).mas_offset(ZY_WidthScale(18));
        make.right.equalTo(self.mas_right).mas_offset(-ZY_WidthScale(18));
        make.top.equalTo(self.mas_top).mas_offset(ZY_HeightScale(93));
        make.height.equalTo(@(ZY_HeightScale(103)));
    }];
    
//    self.whiteView.sd_layout
//    .leftSpaceToView(self, ZY_WidthScale(18))
//    .rightSpaceToView(self, ZY_WidthScale(18))
//    .topSpaceToView(self, ZY_HeightScale(103))
//    .heightIs(ZY_HeightScale(103));
    
    self.iconImageView.sd_layout
    .leftSpaceToView(self.whiteView, ZY_WidthScale(38))
    .topSpaceToView(self.whiteView, ZY_HeightScale(22))
    .widthIs(ZY_WidthScale(60))
    .heightIs(ZY_WidthScale(60));
    
    self.nickLable.sd_layout
    .leftSpaceToView(self.iconImageView, ZY_WidthScale(31))
    .topSpaceToView(self.whiteView, ZY_HeightScale(23))
    .heightIs(ZY_HeightScale(17))
    .autoWidthRatio(0);
    [self.nickLable setSingleLineAutoResizeWithMaxWidth:ZY_WidthScale(160)];
    
self.sexImageView.sd_layout
    .leftSpaceToView(self.nickLable, ZY_WidthScale(10))
    .centerYEqualToView(self.nickLable)
    .widthIs(ZY_WidthScale(18))
    .heightIs(ZY_WidthScale(18));
    
    self.phoneLable.sd_layout
    .leftEqualToView(self.nickLable)
    .topSpaceToView(self.nickLable, ZY_HeightScale(10))
    .heightIs(ZY_HeightScale(13))
    .widthIs(ZY_WidthScale(160));
    
    self.IDLable.sd_layout
    .leftEqualToView(self.nickLable)
    .topSpaceToView(self.phoneLable, ZY_HeightScale(10))
    .heightIs(ZY_HeightScale(10))
    .autoWidthRatio(0);
    [self.IDLable setSingleLineAutoResizeWithMaxWidth:ZY_WidthScale(100)];
    
//    self.setButton.sd_layout
//    .rightSpaceToView(self.whiteView, ZY_WidthScale(10))
//    .centerYEqualToView(self.nickLable)
//    .widthIs(ZY_WidthScale(20))
//    .heightIs(ZY_WidthScale(20));
//
//    self.messageButton.sd_layout
//    .centerYEqualToView(self.setButton)
//    .rightSpaceToView(self.setButton, ZY_WidthScale(29))
//    .widthIs(ZY_WidthScale(20))
//    .heightIs(ZY_WidthScale(20));
}

- (UIImageView *)headerImage{
    if (!_headerImage) {
        _headerImage = [UIImageView new];
        _headerImage.image = Images(@"My_Header_BG");
        
       
        
    }
    return  _headerImage;
}

- (UIView *)whiteView{
    if (!_whiteView) {
        _whiteView = [[UIView alloc]init];

//        _whiteView.layer.cornerRadius = ZY_WidthScale(15);
//        _whiteView.clipsToBounds = YES;
        
        _whiteView.backgroundColor = [UIColor whiteColor];
        _whiteView.layer.shadowColor = Colors(@"#d8d0fa").CGColor;
        _whiteView.layer.shadowOffset = CGSizeMake(0,3);
        _whiteView.layer.masksToBounds = NO;
        _whiteView.layer.shadowRadius  = 3;
        _whiteView.layer.shadowOpacity = 0.2;
       _whiteView.layer.cornerRadius = 3;
       
    }
    return _whiteView;
}

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.sd_cornerRadius = @(ZY_WidthScale(30));
//        _iconImageView.backgroundColor = Colors(@"#E9E9EA");
        if ([Singleton defaultSingleton].UserHeaderImage.length == 0) {
            _iconImageView.image = Images(@"");
        }else{
//            [_iconImageView setImageWithURL:[NSURL URLWithString:[Singleton defaultSingleton].UserHeaderImage] placeholder:Images(@"")];
            [_iconImageView sd_setImageWithURL:[NSURL URLWithString:[Singleton defaultSingleton].UserHeaderImage] placeholderImage:Images(@"")];
        }
        _iconImageView.clipsToBounds = YES;
    }
    return _iconImageView;
}

- (UILabel *)nickLable{
    if (!_nickLable) {
        _nickLable = [UILabel new];
        _nickLable.text = [Singleton defaultSingleton].UserName;
        _nickLable.font = Fonts(17);
        _nickLable.textColor = Colors(@"#333333");
    }
    return _nickLable;
}

- (UIImageView *)sexImageView{
    if (!_sexImageView) {
        _sexImageView = [UIImageView new];
        if ([[Singleton defaultSingleton].UserSex isEqualToString:@"未知"]) {
            _sexImageView.image = Images(@"");
        }else if ([[Singleton defaultSingleton].UserSex isEqualToString:@"男"]){
            _sexImageView.image = Images(@"My_Sex_Man");
        }else{
            _sexImageView.image = Images(@"My_Sex_Woman");
        }
        
        
    }
    return _sexImageView;
}

- (UILabel *)IDLable{
    if (!_IDLable) {
        _IDLable = [UILabel new];
        _IDLable.text = [NSString stringWithFormat:@"ID:%@", [Singleton defaultSingleton].userID];
        _IDLable.textColor = Colors(@"#AFAFAE");
        _IDLable.font = Fonts(13);
        _IDLable.textAlignment = NSTextAlignmentCenter;
    }
    return _IDLable;
}

- (UIButton *)messageButton{
    if (!_messageButton) {
        _messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_messageButton setImage:Images(@"") forState:UIControlStateNormal];
        _messageButton.backgroundColor = [UIColor purpleColor];
        [_messageButton addTarget:self action:@selector(MessageClick) forControlEvents:UIControlEventTouchDown];
    }
    return _messageButton;
}

- (UIButton *)setButton{
    if (!_setButton) {
        _setButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_setButton setImage:Images(@"") forState:UIControlStateNormal];
        _setButton.backgroundColor = [UIColor lightGrayColor];
        [_setButton addTarget:self action:@selector(set) forControlEvents:UIControlEventTouchDown];
    }
    return _setButton;
}

- (UILabel *)phoneLable{
    if (!_phoneLable) {
        _phoneLable = [UILabel new];
        _phoneLable.text = [NSString stringWithFormat:@"手机号:%@", [Singleton defaultSingleton].UserPhone];
        _phoneLable.textColor = Colors(@"#333333");
        _phoneLable.font = Fonts(14);
    }
    return _phoneLable;
}


- (void)MessageClick{
    if (self.block) {
        self.block(0);
    }
}

- (void)set{
    if (self.block) {
        self.block(1);
    }
}

@end
