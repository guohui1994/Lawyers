//
//  GH_MyCenterView.m
//  AudioChang
//
//  Created by ZhiYuan on 2019/9/3.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_MyCenterView.h"

@implementation GH_MyCenterView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}


- (void)creatUI{
    
    
//    NSArray * titleArray = @[@"", @"常见问题", @"问题反馈", @"修改密码", @"关于我们", @"用户协议"];
    NSArray * titleArray = @[@"", @"常见问题", @"问题反馈",@"邀请好友", @"修改密码", @"关于我们", @"我的邀请",@"用户协议"];
    NSArray * imageArray = @[@"My_Center_1", @"My_Center_2", @"My_Center_3", @"yaoQingHaoYou",@"My_Center_4", @"My_Center_5", @"MyYaoQing",@"My_Center_6"];
    NSMutableArray * temp = [NSMutableArray new];
    for (int i = 0; i < 8; i++) {
         UIButton * clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
        clickButton.tag = 11021 + i;
        [clickButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
        
        [self addSubview:clickButton];
        clickButton.sd_layout
        .heightIs(ZY_HeightScale(95));
        
        UIImageView * iconImageView = [UIImageView new];
        iconImageView.image = Images(imageArray[i]);
        [clickButton addSubview:iconImageView];
        iconImageView.sd_layout
        .centerXEqualToView(clickButton)
        .topSpaceToView(clickButton, ZY_HeightScale(5))
        .widthIs(ZY_WidthScale(45))
        .heightIs(ZY_WidthScale(45));
        
        UILabel * lable = [UILabel new];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor = Colors(@"#333333");
        lable.tag =1102100 + i;
        lable.font = Fonts(16);
        lable.text = titleArray[i];
        [clickButton addSubview:lable];
        lable.sd_layout
        .centerXEqualToView(clickButton)
        .topSpaceToView(iconImageView, ZY_HeightScale(28))
        .widthRatioToView(clickButton, 1)
        .heightIs(ZY_HeightScale(16));
        
        [temp addObject:clickButton];
    }
    [self setupAutoWidthFlowItems:temp withPerRowItemsCount:4 verticalMargin:20 horizontalMargin:20 verticalEdgeInset:30 horizontalEdgeInset:0];
}

- (void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    UILabel * lable = [self viewWithTag:1102100];
    lable.text = titleString;
}


- (void)click:(UIButton *)sender{
    if (self.block) {
        self.block(sender.tag - 11021);
    }
}

@end
