//
//  GH_BuyLawyerServiceTableViewCell.h
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/16.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHBuyServiceLisetModelModel.h"
#import "GHAlreadyBuyServiceListModel.h"
#import "GHOrderListModel.h"
#import "GHRecommendModelModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GH_BuyLawyerServiceTableViewCell : UITableViewCell
//是否显示状态Lable
@property (nonatomic, assign)BOOL isShowStateLable;
//是否显示尾款Lable
@property (nonatomic, assign)BOOL isShowWeiKuanLable;
//状态lable
@property (nonatomic, copy)NSString * stateString;
//服务列表的model 
@property (nonatomic, strong)GHBuyServiceLisetListModel * model;
//已购买服务的model
@property (nonatomic, strong)GHAlreadyBuyServiceListListModel * alreadyServiceModel;
//订单model
@property(nonatomic, strong)GHOrderListListModel * orderModel;

@property (nonatomic, strong)GHRecommendListServicesModel * recommendModel;

@end



NS_ASSUME_NONNULL_END
