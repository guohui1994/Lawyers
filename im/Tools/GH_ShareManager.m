//
//  GH_ShareManager.m
//  AudioChang
//
//  Created by ZhiYuan on 2019/9/4.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_ShareManager.h"
static GH_ShareManager * singleton = nil;

@interface GH_ShareManager ()
//黑色透明
@property (nonatomic, strong)UIView * backGroundView;
//分享界面
@property (nonatomic, strong)UIView * shareView;
//取消
@property (nonatomic, strong)UIButton * cancle;

@property (nonatomic, assign)NSInteger tag;
@end

@implementation GH_ShareManager

+(GH_ShareManager *)shareSingleton{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[GH_ShareManager alloc]init];
    });
    return singleton;
}

-(void)creatShrarView:(Type)type{
    [self creatUI:type];
}

//创建背景
- (void)creatUI:(NSInteger)type{
    self.backGroundView = [UIView new];
    self.backGroundView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    self.backGroundView.backgroundColor = [Colors(@"#000000") colorWithAlphaComponent:0.4];
    self.backGroundView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backGroundViewRemoveFromSuperView)];
    [self.backGroundView addGestureRecognizer:tap ];
    [[UIApplication sharedApplication].keyWindow addSubview:self.backGroundView];
 
    [self creatShareUI:type];
    
    /*取消页面*/
    self.cancle = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancle setTitle:@"取消" forState:UIControlStateNormal];
    self.cancle.titleLabel.font = Fonts(17);
    [self.cancle setTitleColor:Colors(@"#333333") forState:UIControlStateNormal];
    self.cancle.layer.cornerRadius = ZY_WidthScale(10);
    self.cancle.backgroundColor = [UIColor whiteColor];
    [self.cancle addTarget:self action:@selector(backGroundViewRemoveFromSuperView) forControlEvents:UIControlEventTouchDown];
    [self.backGroundView addSubview:self.cancle];
    [self.cancle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backGroundView).mas_offset(10);
        make.right.equalTo(self.backGroundView).mas_offset(-10);
        make.bottom.equalTo(self.backGroundView).mas_offset(-ZY_HeightScale(5));
        make.height.equalTo(@(ZY_HeightScale(45)));
    }];
}


- (void)creatShareUI:(NSInteger)type{
    
    self.shareView = [UIView new];
    self.shareView.backgroundColor = [UIColor whiteColor];
    self.shareView.layer.cornerRadius = ZY_WidthScale(15);
    self.shareView.clipsToBounds = YES;
   
    NSMutableArray * temp = [NSMutableArray new];
    NSArray * titleArray = @[];
    int itemCount = 0;
    
    
   
    if (type == ShareWithThirdWithSaveDefault) {
         [self.backGroundView addSubview:_shareView];
        [self.shareView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backGroundView).mas_offset(10);
            make.right.equalTo(self.backGroundView).mas_offset(-10);
            make.bottom.equalTo(self.backGroundView).mas_offset(-60);
            make.height.equalTo(@(ZY_HeightScale(204)));
        }];
        UIView * lineView = [UIView new];
        lineView.backgroundColor = Colors(@"#E3E4E7");
        [self.shareView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.width.equalTo(self.shareView);
            make.height.equalTo(@(1));
        }];
        titleArray = @[@"QQ好友", @"QQ空间", @"微信朋友", @"朋友圈", @"保存本地", @"二维码", @"生成链接", @"一键复制"];
        itemCount = 8;
    }else{
         [self.backGroundView addSubview:_shareView];
        [self.shareView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backGroundView).mas_offset(10);
            make.right.equalTo(self.backGroundView).mas_offset(-10);
            make.bottom.equalTo(self.backGroundView).mas_offset(-60);
            make.height.equalTo(@(ZY_HeightScale(180)));
        }];
        UILabel * shareLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, screenWidth - 20, ZY_HeightScale(50))];
        shareLable.text = @"分享到";
        shareLable.font = Fonts(17);
        shareLable.textColor = Colors(@"#333333");
        shareLable.textAlignment = NSTextAlignmentCenter;
        [self.shareView addSubview:shareLable];
        
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, shareLable.bottom, screenWidth - 20, 1)];
        lineView.backgroundColor = Colors(@"#E3E4E7");
        [self.shareView addSubview:lineView];
        
        titleArray = @[@"QQ好友", @"QQ空间", @"微信朋友", @"朋友圈",];
        itemCount = 4;
       
    }
    
    
    for (int i = 0; i < itemCount; i++) {
        UIButton * itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        itemButton.tag = 2019111 + i;
        [itemButton addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchDown];
        if (itemCount == 4) {
            itemButton.frame = CGRectMake((screenWidth - 20)/4 * i, ZY_HeightScale(52),(screenWidth - 20) / 4, ZY_HeightScale(128));
            [self.shareView addSubview:itemButton];
        }else{
             [self.shareView addSubview:itemButton];
            itemButton.sd_layout
            .heightIs(ZY_HeightScale(102));
            
        }
         [temp addObject:itemButton];
        
        UIImageView * iconImageView = [UIImageView new];
        iconImageView.backgroundColor = [UIColor redColor];
        [itemButton addSubview:iconImageView];
        iconImageView.sd_layout
        .centerXEqualToView(itemButton)
        .topSpaceToView(itemButton, ZY_HeightScale(17))
        .widthIs(ZY_WidthScale(47))
        .heightIs(ZY_WidthScale(47));
        iconImageView.sd_cornerRadius = @(ZY_WidthScale(23.5));
        
        UILabel * titleLable = [UILabel new];
        titleLable.text = titleArray[i];
        titleLable.font = Fonts(15);
        titleLable.textColor = Colors(@"#222222");
        titleLable.textAlignment = NSTextAlignmentCenter;
        [itemButton addSubview:titleLable];
        titleLable.sd_layout
        .centerXEqualToView(itemButton)
        .topSpaceToView(iconImageView, ZY_HeightScale(10))
        .widthRatioToView(itemButton, 1)
        .heightIs(ZY_HeightScale(14));
        
    }
    
    if (type == ShareWithThirdWithSaveDefault) {
        [self.shareView setupAutoWidthFlowItems:temp withPerRowItemsCount:4 verticalMargin:0 horizontalMargin:0 verticalEdgeInset:0 horizontalEdgeInset:0];
    }else{

    }
    
}

- (void)backGroundViewRemoveFromSuperView{
    [UIView animateWithDuration:0.25 animations:^{
        self.shareView.transform = CGAffineTransformMakeTranslation(0,  ZY_HeightScale(264));
        self.cancle.transform = CGAffineTransformMakeTranslation(0, ZY_HeightScale(300));
    } completion:^(BOOL finished) {
        [self.backGroundView removeFromSuperview];
    }];
}

- (void)itemClick:(UIButton *)sender{
   
    if (self.block) {
        self.block(sender.tag - 2019111);
    }
    [self backGroundViewRemoveFromSuperView];
}

@end
