//
//  GH_CustomNavBarView.m
//  GH_CustomerNav
//
//  Created by ZhiYuan on 2019/6/1.
//  Copyright © 2019 ZhiYuan. All rights reserved.

//屏幕宽度
#define screenWidth [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define is_IPhone_X [[UIApplication sharedApplication] statusBarFrame].size.height >20 ? YES:NO
//状态栏的高度
#define Height_StatusBar (is_IPhone_X==YES)?44.0f: 20.0f
//导航栏的高度
#define Height_NavBar (is_IPhone_X==YES)?88.0f: 64.0f



#import "GH_CustomNavBarView.h"
//#import "UIColor+GH_Extension.h"


#pragma mark ------ 创建左边返回view
@class GH_CustomNavBarViewLeftView;
@interface GH_CustomNavBarViewLeftView : UIView
@property (nonatomic, strong)UIImageView * backImageView;//返回图片
@property (nonatomic, strong)UILabel * backLable;//返回lable
@property (nonatomic, copy)NSString * backText;//返回按钮的文字
@end

@implementation GH_CustomNavBarViewLeftView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatLeftView];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (instancetype)customeNavBarViewLeftView{
    return [[GH_CustomNavBarViewLeftView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
}
/*添加返回按钮和返回标题*/
- (void)creatLeftView{
    [self addSubview:self.backImageView];
    [self addSubview:self.backLable];
    [self layout];
}
/*设置Frame*/
- (void)layout{
    self.backImageView.frame = CGRectMake(20, 14, 9, 17);
    self.backLable.frame = CGRectMake(35, 0, 35, 44);
}

/*leftView的懒加载*/
- (UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc]init];
        _backImageView.userInteractionEnabled = YES;
        _backImageView.image = [UIImage imageNamed:@"back"];
        _backImageView.hidden = YES;
    }
    return _backImageView;
}

- (UILabel *)backLable{
    if (!_backLable) {
        _backLable = [[UILabel alloc]init];
        _backLable.text = @"";
        _backLable.font = [UIFont systemFontOfSize:18];
        _backLable.textColor = [UIColor blackColor];
        _backLable.userInteractionEnabled = YES;
        _backLable.textAlignment = NSTextAlignmentLeft;
    }
    return _backLable;
}


//set方法为返回按钮的标题赋值
- (void)setBackText:(NSString *)backText{
    if(_backText != backText )
    {
        _backText = backText;
    }
    _backImageView.hidden = NO;
    self.backLable.text = backText;
}
@end

#pragma mark -------创建导航栏右侧View以及i点击方法
@class GH_CustomNavBarViewRightView;
@interface GH_CustomNavBarViewRightView : UIView
@property (nonatomic, strong)UIImageView * rightImageView;
@property(nonatomic, copy)NSString * rightImageString;
@end
@implementation GH_CustomNavBarViewRightView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self creatRightView];
    }
    return self;
}
- (void)creatRightView{
    [self addSubview:self.rightImageView];
    [self layout];
}
-(void)layout{
    self.rightImageView.frame = CGRectMake(15, 0, 70, 44);
}
- (UIImageView *)rightImageView{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc]init];
        _rightImageView.userInteractionEnabled = YES;
        _rightImageView.hidden = YES;
    }
    return _rightImageView;
}

/*右边的image的set方法*/
- (void)setRightImageString:(NSString *)rightImageString{
    if (_rightImageString != rightImageString) {
        _rightImageString = rightImageString;
    }
    _rightImageView.hidden = NO;
    self.rightImageView.image = [UIImage imageNamed:rightImageString];
}

@end


#pragma mark ------自定义导航栏View
@interface GH_CustomNavBarView (){
    CAGradientLayer *gradientLayer;
}
@property (nonatomic, strong)GH_CustomNavBarViewLeftView * leftView;
@property (nonatomic, strong)GH_CustomNavBarViewRightView * rightView;
@property (nonatomic, strong)UILabel * titleLable;
@property (nonatomic, strong)UIImageView * backGroundImageView;
@end
@implementation GH_CustomNavBarView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        /*在layer上添加逐渐变色-----必须是先添加layer再添加空间, 否则控件不会显示*/
       gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"#FFAB50"].CGColor,(__bridge id)[UIColor colorWithHexString:@"#FF9250"].CGColor];
        gradientLayer.locations = @[@0.0, @1.0];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1.0, 0);
        gradientLayer.frame = CGRectMake(0, 0,  screenWidth,  Height_NavBar);
        [self.layer addSublayer:gradientLayer];
        gradientLayer.hidden = YES;
        [self creatNavBarView];
    }
    return self;
}

+ (instancetype)customNavBarView{
    return [[GH_CustomNavBarView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, Height_NavBar)];
}

- (void)creatNavBarView{
    [self addSubview:self.backGroundImageView];
    [self addSubview:self.leftView];
    [self addSubview:self.rightView];
    [self addSubview:self.titleLable];
    [self layout];
}
- (void)layout{
    self.leftView.frame = CGRectMake(0, Height_StatusBar, 100, 44);
    self.rightView.frame = CGRectMake(screenWidth - 70, Height_StatusBar, 70, 44);
    self.titleLable.frame = CGRectMake(70, Height_StatusBar, screenWidth - 140, 44);
    self.backGroundImageView.frame = CGRectMake(0, 0, screenWidth, Height_NavBar);
}
- (GH_CustomNavBarViewLeftView *)leftView{
    if (!_leftView) {
        _leftView = [[GH_CustomNavBarViewLeftView alloc]init];
        UITapGestureRecognizer * backTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backController)];
        [_leftView addGestureRecognizer:backTapGesture];
    }
    return _leftView;
}
- (GH_CustomNavBarViewRightView *)rightView{
    if (!_rightView) {
        _rightView = [[GH_CustomNavBarViewRightView alloc]init];
        _rightView.hidden = YES;
        _rightView.userInteractionEnabled = YES;
        UITapGestureRecognizer * rightViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightViewTaps)];
        [_rightView addGestureRecognizer:rightViewTap];
    }
    return _rightView;
}
- (UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc]init];
        _titleLable.font = [UIFont systemFontOfSize:18];
        _titleLable.text = @"hello,world!";
        _titleLable.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLable;
}
- (UIImageView *)backGroundImageView{
    if (!_backGroundImageView) {
        _backGroundImageView = [[UIImageView alloc]init];
        _backGroundImageView.hidden = YES;
    }
    return _backGroundImageView;
}


/*设置标题*/
- (void)setTitleString:(NSString *)titleString{
    if (_titleString != titleString) {
        _titleString = titleString;
    }
    self.titleLable.text = titleString;
}
/*设置返回按钮的文字*/
- (void)setBackText:(NSString *)backText{
    if (_backText != backText) {
        _backText = backText;
    }
    self.leftView.backText = backText;
}
/*设置导航栏的背景图片*/
- (void)setBackGroundImageString:(NSString *)backGroundImageString{
    if (_backGroundImageString != backGroundImageString) {
        _backGroundImageString = backGroundImageString;
    }
    self.backGroundImageView.image = [UIImage imageNamed:backGroundImageString];
    self.backGroundImageView.hidden = NO;
}
/*设置导航栏颜色渐变-----是否显示, 显示就是YES, 不显示就是NO*/
- (void)setIsShowBgColor:(BOOL)isShowBgColor{
    if (_isShowBgColor != isShowBgColor) {
        _isShowBgColor = isShowBgColor;
        _titleLable.textColor = [UIColor whiteColor];
    }
    if (isShowBgColor == YES) {
        
        gradientLayer.hidden = NO;
    }
}

/*设置导航栏右侧view的image*/
- (void)setRightViewImageUrl:(NSString *)rightViewImageUrl{
    if (_rightViewImageUrl != rightViewImageUrl) {
        _rightViewImageUrl = rightViewImageUrl;
    }
    _rightView.hidden = NO;
    self.rightView.rightImageString = rightViewImageUrl;
}


/*设置返回的点击方法*/
- (void)backController{
    if (self.delegate && [self.delegate respondsToSelector:@selector(backController)]) {
        [self.delegate backController];
    }
}
/*右侧按钮的响应方法*/
- (void)rightViewTaps{
    if (self.delegate && [self.delegate respondsToSelector:@selector(rightViewClick)]) {
        [self.delegate rightViewClick];
    }
}


@end
