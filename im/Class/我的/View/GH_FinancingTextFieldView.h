//
//  GH_FinancingTextFieldView.h
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/12.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GH_FinancingTextFieldView : UIView

@property(nonatomic, copy)NSString * titleString;
@property (nonatomic, copy)NSString * placeholder;
@property (nonatomic, strong)UIView * lineView;
@property (nonatomic, strong)UITextField * textField;
@end

NS_ASSUME_NONNULL_END
