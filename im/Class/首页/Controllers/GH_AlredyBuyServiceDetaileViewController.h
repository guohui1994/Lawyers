//
//  GH_AlredyBuyServiceDetaileViewController.h
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/16.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "BaseViewController.h"
#import "GHAlreadyBuyServiceListModel.h"
#import "GHRecommendModelModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GH_AlredyBuyServiceDetaileViewController : BaseViewController
//点击已购买服务列表传过来的model
@property (nonatomic, strong)GHAlreadyBuyServiceListListModel * model;
@property (nonatomic, strong)GHRecommendListServicesOrderModel * recommendModel;
@property (nonatomic, assign)NSInteger orderID;
@property (nonatomic, assign)NSInteger type;//1是推荐服务列表  2是极光推送 3是正常
@end

NS_ASSUME_NONNULL_END
