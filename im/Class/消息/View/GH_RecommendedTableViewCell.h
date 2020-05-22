//
//  GH_RecommendedTableViewCell.h
//  im
//
//  Created by ZhiYuan on 2020/4/22.
//  Copyright © 2020 郭徽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHRecommendModelModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GH_RecommendedTableViewCell : UITableViewCell
@property (nonatomic, strong)GHRecommendListModel * model;
@end

NS_ASSUME_NONNULL_END
