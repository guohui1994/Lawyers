//
//  GH_BuyServiceVCFooterView.h
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/16.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHBuyServiceLisetModelModel.h"
#import "GHRecommendModelModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^payMessage)(NSString * beiZhuMessage, NSInteger payWay);

@interface GH_BuyServiceVCFooterView : UIView
@property (nonatomic, strong)payMessage block;
@property (nonatomic, assign)double orderAmount;//支付定金
@property (nonatomic, assign)int despositReuired;
@property (nonatomic, strong)GHBuyServiceLisetListModel * model;
@property (nonatomic, strong)GHRecommendListServicesModel * recommendModel;
@end

NS_ASSUME_NONNULL_END
