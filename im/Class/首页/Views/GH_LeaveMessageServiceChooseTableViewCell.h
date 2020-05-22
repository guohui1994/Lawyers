//
//  GH_LeaveMessageServiceChooseTableViewCell.h
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/11.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHLeaveMessageSelectLableModel.h"
typedef void(^seletIndex)(NSInteger index);

@interface GH_LeaveMessageServiceChooseTableViewCell : UITableViewCell
@property (nonatomic, strong)seletIndex block;
@property (nonatomic, strong)NSArray * selectLabelArray;//标签数组
@end


