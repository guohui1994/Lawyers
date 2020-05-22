//
//  GH_CustomNavBarView.h
//  GH_CustomerNav
//
//  Created by ZhiYuan on 2019/6/1.
//  Copyright © 2019 ZhiYuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GH_CustomNavBarDelegate <NSObject>
@optional
- (void)backController;
- (void)rightViewClick;
@end

@interface GH_CustomNavBarView : UIView

//导航栏标题
@property (nonatomic, strong)NSString * titleString;
//返回按钮文字
@property (nonatomic, copy)NSString * backText;
//返回按钮的代理
@property (nonatomic, weak)id<GH_CustomNavBarDelegate>delegate;
//背景图片url, 如果要添加导航栏背景的话就设置图片的url
@property (nonatomic, copy)NSString * backGroundImageString;
//是否显示背景色渐变
@property (nonatomic, assign)BOOL isShowBgColor;

//导航栏右侧view的url
@property (nonatomic, copy)NSString * rightViewImageUrl;


+ (instancetype)customNavBarView;
@end


