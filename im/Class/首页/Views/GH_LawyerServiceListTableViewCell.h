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
#import "GHLeaveMessageResultModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GH_LawyerServiceListTableViewCell : UITableViewCell

//是否隐藏服务号
@property (nonatomic, assign)BOOL isHiddenServiceNumber;
@property (nonatomic, assign)BOOL isHiddenMoney;
//购买服务数据model
@property (nonatomic, strong)GHBuyServiceLisetListModel * model;
//已经购买服务数据model
@property (nonatomic, strong)GHAlreadyBuyServiceListListModel * alreadyBuyServiceModel;

@property (nonatomic, strong)GHLeaveMessageResultModel * leaveMessageModel;


@end

NS_ASSUME_NONNULL_END
