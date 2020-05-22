//
//  GH_LeaveMessageResultTableViewCell.h
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/11.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHLeaveMessageResultModel.h"
#import "GHAlreadyBuyServiceListModel.h"
#import "GHOrderListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GH_LeaveMessageResultTableViewCell : UITableViewCell
//留言
@property (nonatomic, strong)GHLeaveMessageResultModel * model;
//已经购买服务的model
@property (nonatomic, strong)GHAlreadyBuyServiceListListModel * alreadyModel;
//订单model
@property (nonatomic, strong)GHOrderListListModel * orderModel;
@end

NS_ASSUME_NONNULL_END
