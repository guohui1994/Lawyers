//
//  GH_PersionMessageTableViewCell.h
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/12.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GH_PersionMessageTableViewCell : UITableViewCell

@property(nonatomic, assign)BOOL isShowHearder;//显示头像

@property (nonatomic, copy)NSString * titleString;//标题数组

@property (nonatomic, assign)BOOL isShowLineView;//是否显示分割线;

@property (nonatomic, assign)BOOL isHidenRightBackImage;

@property (nonatomic, copy)NSString * contentString;//内容
@end

NS_ASSUME_NONNULL_END
