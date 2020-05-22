//
//  GH_SystemMessageTableViewCell.h
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/17.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHAllMessageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GH_SystemMessageTableViewCell : UITableViewCell
@property (nonatomic, strong)GHAllMessageListModel * model;
@end

NS_ASSUME_NONNULL_END
