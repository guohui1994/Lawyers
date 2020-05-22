//
//  GH_LeaveMessageResultViewController.h
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/11.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "BaseViewController.h"
#import "GHLeaveMessageResultModel.h"
#import "GHRecommendModelModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GH_LeaveMessageResultViewController : BaseViewController
@property (nonatomic, strong)GHLeaveMessageResultModel * model;
@property (nonatomic, assign)NSInteger leaveMessageID;//
@property (nonatomic, assign)NSInteger type;//1是极光推送2是
@end

NS_ASSUME_NONNULL_END
