//
//  GH_QuestionDetailTableViewCell.h
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/21.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHQuestionListModelModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GH_QuestionDetailTableViewCell : UITableViewCell
@property (nonatomic, strong)GHQuestionListModelModel * model;
@end

NS_ASSUME_NONNULL_END
