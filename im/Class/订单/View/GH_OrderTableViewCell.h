//
//  GH_OrderTableViewCell.h
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/17.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHOrderListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GH_OrderTableViewCell : UITableViewCell
//type 0 进行中 1是已完成 2是已评价
@property (nonatomic, assign)int type;

@property (nonatomic, strong)GHOrderListListModel * model;

@property (nonatomic, strong)UIButton * clickButton;//已完成   评价订单  评价内容按钮
@end

NS_ASSUME_NONNULL_END
