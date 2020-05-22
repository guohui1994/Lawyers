//
//  GH_BuyLawyerServiceViewController.h
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/16.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "BaseViewController.h"
#import "GHBuyServiceLisetModelModel.h"
#import "GHRecommendModelModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GH_BuyLawyerServiceViewController : BaseViewController
@property (nonatomic, strong)GHBuyServiceLisetListModel * model;
@property (nonatomic, strong)GHRecommendListServicesModel * recommendModel;
@property (nonatomic, assign)NSInteger type;//1是推荐列表2是推送 3是正常
@property (nonatomic, assign)NSInteger laywersID;
@end

NS_ASSUME_NONNULL_END
