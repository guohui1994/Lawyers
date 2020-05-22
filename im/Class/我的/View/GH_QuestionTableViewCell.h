//
//  GH_QuestionTableViewCell.h
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/20.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHQuestionListModelModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GH_QuestionTableViewCell : UITableViewCell
@property (nonatomic, strong)GHQuestionListModelModel * model;
@end

NS_ASSUME_NONNULL_END
